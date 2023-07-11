class Recipe < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    validates :instructions, presence: true, length: {minimum: 50}
   end