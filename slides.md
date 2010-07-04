!SLIDE

Unit & integration test composition via lemmas
==============================================

!NOTES

Hearing unit & integration tests within the context of dependent typing
may seem strange... we would expect to hear terms closer to lemmas &
proofs. Although all dependently typed examples shown here will indeed
be equivalent to proofs, we will show a way of developing dependently
typed software that feels familiar to users of less formal languages,
but has extra benefits.

Hopefully as a result experienced programmers will have an easier time
transitioning to DTP. Conversely, established software development
techniques might help illuminate similar techniques within the young
field of dependently typed software development.

Ruby used for examples of more mainstream software development, and
Agda used for the dependently typed examples.

TODO: mutter composition
TODO: mutter interactive theorem proving
TODO: put in prop equality type slide

!SLIDE bullets
# Software testing #

* assertions
* unit tests
* integration tests

!NOTES

Specifically using the domain of testing

!SLIDE
# Agda data #

    data Method : Set where
      GET PUT POST DELETE : Method

    record Request : Set where
      constructor req
      field
        method : Method

    open Request public

    data Status : Set where
      OK Created InternalError : Status

!NOTES

Small & incomplete data type core to be used for code examples of a
toy version of the web application problem domain.

!SLIDE
# Ruby data #

    METHODS = [:get, :put, :post, :delete]

    class Request
      def initialize(method)
        @method = method
      end

      def method() @method end
    end

    STATUSES = [:ok, :created, :internal_error]

!SLIDES
# Passing assertion #

    def created?(method)
      case method
      when :put  then true
      when :post then true
      else            false
      end
    end

    class UnitTests < Test::Unit::TestCase
      def test_post_created?
        assert_equal created?(:post), true
      end
    end

!NOTES 

flipped assert_equal argument order to make it look more similar

TODO: mutter unit tests

!SLIDE
# Well-typed propositional equality #

    created? : Method → Bool
    created? PUT  = true
    created? POST = true
    created? _    = false

    test-POST-created? : created? POST ≡ true
    test-POST-created? = refl

!SLIDE
# Failing assertion #

    class UnitTests < Test::Unit::TestCase
      def test_get_created?
        assert_equal created?(:get), true
      end
    end

    # 1) Failure:
    # test_get_created?(UnitTests)
    # <true> expected but was <false>.

!SLIDE
# Ill-typed propositional equality #

    test-GET-created? : created? GET ≡ true
    test-GET-created? = refl

    -- false != true of type Bool
    -- when checking that the expression refl
    -- has type false ≡ true

!SLIDE
# Mock/stub/expectation testing #

!NOTES

mention that we POST could be wrong, but we are free to assume
whatever we want and properly reason using those assumptions (whether
or not we can provide examples of those assumptions is another matter)

!NOTES

you can think of stub as transforming a test from a propeq typing
judgement into a hypothetical propeq typing judgement
