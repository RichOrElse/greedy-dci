require 'test_helper'

class Greedy::DciTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Greedy::DCI::VERSION
  end

  def test_greedy_has_context_method
    assert Greedy.method(:context)
  end

  def test_context_to_proc
    ctx = Greedy.context { |input| def call() :output end }

    assert ctx[input: nil].to_proc
    assert_equal :output, ctx[input: nil].to_proc.call
  end

  def test_context_square_brackets
    ctx = Greedy.context { |a| def call(b:) a + b end }

    assert_equal 3, ctx[a: 1][b: 2]
  end
end
