require 'cocaine'

module Seek
  module SampleTemplates
    class Generator
      JAR_VERSION = '0.2'.freeze
      JAR_PATH = File.dirname(__FILE__) +
                 "/../../../jars/sample-template-generator-#{JAR_VERSION}.jar"
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
        run_with_cocaine
      end

      def command
        command = "java -Xmx#{@memory_allocation} -jar #{JAR_PATH}"
        command += " -f '#{path}'"
        command += " -j '#{json}'"
        command
      end

      def run_with_cocaine
        output = Cocaine::CommandLine.new(command).run
        output.strip
      rescue Cocaine::ExitStatusError => e
        raise e.message
      end

      def windows?
        !(RUBY_PLATFORM =~ /mswin32/ || RUBY_PLATFORM =~ /mingw32/).nil?
      end
    end
  end
end
