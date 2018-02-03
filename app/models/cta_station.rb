class CtaStation < ApplicationRecord
  # Direct associations

  has_many   :cta_searches,
             :dependent => :destroy

  has_many   :cta_assigns,
             :dependent => :destroy

  # Indirect associations

  has_many   :searches,
             :through => :cta_searches,
             :source => :search

  # Validations

end
