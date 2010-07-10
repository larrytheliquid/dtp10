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

#     1) Failure:
# test_created_resolve(Tests)
#     [in `meth'
#      in `created?'
#      in `resolve'
#      in `test_created_resolve']:
# unexpected invocation: #<Mock:0x1011a0340>.meth()
end
