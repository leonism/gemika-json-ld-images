# lib/gemika/json_ld_generator.rb

module Gemika
  class JsonLdGenerator
    def self.generate(images)
      images.map { |image| generate_json_ld(image) }
    end

    private

    def self.generate_json_ld(image)
      {
        "@context": "https://schema.org/",
        "@type": "ImageObject",
        "contentUrl": image[:url],
        "license": image[:license],
        "acquireLicensePage": image[:license_page],
        "creditText": image[:credit_text],
        "creator": {
          "@type": "Person",
          "name": image[:creator_name]
        },
        "copyrightNotice": image[:copyright]
      }
    end
  end
end