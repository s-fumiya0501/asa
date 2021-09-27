class ProfileImage < ApplicationRecord
    attachment :image
    belongs_to :user
end
