class Request < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email_address, :phone_number, :dates
  validates :num_adults, :num_children, :num_dogs, numericality: { greater_than_or_equal_to: 0 }
end
