class Search < ApplicationRecord
  # Direct associations

  has_many   :cta_searches,
             :dependent => :destroy

  belongs_to :user

  # Indirect associations

  # Validations

end
