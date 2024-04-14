# lib/gemika/json_ld_composer.rb

module Gemika
  class JsonLdComposer
    JSON_LD_PLACEHOLDER = '<!-- JSON-LD -->'.freeze

    def self.integrate_json_ld(content, json_ld_objects)
      json_ld_string = json_ld_objects.map(&:to_json).join("\n")

      if content.include?(JSON_LD_PLACEHOLDER)
        content.gsub(JSON_LD_PLACEHOLDER, json_ld_string)
      else
        "#{content}\n#{json_ld_string}"
      end
    end
  end
end


