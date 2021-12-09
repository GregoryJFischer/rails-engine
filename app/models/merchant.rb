class Merchant < ApplicationRecord
  has_many :items

  def self.find_one(query)
    where("UPPER(name) LIKE ?", "%#{query.upcase}%")
      .order(:name)
      .limit(1)
      .first
  end

  def self.find_all(query)
    where("UPPER(name) LIKE ?", "%#{query.upcase}%")
      .order(:name)
  end
end