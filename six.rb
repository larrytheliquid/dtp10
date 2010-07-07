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

  def test_post_created
    r = mock
    stubs(:method).with(r).returns(:post)
    assert_equal created?(r), true
  end
end
