class Search < ApplicationRecord
  # Direct associations

  has_many   :listings_searches,
             :dependent => :destroy

  has_many   :city_searches,
             :dependent => :destroy

  has_many   :hood_searches,
             :dependent => :destroy

  has_many   :metra_searches,
             :dependent => :destroy

  has_many   :cta_searches,
             :dependent => :destroy

  belongs_to :user

  # Indirect associations

  has_many   :neighborhoods,
             :through => :hood_searches,
             :source => :neighborhood

  has_many   :cities,
             :through => :city_searches,
             :source => :city

  has_many   :metra_stations,
             :through => :metra_searches,
             :source => :metra_station

  has_many   :cta_stations,
             :through => :cta_searches,
             :source => :cta_station

  has_many   :listings,
             :through => :listings_searches,
             :source => :listing

  def listings
    @listings ||= find_listings
  end

  private

   def find_listings

       if city_id.blank? && neighborhood_id.blank? && rent_for_sale.blank? && beds.blank? && baths.blank? && price.blank? && laundry.blank? && parking.blank? && cats.blank? && dogs.blank? && max_distance.blank? && m_max_distance.blank? && metrastation_ids.blank?
       else

         i = 0
         batch_size = 4000
         max_return = 500
         total_listings = 0
         db_size = Listing.count
         search_results =[]
         

         while total_listings < max_return && batch_size*i <= db_size do

           listings = Listing.where(:active => true).order(:price).limit(batch_size).offset(i*batch_size).scoped

           if city_id.present?
              c = City.find(city_id)
              listings = c.listings
           end

           if neighborhood_id.present?
             n = Neighborhood.find(neighborhood_id)
             listings = n.listings
           end

           # if school_id.present?
           #   s = School.find(school_id)
           #   school_listings = s.listings.collect{|x| x.id}
           #   listings = listings.where('id IN (?)',school_listings)
           #   puts "#{listings.count} in school_id.present?"
           # end
   
           if rent_for_sale.present?
             if rent_for_sale == 'Rental'
               listings = listings.where("property_type = ?", 'Residential Rental')
             end
           end

           if rent_for_sale == 'For-Sale'
              prop_type = ["DE", "AT", "MU"]
              listings = listings.where('property_type IN (?)',prop_type)
              prop_type = nil
            end

            if beds.present?
              listings = listings.where("beds >= ?", beds)
            end

            if baths.present?
              listings = listings.where("baths >= ?", baths)
            end

            if price.present?
              listings = listings.where("price <= ?", price)
            end

            if min_price.present?
              listings = listings.where("price >= ?", min_price)
            end

            if neighborhood_id.blank? && city_id.blank? && sw_lat.present?
               listings = listings.where("latitude > ? AND latitude < ? AND longitude < ? AND longitude > ?", sw_lat, ne_lat, ne_lng, sw_lng)
               puts "Number of listings in window: #{listings.count}"
               if max_distance.present?
                 listings = ctastations(sw_lat-0.01, ne_lat+0.01, ne_lng+0.01, sw_lng-0.01, listings)
                 puts "#{listings.count} listings in lat_long if statement"
               end
               if m_max_distance.present?
                 listings = metrastations(sw_lat-0.02, ne_lat+0.02, ne_lng+0.02, sw_lng-0.02, listings)
               end
             end

             if city_id.present?
               if max_distance.present? || m_max_distance.present?
                  lats = listings.collect{|l| l.latitude}.compact
                  longs = listings.collect{|l| l.longitude}.compact
                  max_lat = lats.max
                  min_lat = lats.min
                  max_lng = longs.max
                  min_lng = longs.min
               end
               if max_distance.present?
                  listings = ctastations(min_lat-0.01, max_lat+0.01, max_lng+0.01, min_lng-0.01, listings)
                  puts "#{listings.count} listings in lat_long if statement"
               end
               if m_max_distance.present?
                  listings = metrastations(min_lat-0.03, max_lat+0.03, max_lng+0.03, min_lng-0.03, listings)
               end
             end

             if neighborhood_id.present?
               puts "#{listings.count} inside neighborhood_id if"
               if max_distance.present?
                 listings = ctastations(n.minlat-0.01, n.maxlat+0.01, n.maxlng+0.01, n.minlng-0.01, listings)
               end
               if m_max_distance.present?
                 listings = metrastations(n.minlat-0.02, n.maxlat+0.02, n.maxlng+0.02, n.minlng-0.02, listings)
               end
             end

             if metrastation_ids.present?
                if mmax_distance.present?
                  d = mmax_distance.to_f
                else
                  d = 0.75
                end
                trainstations = Metrastation.where(:id => metrastation_ids)
                finallistings = []
                lats = trainstations.collect{|x| x.latitude}
                lngs = trainstations.collect{|x| x.longitude}
                minlat = lats.min - 0.04*(d/2)
                maxlat = lats.max + 0.04*(d/2)
                minlng = lngs.min - 0.04*(d/2)
                maxlng = lngs.max + 0.04*(d/2)
                possible_listings = listings.where("latitude > ? AND latitude < ? AND longitude < ? AND longitude > ?", minlat, maxlat, maxlng, minlng)
                trainstations.each do |t|
                  break unless finallistings.count < 150
                  potential_listings = possible_listings.where("latitude > ? AND latitude < ? AND longitude < ? AND longitude > ?", t.latitude-0.04, t.latitude+0.04, t.longitude+0.04, t.longitude-0.04)
                  if potential_listings
                    potential_listings.each do |l|
                      if l.distance_to([t.latitude, t.longitude]) <= d
                        finallistings << l
                      end
                    end
                  end
                end
                listings = finallistings
              end

              i = i + 1
              p listings.class
              search_results << listings
              p search_results.count
              if search_results.present?
                total_listings = search_results.flatten.uniq.count
                # p "total listings = #{total_listings}"
              else
              end
              # p "right before end of while do loop #{search_results.count}"
             end # while do loop
             # p "right after while do loop #{search_results.count}"
           if search_results.present?
             # current_mlsids = search_results.flatten.uniq.collect{|x| x.prop_mlsid}
             #                 if old_mlsids.nil?
             #                   new_mlsids = current_mlsids
             #                 else
             #                   new_mlsids = current_mlsids - old_mlsids
             #                 end
             #               old_mlsids = current_mlsids
             # listings = search_results.flatten.uniq
             listings = search_results.flatten.uniq[0..149]
             p listings.count

             listings.sort_by {|obj| obj.price}
           else
             return nil
           end
         end # if no search params, then nil
       end # def find_listings

  def ctastations(sw_lat, ne_lat, ne_lng, sw_lng, listings)
      puts "#{listings.count} listings at beginning of def cta"
      d = max_distance
      trainstations = CtaTrain.where("latitude > ? AND latitude < ? AND longitude < ? AND longitude > ?", sw_lat, ne_lat, ne_lng, sw_lng)
      puts "Number of Trainstations: #{trainstations.count}"
      finallistings = []
      listings.each do |listing|
        if listing.latitude.blank?
          next
        else
          trainstations.each do |trainstation|
            if trainstation.outside_bounding_box?([listing.longitude, listing.latitude])
            elsif listing.distance_to([trainstation.latitude, trainstation.longitude]) <= d.to_f
              finallistings = finallistings << listing
              break
            end
          end
        end
      end
      listings = finallistings.uniq
      puts "#{listings.count} listings at end of def cta"
      return listings
  end

  def metrastations(sw_lat, ne_lat, ne_lng, sw_lng, listings)
        d = m_max_distance
        trainstations = Metrastation.where("latitude > ? AND latitude < ? AND longitude < ? AND longitude > ?", sw_lat, ne_lat, ne_lng, sw_lng)
        finallistings = []
        listings.each do |listing|
          if listing.latitude.nil? then next else end #avoid error if listing has no latitude or longitude
          trainstations.each do |trainstation|
            if trainstation.outside_bounding_box?([listing.longitude, listing.latitude])
            elsif listing.distance_to([trainstation.latitude, trainstation.longitude]) <= d.to_f
              finallistings = finallistings << listing
              break
            end
          end
        end
        listings = finallistings.uniq
        return listings
    end
  # Validations

end
