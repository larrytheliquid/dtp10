require 'core'

class Request
  def self.resolve(r)
    if r.created?
      :created
    else
      :internal_error
    end
  end
end

class UnitTests < Test::Unit::TestCase

  def test_created_resolve
    req = mock
    req.stubs(:created?).returns(true)
    assert_equal Request.resolve(req), :created
  end

  def test_post_created
    req = mock
    req.stubs(:method).returns(:post)
    assert_equal req.created?, true
  end

end
