require 'core'

class Request
  def created?
    case method
    when :put  then true
    when :post then true
    else            false
    end
  end
end

class UnitTests < Test::Unit::TestCase

  def req(method)
    Request.new(method)
  end

  def test_post_created?
    assert_equal req(:post).created?, true
  end

  def test_get_created?
    assert_equal req(:get).created?, true
  end

  # 1) Failure:
  # test_get_created?(UnitTests)
  # <false> expected but was <true>.

end
