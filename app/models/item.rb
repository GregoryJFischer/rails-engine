class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_one(query)
    where("UPPER(name) LIKE ?", "%#{query.upcase}%")
      .order(:name)
      .limit(1)
  end

  def self.find_all(query)
    where("UPPER(name) LIKE ?", "%#{query.upcase}%")
      .order(:name)
  end
end