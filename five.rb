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

  def test_internal_error_resolve
    req = mock
    req.stubs(:created?).returns(false)
    assert_equal Request.resolve(req), :internal_error
  end

end
