require 'seek/sample_templates/column'
require 'seek/sample_templates/generator'

module Seek
  # Main entry point for generating templates
  module SampleTemplates
    # generates a template at the specific path
    def self.generate(sheet_name, sheet_index, columns, base_template_path, output_path)
      Seek::SampleTemplates::Generator.new(
          output_path, create_json(sheet_name,sheet_index,columns,base_template_path)
      ).generate
    end

    def self.create_json(sheet_name,sheet_index,columns,base_template_path)
      definition = { sheet_name: sheet_name,
        sheet_index: sheet_index,
        columns: columns.collect(&:as_json) }
      definition[:base_template_path]=base_template_path if base_template_path
      definition.to_json
    end

    private_class_method :create_json
  end
end
