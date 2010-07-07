require 'core'

def created?(r)
  method(r) == :post
end

def resolve(r)
  if created?(r)
    :created
  else
    :internal_error
  end
end

class Tests < Test::Unit::TestCase
  def test_created_resolve
    r = mock
    stubs(:created?).with(r).returns(true)
    assert_equal resolve(r), :created
  end

  def test_internal_error_resolve
    r = mock
    stubs(:created?).with(r).returns(false)
    assert_equal resolve(r), :internal_error
  end
end
