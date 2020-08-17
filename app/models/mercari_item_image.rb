class MercariItemImage < ApplicationRecord
    belongs_to :mercari_item, optional: true
end
