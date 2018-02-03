class MetraStation < ApplicationRecord
  # Direct associations

  has_many   :metra_assigns,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
