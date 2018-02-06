desc 'upload neighborhood names and boundaries'
task :neighborhoods => :environment do

require 'aws/s3'
require 'rets'

# module RetsReader

  # @queue = :normal

    LOGIN_URL = 'http://connectmls-rets.mredllc.com/rets/server/login'
    LOGIN = ENV["RETS_LOGIN2"]
    PASSWORD = ENV["RETS_KEY2"]
    VERSION = 'RETS/1.7'
    INCLUDED_STATUSES = ['ACTV', 'AUCT', 'NEW', 'PCHG', 'BOMK', 'RACT', 'CTG', 'PEND']
    CLASSES = ['ResidentialProperty', 'RN']
    COLUMNS = ['prop_mlsid', 'status', 'cp', 'st_number', 'st_name', 'st_suffix',
    'unit', 'city', 'state', 'zip', 'latitude',
    'longitude', 'beds', 'baths_full', 'baths_half', 'parking', 'office',
    'lo_mlsid', 'la_fname', 'la_lname', 'description',
    'email', 'pets', 'modtime', 'picture_count', 'active']
  # system names for the columns above.
    COLUMNS_SYSTEM = ['LN', 'ST', 'CP', 'HSN', 'STR', 'STREETSUFFIX', 'UN', 'CIT', 'STATE',
    'ZP', 'LAT', 'LNG', 'BR', 'FULL_BATHS', 'HALF_BATHS', 'NO_PARKING_SPACES',
    'LONAME', 'LOID', 'LAFIRSTNAME', 'LALASTNAME', 'REMARKS', 'LAEMAIL', 'PTA',
    'UD', 'PHOTOCOUNT', 'ADI']
    ACCESS_KEY_ID = ENV["ACCESS_KEY_ID"]
    SECRET_ACCESS_KEY = ENV["SECRET_ACCESS_KEY"]
    S3_BUCKET_NAME = 'media.livebytransit.com'

  def self.perform

 client = Rets::Client.new({
   login_url: LOGIN_URL,
   username: LOGIN,
   password: PASSWORD,
   version: VERSION
   })

 begin
    client.login
 rescue => e
    puts 'Error: ' + e.message
    exit!
 end

# Get one property (again, based on TREB requirments)
# Get one property
# Pass :first or :all
# Then :search_type (Property, Agent, ...), :class (Condo, Commerical, ...), :query and :limit
ids = []
  if Listing.count > 0
    # todo: change start_time to start_time = 1.hour.ago.iso8601 then run update_listings every hour
  start_time = Listing.find_by_sql(
        'SELECT * FROM listings ' +
        'WHERE "modtime" IS NOT NULL ' +
        'ORDER BY "modtime" ' +
        'DESC LIMIT 1').
        first.modtime.iso8601
      start_time.gsub!(/[-,+]\d\d:\d\d/, '')
  else
    start_time = "2015-10-26T23:00:00"    #for initial download, UNLESS Listings not equal to
  end
  puts start_time
    CLASSES.each do |klass|
      size = 1
      offset = 0
      columns = COLUMNS.dup
      columns_system = COLUMNS_SYSTEM.dup
      included_statuses = INCLUDED_STATUSES.dup
      if klass == 'ResidentialProperty'
        columns << 'property_type'
        columns << 'price'
        columns_system << 'TYP'
        columns_system << 'LP'
      elsif klass == 'RN'
        columns << 'price'
        columns_system << 'RP'
        included_statuses.delete("AUCT")
      end
      #create a hash to store replacement keys
      ctcs = Hash.new
      (0..columns_system.size-1).each do |i|
          ctcs.store("#{columns_system[i]}", "#{columns[i]}")
      end
    # status_query = "(ST=#{included_statuses.join(",")})"
    # status_query = '(Timestamp_sql=#{start_time}+)'
    status_query = "(UD=#{start_time}+)"
    puts status_query
      while size > 0
        properties = client.find :all, {
          :no_records_not_an_error => true,
          search_type: 'Property',
          class: klass,
          #query: '(Timestamp_sql=2014-01-01T00:00:00+)',
          #query: '(LP=250000-500000)'
          query: status_query,
          limit: 2000,
          offset: offset,
          select: columns_system.join(',')
       }
        size = properties.size
        puts "size: #{size}"
        new_ids = []
        properties.each do |property|
          #Save the property to a JSON file. This is not necessary, but is it better or faster?
    #       File.open('property.json', 'w') do |file|
    #         file.write(JSON.pretty_generate property)
    #       end
        #replace keys in property hash with listing attributes
          listing_hash = Hash[property.map {|k, v| [ctcs[k], v] }]
          listing_id = listing_hash["prop_mlsid"]
    #       listing = Listing.where(:prop_mlsid => listing_id).first_or_create(listing_hash)
          if listing = Listing.find_by_prop_mlsid(listing_id)
            listing_hash.delete("city")
            listing.update_attributes(listing_hash)
#             puts "Listing #{listing.prop_mlsid} updated with new data"
          else
#           puts listing_hash
            #convert the city attribute to a city_id and delete the city attribute to avoid mismatch error
            city_name = listing_hash["city"].upcase
            city = City.where(name: city_name).first_or_create
            listing_hash.delete("city")
            listing = Listing.new(listing_hash)
            listing.city_id = city.id
            listing.address = "#{listing.st_number} #{listing.cp} #{listing.st_name} #{listing.st_suffix}"
            listing.cats = if listing.pets == 'no' then 'false' else 'true' end
            listing.dogs = listing.cats
            listing.laundry = if (listing.description =~ /([Ii]n-unit(,)?)+/) then '3' else '2' end
            listing.baths = listing.baths_full.to_i + (listing.baths_half.to_i > 0 ? 0.5 : 0)
            listing.active = true
            if klass == 'RN'
              listing.property_type = 'Residential Rental'
            end
            listing.save
            
            begin
              listing.update_geocode2
              puts listing.city.name
              if listing.city.name.strip.upcase == "CHICAGO"
                puts "We are about to find_school"
                listing.find_school
                listing.find_neighborhood
              end
            rescue => e
               puts 'Error: ' + e.message
            end
                      
            new_ids << listing.id
          end
        end # properties.each do
        ids.concat(new_ids)
        offset += 2000
        puts offset
      end # while size>1
      #now clean records
#       non_active = Listing.where('status not in (?)', INCLUDED_STATUSES).map(&:id).uniq
#       puts "deleting #{non_active.count} non_active listings for Class #{klass}..."
#       non_active.each do |listingid|
#         listing = Listing.find(listingid)
#         listing.destroy
#       end
      d = 0
      Listing.where('status not in (?)', INCLUDED_STATUSES).find_each do |listing|
#         x = Listing.where('status not in (?)', INCLUDED_STATUSES).pluck(:id)
#         x.each do |listing_id|
#           ids.delete(listing_id)
#           l = Listing.find(listing_id)
#           l.destroy
#         end
#         x = nil
#       puts "deleting #{non_active.count} non_active listings for Class #{klass}..."
        ids.delete(listing.id)
        listing.destroy
        d = d + 1
      end
      puts "#{d} listings destroyed"
      d = nil
# We will want to save the pictures after all properties have been downloaded and cleaned.
# so we need to update ids to remove listings that have been erased
#       ids = ids - non_active
  puts "#{ids.count} listings ready for picture update through Class #{klass}"

    end # Classes.each do

      puts 'Now save the pictures'

      AWS::S3::Base.establish_connection!(
        :access_key_id => ACCESS_KEY_ID,
        :secret_access_key => SECRET_ACCESS_KEY
      )
      puts 'connected to AWS'

      ids.each do |id|
        p = Listing.find(id)
        if p.ImageURLs
          next
        end
          photo_count = p.picture_count.to_i
          listing_id = p.prop_mlsid
        if photo_count < 1
          next
        end
        if listing_id.nil?
          next
        end
          puts photo_count
          puts listing_id
          photos = client.objects '*', {
             resource: 'Property',
             object_type: 'Photo',
             resource_id: listing_id
           }

        # Loop photos, split the response & save each photo to AWS bucket
          # -photos = Rets::Parser::Multipart.parse photo_list,
            image_urls = []
            photos.each_with_index do |data, index|
               filename = "#{listing_id}:#{index.to_s}.jpg"
               AWS::S3::S3Object.store(filename, data.body, S3_BUCKET_NAME)
               image_urls << "https://s3.amazonaws.com/#{S3_BUCKET_NAME}/#{filename}"
            end
            p.update_attributes(:ImageURLs => image_urls)
            puts image_urls
            p = nil
      end # pictures ids.each do
client.logout
end #def
end #module