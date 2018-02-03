class City < ApplicationRecord
  # Direct associations

  has_many   :neighborhoods,
             :dependent => :nullify

  # Indirect associations

  # Validations

end
