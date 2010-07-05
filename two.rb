require 'core'

class Request
  def created?() raise end

  def self.resolve(_)
    :created
  end
end

class UnitTests < Test::Unit::TestCase
  def test_created_resolve
    req = Request.new(:post)
    req.stubs(:created?).returns(true)
    assert_equal Request.resolve(req),
                 :created
  end
end
