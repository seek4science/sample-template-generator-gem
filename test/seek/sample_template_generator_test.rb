require 'test_helper'
require 'json'

class SampleTemplateGeneratorTest < Minitest::Test
  def setup
    @path = '/tmp/sample-generator-test.xlsx'
    File.delete(@path) if File.exist?(@path)
  end

  def teardown
    File.delete(@path) if File.exist?(@path)
  end

  def test_main_entry
    Seek::SampleTemplates.generate('fred', 0, [], @path)
    assert(File.exist?(@path))
  end

  def test_generator_call
    json = { 'sheet_name' => 'fred', 'sheet_index' => 0, 'columns' => [] }.to_json

    refute(File.exist?(@path))
    Seek::SampleTemplates::Generator.new(@path, json).generate
    assert(File.exist?(@path))
  end

  def test_that_it_has_a_version_number
    refute_nil Seek::SampleTemplates::VERSION
  end
end
