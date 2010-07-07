require 'core'

def created?(_) raise    end

def resolve(_)  :created end

class Tests < Test::Unit::TestCase
  def test_created_resolve
    stubs(:created?).with(req_post).returns(true)
    assert_equal resolve(req_post),
                 :created
  end
end
