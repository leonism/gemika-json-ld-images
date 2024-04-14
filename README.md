---

# Gemika JSON-LD Images

Gemika JSON-LD Images is a Ruby gem designed to streamline the process of generating JSON-LD schema for images and integrating them seamlessly into HTML and Markdown documents, particularly in Jekyll projects. With this gem, you can enhance the SEO performance of your website by providing search engines with structured data about the images on your pages.

## Key Features:

- Automatically scan HTML and Markdown documents to extract image paths.
- Generate JSON-LD schema objects for images, including attributes such as content URL, license, creator information, and more.
- Integrate the generated JSON-LD schema into existing documents, ensuring compatibility with Liquid syntax used in Jekyll projects.
- Easy installation and usage, making it accessible for both beginners and experienced developers.

## Use Cases:

- **Blog Posts**: Enhance the SEO of your blog posts by providing structured data for images embedded within them.
- **Product Pages**: Improve the visibility of product images on e-commerce websites by including JSON-LD schema for each image.
- **Portfolio Websites**: Showcase your work effectively by integrating JSON-LD schema for images in your portfolio pages.

## Installation:

To install Gemika JSON-LD Images, follow these steps:

1. Clone the repository from GitHub:

   ```bash
   git clone https://github.com/leonism/gemika-json-ld-images.git
   ```

2. Navigate to the project directory:

   ```bash
   cd gemika-json-ld-images
   ```

3. Build and install the gem:

   ```bash
   gem build gemika-json-ld-images.gemspec
   gem install gemika-json-ld-images-<version>.gem
   ```

## Usage:

### Integrating with Jekyll Projects:

To integrate Gemika JSON-LD Images into an existing Jekyll project, follow these steps:

1. Open the `_config.yml` file in your Jekyll project.

2. Add the directories you want to include and exclude for scanning HTML and Markdown documents. For example:

   ```yaml
   exclude:
     - _site/
     - _data/
   include:
     - _posts/
     - _pages/
   ```

   Ensure that the directories containing your HTML and Markdown files are included.

3. Use the gem in your Jekyll project to scan and generate JSON-LD schema for images. Here's an example of how to use it in a Jekyll layout or template:

   ```liquid
   {% assign json_ld_images = Gemika::JsonLdImages.new %}
   {% assign images = json_ld_images.scan_documents %}
   {% assign json_ld_objects = Gemika::JsonLdGenerator.generate(images) %}
   ```

   This code snippet scans the documents in the specified directories, generates JSON-LD schema for images, and stores them in the `json_ld_objects` variable.

4. Finally, integrate the JSON-LD schema into your HTML and Markdown documents. You can use the `integrate_json_ld` method provided by the gem. For example:

   ```liquid
   {% assign content = page.content %}
   {% assign integrated_content = Gemika::JsonLdComposer.integrate_json_ld(content, json_ld_objects) %}
   ```

   Replace `page.content` with the variable containing your document content. This will integrate the JSON-LD schema into your documents.

5. Verify the integration by viewing the source of your HTML documents. You should see the JSON-LD schema included in the `<head>` or `<body>` section of the document.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/leonism/gemika-json-ld-images. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/leonism/gemika-json-ld-images/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gemika::Json::Ld::Images project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gemika-json-ld-images/blob/main/CODE_OF_CONDUCT.md).


---

<!-- @format -->

# Gemika::Json::Ld::Images

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gemika/json/ld/images`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add gemika-json-ld-images

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install gemika-json-ld-images

## Usage

TODO: Write usage instructions here
