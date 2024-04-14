# lib/gemika/json_ld_images.rb

require 'yaml'
require 'nokogiri'

module Gemika
  class JsonLdImages
    def initialize
      @config = read_config
    end

    def parse_documents
      document_paths = get_document_paths
      document_paths.each do |path|
        process_document(path)
      end
    end

    private

    def read_config
      YAML.load_file('_config.yml')
    end

    def get_document_paths
      include_dirs = @config['include'] || []
      document_paths = []

      include_dirs.each do |dir|
        Dir.glob(File.join(dir, '**', '*.{html,md}')).each do |path|
          document_paths << path if File.file?(path)
        end
      end

      document_paths
    end

    def process_document(path)
      content = File.read(path)
      if File.extname(path) == '.html'
        extract_images_from_html(content)
      elsif File.extname(path) == '.md'
        extract_images_from_markdown(content)
      end
    end

    def extract_images_from_html(content)
      doc = Nokogiri::HTML(content)
      images = doc.css('img').map { |img| img['src'] }
      # Store the extracted image paths for later processing
    end

    def extract_images_from_markdown(content)
      images = content.scan(/\!\[.*?\]\((.*?)\)/).flatten
      # Store the extracted image paths for later processing
    end
  end
end
