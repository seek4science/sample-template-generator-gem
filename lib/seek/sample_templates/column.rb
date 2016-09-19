module Seek
  module SampleTemplates
    # Describes a column in the template.
    # The name is the text put in the top row,
    # and contents will create a dropdown in the row below unless empty
    class Column
      attr_reader :name, :contents

      def initialize(name, contents = [])
        @name = name
        @contents = contents
      end

      def as_json
        { @name => @contents }
      end
    end
  end
end
