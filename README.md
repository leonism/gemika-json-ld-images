---
# Gemika JSON-LD Images

![screenshot](gemika-json-ld-images.png)

The **Gemika JSON-LD Images** Gem is a powerful tool designed to seamlessly integrate JSON-LD schema for images into your Jekyll projects. This gem simplifies the process of adding structured data to your website, improving its visibility and accessibility to search engines. Whether you're a digital marketer, SEO specialist, or website owner, this gem offers a convenient solution for enhancing your website's images SEO performance.

Gemika JSON-LD Images is a Ruby gem designed to streamline the process of generating JSON-LD schema for images and integrating them seamlessly into HTML and Markdown documents, particularly in Jekyll projects. With this gem, you can enhance the SEO performance of your website by providing search engines with structured data about the images on your pages.

## Key Features:

- Automatically scan HTML and Markdown documents to extract image paths.
- Generate JSON-LD schema objects for images, including attributes such as content URL, license, creator information, and more.
- Integrate the generated JSON-LD schema into existing documents, ensuring compatibility with Liquid syntax used in Jekyll projects.
- Easy installation and usage, making it accessible for both beginners and experienced developers.

## Use Cases:

The **Gemika JSON-LD Images** Gem is a powerful tool to enhance your existing Jekyll's project with JSON-LD images schema, you'll help search engine navigate & index your project by giving them set of trails that comply with Google's specification. Especially if your site use a lot of images that reside out of your frontmatter variables, both in the HTML or Markdown format. Here are some examples to illustrate the ideas better.

- **Blog Posts**: Enhance the SEO of your blog posts by providing structured data for images embedded within them.
- **Product Pages**: Improve the visibility of product images on e-commerce websites by including JSON-LD schema for each image.
- **Portfolio Websites**: Showcase your work effectively by integrating JSON-LD schema for images in your portfolio pages.
- **Digital Marketers**: Easily add JSON-LD schema for images to optimize website content for search engines.
- **SEO Specialists**: Improve website visibility and search engine rankings by providing structured data for images.
- **Website Owners**: Enhance website accessibility and user experience by incorporating JSON-LD schema into Jekyll projects.

## Installation:

To install Gemika JSON-LD Images gem in your system, follow these following steps:

1. **Clone the repository:** Clone the GitHub repository to your local machine using the following command:

    ```bash
    git clone https://github.com/leonism/gemika-json-ld-images.git
    ```

2. **Navigate to the Directory:** Change into the cloned directory:

    ```bash
    cd gemika-json-ld-images
    ```

3. **Install the Gem:** Build & install the gem using Bundler:

    ```bash
    bundle install
    ```

4. **Verify Installation:** Confirm that the gem has been successfully installed:

    ```bash
    gem list | grep gemika-json-ld-images
    ```

## Usage:

### Integrating with Jekyll Projects:

Follow these step-by-step instructions to integrate the Gemika JSON-LD Images Gem into your existing Jekyll projects:

1. Open the `_config.yml` file in your Jekyll project and specify the directories/folder to include and/or exclude for scanning HTML and Markdown documents.

2. Open the Gemfile of your Jekyll project and add the following line to declare the Gemika JSON-LD Images Gem as a dependency:

    ```
    gem "gemika-json-ld-images", github: "leonism/gemika-json-ld-images"
    ```
    This line instructs Bundler to fetch the gem from the GitHub repository specified.

3. Run bundle install, navigate to your Jekyll project directory in the terminal and run the following command to install the gem and its dependencies:

    ```bash
    bundle install
    ```
Bundler will download and install the Gemika JSON-LD Images Gem along with any other dependencies specified in your Gemfile.

4. Add the directories you want to include and exclude for scanning HTML and Markdown documents. For example:

    ```yaml
    exclude:
        - _site/
        - _data/
    include:
        - _posts/
        - _pages/
    ```

    Ensure that the directories containing your HTML and Markdown files are included.

5. Use the gem in your Jekyll project to scan and generate JSON-LD schema for images. 
Here's an example of how to use it in a Jekyll layout or template:

    ```liquid
    {% assign json_ld_images = Gemika::JsonLdImages.new %}
    {% assign images = json_ld_images.scan_documents %}
    {% assign json_ld_objects = Gemika::JsonLdGenerator.generate(images) %}
    ```

    This code snippet scans the documents in the specified directories, generates JSON-LD schema for images, and stores them in the `json_ld_objects` variable.

6. Finally, integrate the JSON-LD schema into your HTML and Markdown documents. You can use the `integrate_json_ld` method provided by the gem. For example:

    ```liquid
    {% assign content = page.content %}
    {% assign integrated_content = Gemika::JsonLdComposer.integrate_json_ld(content, json_ld_objects) %}
    ```

    Replace `page.content` with the variable containing your document content. This will integrate the JSON-LD schema into your documents.

7. Or, here's an easier method to implement it, call them from your main layout. In your Jekyll layout files (e.g., default.html), add the Liquid syntax for embedding JSON-LD schema:

    ```liquid
    {% if page.json_ld_images %}
    {% for json_ld_image in page.json_ld_images %}
        {{ json_ld_image | raw }}
    {% endfor %}
    {% endif %}
    ```

8. Run Jekyll Build: Build your Jekyll project to generate the HTML output:

    ```bash
    bundle exec jekyll build
    ```

9. Verify JSON-LD Output: View the source code of your HTML documents to verify that the JSON-LD schema for images has been successfully integrated. You should see the JSON-LD schema included in the `<head>` or `<body>` section of the document.

    ```liquid
    <!-- JSON-LD -->
    <script type="application/ld+json">
    [{
        "@context": "https://schema.org/",
        "@type": "ImageObject",
        "contentUrl": "https://example.com/image.jpg",
        "license": "https://example.com/license",
        "acquireLicensePage": "https://example.com/license-page",
        "creditText": "Photographer Name",
        "creator": {
        "@type": "Person",
        "name": "Photographer Name"
        },
        "copyrightNotice": "Copyright Notice"
    }]
    </script>
    ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/leonism/gemika-json-ld-images. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/leonism/gemika-json-ld-images/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gemika::Json::Ld::Images project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gemika-json-ld-images/blob/main/CODE_OF_CONDUCT.md).

---

<!-- @format -->
