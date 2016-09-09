require 'open4'

module Seek
  module SampleTemplates
    class Generator
      JAR_VERSION = '0.1'.freeze
      JAR_PATH = File.dirname(__FILE__) + "/../../../jars/sample-template-generator-#{JAR_VERSION}.jar"
      DEFAULT_MEMORY_ALLOCATION = '512M'.freeze
      BUFFER_SIZE = 250_000 # 1/4 a megabyte

      attr_accessor :json, :path, :memory_allocation

      def initialize(path, json, memory_allocation = DEFAULT_MEMORY_ALLOCATION)
        @path = path
        @json = json
        @memory_allocation = memory_allocation
        raise Exception, 'Windows is not currently supported' if is_windows?
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
          while (line = stdout.gets(BUFFER_SIZE)) != nil
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

      def is_windows?
        !(RUBY_PLATFORM =~ /mswin32/ || RUBY_PLATFORM =~ /mingw32/).nil?
      end
    end
  end
end
