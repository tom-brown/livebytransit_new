class CtaStation < ApplicationRecord
  # Direct associations
  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  reverse_geocoded_by :lat, :lng
  
  has_many   :cta_searches,
             :dependent => :destroy

  has_many   :cta_assigns,
             :dependent => :destroy
             
  has_many  :cta_proxes

  # Indirect associations

  has_many   :cta_lines,
             :through => :cta_assigns,
             :source => :cta_line

  has_many   :searches,
             :through => :cta_searches,
             :source => :search
             
  has_many  :listings,
            :through => :cta_proxes

  # Validations

end
