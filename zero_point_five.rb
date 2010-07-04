require 'core'

class Request
  def created?() end
end

class UnitTests < Test::Unit::TestCase

  def test_created_resolve
    req = Request.new(:post)
    req.stubs_only_defined(:created?).returns(true)
    assert_equal Request.resolve(req), :created
  end

end

#   1) Error: test_created_resolve(UnitTests):
# NoMethodError: undefined method `resolve' for Request:Class
