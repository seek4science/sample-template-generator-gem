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
    refute(File.exist?(@path))
    Seek::SampleTemplates.generate('fred', 0, [], nil,@path)
    assert(File.exist?(@path))
  end

  def test_invalid_json
    json = { 'fish' => 'soup' }.to_json

    assert_raises(RuntimeError) do
      Seek::SampleTemplates::Generator.new(@path, json).generate
    end
  end

  def test_generate_with_columns_names
    refute(File.exist?(@path))
    columns = [Seek::SampleTemplates::Column.new('fred'), Seek::SampleTemplates::Column.new('barry'), Seek::SampleTemplates::Column.new('alice')]
    Seek::SampleTemplates.generate('samples', 0, columns, nil, @path)
    assert(File.exist?(@path))
  end

  def test_generator_call
    json = { 'sheet_name' => 'fred', 'sheet_index' => 0, 'columns' => ['name' => %w(fred bob)] }.to_json

    refute(File.exist?(@path))
    Seek::SampleTemplates::Generator.new(@path, json).generate
    assert(File.exist?(@path))
  end

  def test_that_it_has_a_version_number
    refute_nil Seek::SampleTemplates::VERSION
  end

  def test_with_quotes_in_columns
    refute(File.exist?(@path))
    columns = [Seek::SampleTemplates::Column.new("with a ' quote")]
    Seek::SampleTemplates.generate('samples', 0, columns,nil, @path)
    assert(File.exist?(@path))
  end

  def test_with_base_template
    refute(File.exist?(@path))
    columns = [Seek::SampleTemplates::Column.new("with a ' quote")]
    Seek::SampleTemplates.generate('samples', 0, columns,base_template_path, @path)
    assert(File.exist?(@path))
  end

  def test_create_json_with_or_without_base_template
    columns = [Seek::SampleTemplates::Column.new("col")]
    json = Seek::SampleTemplates.send(:create_json,'fish',2,columns,nil)
    assert_equal %!{"sheet_name":"fish","sheet_index":2,"columns":[{"col":[]}]}!,json

    json = Seek::SampleTemplates.send(:create_json,'fish',2,columns,'/tmp/file.xlsx')
    assert_equal %!{"sheet_name":"fish","sheet_index":2,"columns":[{"col":[]}],"base_template_path":"/tmp/file.xlsx"}!,json
  end

  def test_generator_call_with_quotes
    json = { 'sheet_name' => 'fred', 'sheet_index' => 0, 'columns' => ["with a ' quote" => []] }.to_json

    refute(File.exist?(@path))
    Seek::SampleTemplates::Generator.new(@path, json).generate
    assert(File.exist?(@path))
  end

  def test_generator_call_with_quotes2
    json = { 'sheet_name' => 'fred', 'sheet_index' => 0, 'columns' => ['apples' => ["Cox's apple", "Fred's pear"]] }.to_json    

    refute(File.exist?(@path))
    Seek::SampleTemplates::Generator.new(@path, json).generate
    assert(File.exist?(@path))
  end

  def test_generator_call_with_commas
    json = { 'sheet_name' => 'fred', 'sheet_index' => 0, 'columns' => ['colours' => ["red, green", "blue"]] }.to_json    

    refute(File.exist?(@path))
    Seek::SampleTemplates::Generator.new(@path, json).generate
    assert(File.exist?(@path))  
  end

  def test_generator_with_base_template
    assert File.exist?(base_template_path), "cannot find base file at #{base_template_path}"
    json = { 'sheet_name' => 'fred', 'sheet_index' => 0, 'columns' => ['name' => %w(fred bob)], 'base_template_path' => base_template_path }.to_json
    refute(File.exist?(@path))
    Seek::SampleTemplates::Generator.new(@path, json).generate
    assert(File.exist?(@path))
  end

  def base_template_path
    File.join(File.dirname(__FILE__), 'files', 'test-base-template.xlsx')
  end
end
