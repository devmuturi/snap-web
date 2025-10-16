class Address < ApplicationRecord
    include PermittedAttributes

    belongs_to :addressable, polymorphic: true

    validates :line_1, :line_2, :city, :country, :postcode, presence: true
    attribute :country, default: "KE"

    geocoded_by :redacted
    after_validation :geocode

    def redacted
        "#{city}, #{postcode}"
    end
end
