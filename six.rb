require 'core'

def created?(r)
  meth(r) == :post
end

def resolve(r)
  if created?(r)
    :created
  else
    :internal_error
  end
end

class Tests < Test::Unit::TestCase
  def test_created_resolve(r=mock)
    stubs(:created?).with(r).returns(true)
    assert_equal resolve(r), :created
    r
  end

  def test_post_created(r=mock)
    stubs(:meth).with(r).returns(:post)
    assert_equal created?(r), true
    r
  end

  def test_post_resolve(r=mock)
    test_created_resolve(test_post_created(r))
    assert_equal resolve(r), :created
    r
  end

  def test_post_resolve2
    r = mock
    stubs(:meth).with(r).returns(:post)
    assert_equal resolve(r), :created
  end
end
