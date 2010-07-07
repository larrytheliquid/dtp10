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
    stubs(:created?).with(req_post).returns(true)
    assert_equal resolve(req_post),
                 :created
  end

  def test_internal_error_resolve
    stubs(:created?).with(req_delete).returns(false)
    assert_equal resolve(req_delete),
                 :internal_error
  end
end
