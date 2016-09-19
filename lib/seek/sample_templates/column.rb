module Seek
  module SampleTemplates
    class Column
      attr_accessor :name, :contents
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
