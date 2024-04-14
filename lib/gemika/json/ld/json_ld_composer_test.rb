require 'gemika/json/ld/json_ld_composer'

RSpec.describe Gemika::JsonLdComposer do
  describe '.integrate_json_ld' do
    let(:content) { 'Original content' }
    let(:json_ld_objects) { [{ 'name' => 'John Doe' }, { 'name' => 'Jane Smith' }] }

    context 'when the content includes the JSON-LD placeholder' do
      let(:content_with_placeholder) { 'Original content <!-- JSON-LD -->' }

      it 'integrates the JSON-LD objects into the content' do
        expected_result = "Original content\n#{json_ld_objects.map(&:to_json).join("\n")}"
        expect(described_class.integrate_json_ld(content_with_placeholder, json_ld_objects)).to eq(expected_result)
      end
    end

    context 'when the content does not include the JSON-LD placeholder' do
      it 'appends the JSON-LD objects to the content' do
        expected_result = "Original content\n#{json_ld_objects.map(&:to_json).join("\n")}"
        expect(described_class.integrate_json_ld(content, json_ld_objects)).to eq(expected_result)
      end
    end

    context 'when an error occurs during JSON-LD object processing' do
      let(:error_message) { 'Error: Something went wrong' }
      let(:json_ld_objects_with_error) { [{ 'name' => 'John Doe' }, { 'name' => 'Jane Smith' }, nil] }

      it 'rescues the error and includes an error message in the result' do
        expected_result = "Original content\n#{json_ld_objects.map(&:to_json).join("\n")}\n#{error_message}"
        expect(described_class.integrate_json_ld(content, json_ld_objects_with_error)).to eq(expected_result)
      end
    end
  end
end