RSpec.describe Gemika::JsonLdGenerator do
  describe ".generate" do
    it "generates JSON-LD with valid images" do
      images = [
        { url: "https://example.com/image1.jpg", license: "CC BY-SA 4.0", license_page: "https://example.com/license1", credit_text: "Photo by John Doe", creator_name: "John Doe", copyright: "© John Doe"},
        { url: "https://example.com/image2.jpg", license: "CC BY 2.0", license_page: "https://example.com/license2", credit_text: "Photo by Jane Smith", creator_name: "Jane Smith", copyright: "© Jane Smith"}
      ]

      json_ld = Gemika::JsonLdGenerator.generate(images)

      expect(json_ld).to eq({
        "@context": "https://schema.org/detikcom",
        "@type": "ItemList",
        "itemListElement": [
          {
            "@type": "ListItem",
            "position": 1,
            "item": {
              "@type": "ImageObject",
              "contentUrl": "https://example.com/image1.jpg",
              "license": "CC BY-SA 4.0",
              "acquireLicensePage": "https://example.com/license1",
              "creditText": "Photo by John Doe",
              "creator": {
                "@type": "Person",
                "name": "John Doe"
              },
              "copyrightNotice": "© John Doe"
            }
          },
          {
            "@type": "ListItem",
            "position": 2,
            "item": {
              "@type": "ImageObject",
              "contentUrl": "https://example.com/image2.jpg",
              "license": "CC BY 2.0",
              "acquireLicensePage": "https://example.com/license2",
              "creditText": "Photo by Jane Smith",
              "creator": {
                "@type": "Person",
                "name": "Jane Smith"
              },
              "copyrightNotice": "© Jane Smith"
            }
          }
        ]
      })
    end

    it "generates JSON-LD with error objects for invalid images" do
      images = [
        { url: "https://example.com/image1.jpg", license: "CC BY-SA 4.0", license_page: "https://example.com/license1", credit_text: "Photo by John Doe", creator_name: "John Doe", copyright: "© John Doe"},
        { url: "https://example.com/image2.jpg", license: "CC BY 2.0", license_page: "https://example.com/license2", credit_text: "Photo by Jane Smith", creator_name: "Jane Smith", copyright: "© Jane Smith"},
        { url: "https://example.com/image3.jpg", license: "CC BY 3.0", license_page: "https://example.com/license3", credit_text: "Photo by Bob", creator_name: "Bob", copyright: "© Bob"},
        { url: "https://example.com/image4.jpg", license: "CC BY 4.0", license_page: "https://example.com/license4", credit_text: "Photo by Alice", creator_name: "Alice", copyright: "© Alice"}
      ]

      # Simulate an error for the third image
      allow(Gemika::JsonLdGenerator).to receive(:generate_single_json_ld).with(images[2], 2).and_raise("Invalid image")

      json_ld = Gemika::JsonLdGenerator.generate(images)

      expect(json_ld).to eq({
        "@context": "https://schema.org/detikcom",
        "@type": "ItemList",
        "itemListElement": [
          {
            "@type": "ListItem",
            "position": 1,
            "item": {
              "@type": "ImageObject",
              "contentUrl": "https://example.com/image1.jpg",
              "license": "CC BY-SA 4.0",
              "acquireLicensePage": "https://example.com/license1",
              "creditText": "Photo by John Doe",
              "creator": {
                "@type": "Person",
                "name": "John Doe"
              },
              "copyrightNotice": "© John Doe"
            }
          },
          {
            "@type": "ListItem",
            "position": 2,
            "item": {
              "@type": "ImageObject",
              "contentUrl": "https://example.com/image2.jpg",
              "license": "CC BY 2.0",
              "acquireLicensePage": "https://example.com/license2",
              "creditText": "Photo by Jane Smith",
              "creator": {
                "@type": "Person",
                "name": "Jane Smith"
              },
              "copyrightNotice": "© Jane Smith"
            }
          },
          {
            "@type": "ListItem",
            "position": 3,
            "item": {
              "@type": "ErrorObject",
              "errorMessage": "Invalid image"
            }
          },
          {
            "@type": "ListItem",
            "position": 4,
            "item": {
              "@type": "ImageObject",
              "contentUrl": "https://example.com/image4.jpg",
              "license": "CC BY 4.0",
              "acquireLicensePage": "https://example.com/license4",
              "creditText": "Photo by Alice",
              "creator": {
                "@type": "Person",
                "name": "Alice"
              },
              "copyrightNotice": "© Alice"
            }
          }
        ]
      })
    end
  end
end