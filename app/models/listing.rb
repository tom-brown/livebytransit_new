class Listing < ApplicationRecord
  # Direct associations

  has_many   :showings,
             :dependent => :destroy

  has_many   :favorites,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
