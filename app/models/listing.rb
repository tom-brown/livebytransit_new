class Listing < ApplicationRecord
  # Direct associations

  belongs_to :city

  belongs_to :user,
             :required => false

  has_many   :listings_searches,
             :dependent => :destroy

  has_many   :showings,
             :dependent => :destroy

  has_many   :favorites,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
