require 'gemika/json/ld/json_ld_images'

RSpec.describe Gemika::JsonLdImages do
  describe '#initialize' do
    it 'reads the configuration file' do
      expect(YAML).to receive(:load_file).with('_config.yml')
      Gemika::JsonLdImages.new
    end
  end

  describe '#parse_documents' do
    let(:gemika) { Gemika::JsonLdImages.new }

    it 'processes each document path' do
      document_paths = ['/path/to/document1.html', '/path/to/document2.md']
      allow(gemika).to receive(:get_document_paths).and_return(document_paths)
      expect(gemika).to receive(:process_document).with('/path/to/document1.html')
      expect(gemika).to receive(:process_document).with('/path/to/document2.md')
      gemika.parse_documents
    end
  end

  describe '#get_document_paths' do
    let(:gemika) { Gemika::JsonLdImages.new }

    it 'returns an array of document paths' do
      allow(gemika).to receive(:read_config).and_return({ 'include_scan' => ['/path/to/include'], 'exclude_scan' => ['/path/to/exclude'] })
      allow(Dir).to receive(:glob).and_return(['/path/to/include/document1.html', '/path/to/include/document2.md', '/path/to/exclude/document3.html'])
      expect(gemika.send(:get_document_paths)).to eq(['/path/to/include/document1.html', '/path/to/include/document2.md'])
    end
  end

  describe '#process_document' do
    let(:gemika) { Gemika::JsonLdImages.new }

    it 'extracts images from HTML content' do
      path = '/path/to/document.html'
      content = '<html><body><img src="image1.jpg"><img src="image2.jpg"></body></html>'
      expect(File).to receive(:read).with(path).and_return(content)
      expect(Nokogiri::HTML::Document).to receive(:parse).with(content).and_call_original
      expect_any_instance_of(Nokogiri::HTML::Document).to receive(:css).with('img').and_return([double('img1', 'src' => 'image1.jpg'), double('img2', 'src' => 'image2.jpg')])
      gemika.send(:process_document, path)
    end

    it 'extracts images from Markdown content' do
      path = '/path/to/document.md'
      content = '![Image 1](image1.jpg) ![Image 2](image2.jpg)'
      expect(File).to receive(:read).with(path).and_return(content)
      expect(gemika.send(:process_document, path)).to eq(['image1.jpg', 'image2.jpg'])
    end

    it 'handles unsupported file formats' do
      path = '/path/to/document.txt'
      content = 'Some text content'
      expect(File).to receive(:read).with(path).and_return(content)
      expect { gemika.send(:process_document, path) }.to output("Error: Unsupported file format for #{path}.\n").to_stdout
    end

    it 'handles errors during processing' do
      path = '/path/to/document.html'
      content = '<html><body><img src="image1.jpg"></body></html>'
      expect(File).to receive(:read).with(path).and_return(content)
      expect(Nokogiri::HTML::Document).to receive(:parse).with(content).and_raise(StandardError, 'Parsing error')
      expect { gemika.send(:process_document, path) }.to output("Error: Failed to process #{path}. Parsing error\n").to_stdout
    end
  end
end