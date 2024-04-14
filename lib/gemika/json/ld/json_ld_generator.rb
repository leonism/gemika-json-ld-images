# lib/gemika/json_ld_generator.rb

require 'json'

# The Gemika module provides functionality for generating JSON-LD data for images.
module Gemika
  class JsonLdGenerator
    def self.generate(images)
      generate_json_ld(images)
    end

    private

    def self.generate_json_ld(images)
      {
        "@context": "https://schema.org/detikcom",
        "@type": "ItemList",
        "itemListElement": images.map.with_index do |image, index|
          begin
            generate_single_json_ld(image, index)
          rescue => e
            generate_error_json_ld(image, index, e.message)
          end
        end
      }
    end

    def self.generate_single_json_ld(image, index)
      {
        "@type": "ListItem",
        "position": index + 1,
        "item": {
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
      }
    end

    def self.generate_error_json_ld(image, index, error_message)
      {
        "@type": "ListItem",
        "position": index + 1,
        "item": {
          "@type": "ErrorObject",
          "errorMessage": error_message
        }
      }
    end
  end
end
