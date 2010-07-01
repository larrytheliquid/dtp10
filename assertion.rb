require 'core'

def created?(method)
  case method
  when :put  then true
  when :post then true
  else            false
  end
end

class UnitTests < Test::Unit::TestCase

  def test_post_created?
    assert_equal created?(:post), true
  end

  # def test_get_created?
  #   assert_equal created?(:get), true
  # end

  # 1) Failure:
  # test_get_created?(UnitTests)
  # <false> expected but was <true>.

end
