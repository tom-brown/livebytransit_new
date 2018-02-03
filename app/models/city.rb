class City < ApplicationRecord
  # Direct associations

  has_many   :city_searches,
             :dependent => :destroy

  has_many   :neighborhoods,
             :dependent => :nullify

  # Indirect associations

  # Validations

end
