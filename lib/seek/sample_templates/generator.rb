require 'open4'

module Seek
  module SampleTemplates
    def self.generate(sheet_name, sheet_index, columns, path)
      Seek::SampleTemplates::Generator.new(path, create_json(columns, sheet_index, sheet_name)).generate
    end

    def self.create_json(columns, sheet_index, sheet_name)
      { sheet_name: sheet_name, sheet_index: sheet_index, columns: columns.collect(&:as_json) }.to_json
    end

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

    class Generator
      JAR_VERSION = '0.2'.freeze
      JAR_PATH = File.dirname(__FILE__) + "/../../../jars/sample-template-generator-#{JAR_VERSION}.jar"
      DEFAULT_MEMORY_ALLOCATION = '512M'.freeze
      BUFFER_SIZE = 250_000 # 1/4 a megabyte

      attr_accessor :json, :path, :memory_allocation

      def initialize(path, json, memory_allocation = DEFAULT_MEMORY_ALLOCATION)
        @path = path
        @json = json
        @memory_allocation = memory_allocation
        raise Exception, 'Windows is not currently supported' if windows?
      end

      def generate
        run_with_open4
      end

      private

      def command
        command = "java -Xmx#{@memory_allocation} -jar #{JAR_PATH}"
        command += " -f '#{path}'"
        command += " -j '#{json}'"
        command
      end

      def run_with_open4
        output = ''
        err_message = ''
        command = command()
        status = Open4.popen4(command) do |_pid, _stdin, stdout, stderr|
          until (line = stdout.gets(BUFFER_SIZE)).nil?
            output << line
          end
          stdout.close

          until (line = stderr.gets(BUFFER_SIZE)).nil?
            err_message << line
          end
          stderr.close
        end

        raise err_message if status.to_i.nonzero?

        output.strip
      end

      def windows?
        !(RUBY_PLATFORM =~ /mswin32/ || RUBY_PLATFORM =~ /mingw32/).nil?
      end
    end
  end
end
