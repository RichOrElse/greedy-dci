require 'test_helper'

class Greedy::DciTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Greedy::DCI::VERSION
  end

  def test_greedy_has_context_method
    assert Greedy.method(:context)
  end
end
