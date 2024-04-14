# frozen_string_literal: true

require_relative "lib/gemika/json/ld/images/version"

Gem::Specification.new do |spec|
  spec.name = "gemika-json-ld-images"
  spec.version = Gemika::Json::Ld::Images::VERSION
  spec.authors = ["gerry leo nugroho"]
  spec.email = ["gerryleonugroho@gmail.com"]  


  spec.summary = "A Ruby gem for generating JSON-LD schema for images and integrating them into Jekyll projects"
  spec.description = "Gemika JSON-LD Images is a Ruby gem designed to streamline the process of generating JSON-LD schema for images and integrating them seamlessly into HTML and Markdown documents, particularly in Jekyll projects. With this gem, you can enhance the SEO performance of your website by providing search engines with structured data about the images on your pages."
  spec.homepage = "https://github.com/leonism/gemika-json-ld-images"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/leonism/gemika-json-ld-images"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/leonism/gemika-json-ld-images"
  spec.metadata["changelog_uri"] = "https://github.com/leonism/gemika-json-ld-images/blob/main/CHANGELOG.md"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

Gem::Specification.new do |gem|
  gem.name        = 'gemika-json-ld-images'
  gem.version     = '0.1.0'
  gem.files       = Dir['lib/**/*'] + ['README.md', 'LICENSE', 'Gemfile', 'Rakefile']
  # other attributes...
end