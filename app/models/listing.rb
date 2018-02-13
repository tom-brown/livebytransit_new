class Listing < ApplicationRecord
  # Direct associations
  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  reverse_geocoded_by :lat, :lng

  belongs_to :neighborhood,
             :required => false

  belongs_to :city

  belongs_to :user,
             :required => false

  has_many   :listings_searches,
             :dependent => :destroy

  has_many   :showings,
             :dependent => :destroy

  has_many   :favorites,
             :dependent => :destroy
             
  has_many  :proxes,
            :dependent => :destroy

  # Indirect associations

  has_many   :searches,
             :through => :listings_searches,
             :source => :search
             
  has_many   :cta_stations,
            :through => :proxes

  # Validations
  
  def update_geocode2
    
    require 'net/http'
    require 'json'
    
    address = "#{self.st_num}+#{self.cp}+#{self.street}+#{self.city.name}+#{self.state}"
    # address = address.gsub!(/\+{1,}/,"+") #takes out multiple + and replaces with one +
    key = ENV["GEOCODE_KEY"]
    puts address
    url="https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{key}"
    
    uri = URI(url)

    response = Net::HTTP.get(uri)
    answer = JSON.parse(response)
    if answer['status'] == 'OK'
      self.lat = answer['results'][0]['geometry']['location']['lat']
      self.lng = answer['results'][0]['geometry']['location']['lng']
      self.save
    else
      p  answer['status']
    end
  end
  
  def self.cta_stations(ctastation_ids,max_distance)
            if ctastation_ids.present?
                if max_distance.present?
                  d = max_distance.to_f
                else
                  d = 0.8
                end
                trainstations = CtaStation.where(:id => ctastation_ids)
                finallistings = []
                # lats = trainstations.collect{|x| x.lat}
                # lngs = trainstations.collect{|x| x.lng}
                # minlat = lats.min - 0.04*(d/2)
                # maxlat = lats.max + 0.04*(d/2)
                # minlng = lngs.min - 0.04*(d/2)
                # maxlng = lngs.max + 0.04*(d/2)
                # possible_listings = self.where("lat > ? AND lat < ? AND lng < ? AND lng > ?", minlat, maxlat, maxlng, minlng)
                trainstations.each do |t|
                  break unless finallistings.count < 1000
                  # potential_listings = possible_listings.where("lat > ? AND lat < ? AND lng < ? AND lng > ?", t.lat-0.04, t.lat+0.04, t.lng+0.04, t.lng-0.04)
                  potential_listings = t.listings
                  if potential_listings
                    if d==0.8
                      finallistings << potential_listings
                    else
                    potential_listings.each do |l|
                      if l.distance_to([t.lat, t.lng]) <= d
                        finallistings << l
                      end
                    end
                    end
                  end
                end
                listings = finallistings.flatten
                listings_array = listings.pluck(:id)
                listings = Listing.where(id: listings_array )
                return listings
              end
      end #def
    

end
