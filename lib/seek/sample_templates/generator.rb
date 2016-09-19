require 'cocaine'

module Seek
  module SampleTemplates
    # Generator class for creating templates.
    # Generally this shouldn't be used directly, but instead should be used
    # through Seek::SampleTemplates.generate(..)
    class Generator
      JAR_VERSION = '0.2'.freeze
      JAR_PATH = File.dirname(__FILE__) +
                 "/../../../jars/sample-template-generator-#{JAR_VERSION}.jar"
      DEFAULT_MEMORY_ALLOCATION = '512M'.freeze
      BUFFER_SIZE = 250_000 # 1/4 a megabyte

      attr_reader :json, :path, :memory_allocation

      def initialize(path, json, memory_allocation = DEFAULT_MEMORY_ALLOCATION)
        @path = path
        @json = json
        @memory_allocation = memory_allocation
      end

      def generate
        run_with_cocaine
      end

      private

      def command
        command = "java -Xmx#{@memory_allocation} -jar #{JAR_PATH}"
        command += " -f '#{path}'"
        command += " -j '#{json}'"
        command
      end

      def run_with_cocaine
        output = Cocaine::CommandLine.new(command).run
        output.strip
      rescue Cocaine::ExitStatusError => exception
        raise exception.message
      end
    end
  end
end
