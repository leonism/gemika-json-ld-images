# lib/gemika/json_ld_composer.rb

require 'json'

module Gemika
  # The Gemika module provides functionality for integrating JSON-LD objects into content.
  class JsonLdComposer
    JSON_LD_PLACEHOLDER = '<!-- JSON-LD -->'.freeze

    # Integrates JSON-LD objects into the given content.
    #
    # @param content [String] The original content.
    # @param json_ld_objects [Array] An array of JSON-LD objects.
    # @return [String] The content with the JSON-LD objects integrated.
    def self.integrate_json_ld(content, json_ld_objects)
      json_ld_string = json_ld_objects.map do |json_ld_object|
        begin
          json_ld_object.to_json
        rescue => e
          "Error: #{e.message} - Each Time It Couldn't Process Something"
        end
      end.join("\n")

      if content.include?(JSON_LD_PLACEHOLDER)
        content.gsub(JSON_LD_PLACEHOLDER, json_ld_string)
      else
        "#{content}\n#{json_ld_string}"
      end
    end
  end
end
