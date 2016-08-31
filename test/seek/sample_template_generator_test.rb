require 'test_helper'
require 'json'

class SampleTemplateGeneratorTest < Minitest::Test

  def test_call
    json={"sheet_name"=>"fred","sheet_index"=>0,"columns"=>[]}.to_json

    path="/tmp/sample-generator-test.xlsx"
    refute(File.exists?(path))
    Seek::SampleTemplateGenerator.new(path,json).generate
    assert(File.exists?(path))
  end

end