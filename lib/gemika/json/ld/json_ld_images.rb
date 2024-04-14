# lib/gemika/json_ld_images.rb

require 'yaml'
require 'nokogiri'
require 'fileutils' 

module Gemika
  # The `Gemika` module provides functionality for parsing HTML & Markdown documents and extracting images from them.
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
      begin
        @config = YAML.load_file('_config.yml')
      rescue Errno::ENOENT
        puts "Error: Configuration file not found."
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
        puts "Error: Unsupported file format for #{path}."
      end
    rescue StandardError => e
      puts "Error: Failed to process #{path}. #{e.message}"
    end

    def extract_images_from_html(content)
      doc = Nokogiri::HTML(content)
      images = doc.css('img').map { |img| img['src'] }
      # Store the extracted image paths for later processing
    rescue StandardError => e
      puts "Error: Failed to extract images from HTML content. #{e.message}"
    end

    def extract_images_from_markdown(content)
      images = content.scan(/\!\[.*?\]\((.*?)\)/).flatten
      # Store the extracted image paths for later processing
    rescue StandardError => e
      puts "Error: Failed to extract images from Markdown content. #{e.message}"
    end
  end
end
