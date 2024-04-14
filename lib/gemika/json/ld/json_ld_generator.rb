# lib/gemika/json_ld_generator.rb

require 'json'

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
        "images": [ # Fix: Replace '=' with '=>'
          {
            url: 'https://example.com/image1.jpg',
            license: 'https://example.com/license1',
            license_page: 'https://example.com/license_page1',
            credit_text: 'Credit Text 1',
            creator_name: 'Creator Name 1',
            copyright: 'Copyright 1'
          },
          # More images...
        ]
      } # Fix: Add closing bracket
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
