class MercariItem < ApplicationRecord
    has_many :mercari_item_images, dependent: :destroy
end
