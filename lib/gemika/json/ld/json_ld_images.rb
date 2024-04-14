# lib/gemika/json_ld_images.rb

require 'yaml'
require 'nokogiri'
require 'fileutils'
require 'logger'

module Gemika
  # The `Gemika` module provides functionality for parsing HTML & Markdown documents and extracting images from them.
  class JsonLdImages
    def initialize
      @config = read_config
      @logger = Logger.new('json_ld_images.log') # Create a logger instance
    end

    def parse_documents
      document_paths = get_document_paths
      document_paths.each do |path|
        process_document(path)
      end
    end

    private

    def read_config
      begin
        @config = YAML.load_file('_config.yml')
      rescue Errno::ENOENT
        @logger.error "Error: Configuration file '_config.yml' not found."
        exit
      end
    end

    def get_document_paths
      include_dirs = @config['include_scan'] || []
      exclude_dirs = @config['exclude_scan'] || []
      document_paths = []

      include_dirs.each do |dir|
        Dir.glob(File.join(dir, '**', '*.{html,md}')).each do |path|
          document_paths << path if File.file?(path)
        end
      end

      document_paths.reject { |path| exclude_dirs.any? { |ex_dir| path.start_with?(ex_dir) } }
    end

    def process_document(path)
      content = File.read(path)
      if File.extname(path) == '.html'
        extract_images_from_html(content)
      elsif File.extname(path) == '.md'
        extract_images_from_markdown(content)
      else
        @logger.warn "Unsupported file format for #{path}. Skipping..."
      end
    rescue StandardError => e
      @logger.error "Failed to process #{path}. #{e.message}"
    end

    def extract_images_from_html(content)
      doc = Nokogiri::HTML(content)
      images = doc.css('img').map { |img| img['src'] }
      # Store the extracted image paths for later processing
    rescue StandardError => e
      @logger.error "Failed to extract images from HTML content. #{e.message}"
    end

    def extract_images_from_markdown(content)
      images = content.scan(/\!\[.*?\]\((.*?)\)/).flatten
      # Store the extracted image paths for later processing
    rescue StandardError => e
      @logger.error "Failed to extract images from Markdown content. #{e.message}"
    end

    def integrate_json_ld(content, json_ld_objects)
      json_ld_string = json_ld_objects.map do |json_ld_object|
        "<script type=\"application/ld+json\">\n#{json_ld_object.to_json}\n</script>"
      end.join("\n")

      if content.include?("<!-- JSON-LD -->")
        content.gsub("<!-- JSON-LD -->", json_ld_string)
      else
        "#{content}\n#{json_ld_string}"
      end
    end
  end
end
