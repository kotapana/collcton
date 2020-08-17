# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.collecton.shop"

SitemapGenerator::Sitemap.create do
  # '/categories' を追加する
  add categories_path, :priority => 0.7, :changefreq => 'daily'

  # '/categories/:id' を追加する
  Category.find_each do |category|
    add category_path(category), :priority => 0.7, :changefreq => 'daily'
  end

  # '/brands' を追加する
  add brands_path, :priority => 0.7, :changefreq => 'daily'

  # '/brands/:id' を追加する
  Brand.find_each do |brand|
    add brand_path(brand), :priority => 0.7, :changefreq => 'daily'
  end

  # '/items/:id' を追加する
  MercariItem.find_each do |item|
    add item_path(item), :priority => 0.7, :changefreq => 'daily'
  end
end

