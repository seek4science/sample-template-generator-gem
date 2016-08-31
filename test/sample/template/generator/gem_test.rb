require 'test_helper'

class Sample::Template::Generator::GemTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sample::Template::Generator::Gem::VERSION
  end


end
