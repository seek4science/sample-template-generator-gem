require 'seek/sample_templates/column'
require 'seek/sample_templates/generator'

module Seek
  # Main entry point for generating templates
  module SampleTemplates
    # generates a template at the specific path
    def self.generate(sheet_name, sheet_index, columns, path)
      Seek::SampleTemplates::Generator.new(
        path, create_json(columns, sheet_index, sheet_name)
      ).generate
    end

    def self.create_json(columns, sheet_index, sheet_name)
      { sheet_name: sheet_name,
        sheet_index: sheet_index,
        columns: columns.collect(&:as_json) }.to_json
    end

    private_class_method :create_json
  end
end
