require 'core'

class UnitTests < Test::Unit::TestCase
  def test_created_resolve
    req = Request.new(:post)
    req.stubs(:created?).returns(true)
    assert_equal Request.resolve(req), :created
  end
end

#   1) Error: test_created_resolve(UnitTests):
# NoMethodError: undefined method `resolve' for Request:Class
