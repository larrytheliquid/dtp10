require 'core'

class UnitTests < Test::Unit::TestCase

  def test_created_resolve
    stubs_only_defined(:created?).with(req_post).returns(true)
    assert_equal resolve(req_post), :created
  end

end

#   1) Error: test_created_resolve(Tests):
# NoMethodError: undefined method 'created?'
