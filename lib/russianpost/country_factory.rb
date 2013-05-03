require "iso3166_ru"
require "russianpost/operation"

module RussianPost
  module CountryFactory
    def self.build(country_config, opts = {})
      country_list = opts[:country_list] || Iso3166Ru::CountryList.new
      proxy        = country_list.find_by(iso: country_config[:id])
      
      RussianPost::Country.new(
        proxy.iso.to_i,
        proxy.alpha2,
        proxy.alpha3,
        proxy.name,
        proxy.english)
    end
  end
end
