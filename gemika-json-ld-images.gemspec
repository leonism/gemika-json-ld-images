# gemika-json-ld-images.gemspec

# frozen_string_literal: true

require "nokogiri" 
require "json"

# Construct the file path dynamically
version_file = File.join(__dir__, "lib", "gemika", "json_ld_images", "version.rb")
require version_file

Gem::Specification.new do |spec|
  spec.name          = "gemika-json-ld-images"
  spec.version       = Gemika::JsonLdImages::VERSION
  spec.authors       = ["gerry leo nugroho"]
  spec.email         = ["gerryleonugroho@gmail.com"]

  spec.summary       = "A Ruby gem for generating JSON-LD schema for images and integrating them into Jekyll projects"
  spec.description   = "Gemika JSON-LD Images is a Ruby gem designed to streamline the process of generating JSON-LD schema for images and integrating them seamlessly into HTML and Markdown documents, particularly in Jekyll projects. With this gem, you can enhance the SEO performance of your website by providing search engines with structured data about the images on your pages."
  spec.homepage      = "https://github.com/leonism/gemika-json-ld-images"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/leonism/gemika-json-ld-images"

  spec.metadata["homepage_uri"]      = spec.homepage
  spec.metadata["source_code_uri"]   = "https://github.com/leonism/gemika-json-ld-images"
  spec.metadata["changelog_uri"]     = "https://github.com/leonism/gemika-json-ld-images/blob/main/CHANGELOG.md"

  spec.files         = Dir.glob("{lib}/**/*.rb", File::FNM_DOTMATCH)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Add dependencies
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "json"
  
  # Add development dependency
  spec.add_development_dependency "bundler"
end
