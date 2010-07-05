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

* Assertion
* Stub
* Mock
* Unit test
* Integration test
* Test-driven development (TDD)

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

    class UnitTests < Test::Unit::TestCase
      def test_method
        req = Request.new(:post)
        assert_equal req.method, :post
      end
    end

!NOTES 

flipped assert_equal argument order to make it look more similar

TODO: mutter unit tests

!SLIDE
# Well-typed propositional equality #

    test-method : method (req POST) ≡ POST
    test-method = refl

!SLIDE
# Failing assertion #

    class UnitTests < Test::Unit::TestCase
      def test_method
        req = Request.new(:post)
        assert_equal req.method, :get
      end
    end

    # 1) Failure:
    # test_method(UnitTests)
    # <:get> expected but was <:post>.

!SLIDE
# Ill-typed propositional equality #

    test-method : method (req POST) ≡ GET
    test-method = refl

    -- POST != GET of type Method
    -- when checking that the expression refl
    --   has type POST ≡ GET

!SLIDE
# Stub #

    class Request
      def created?() raise end

      def self.resolve(_)
        :created
      end
    end

    class UnitTests < Test::Unit::TestCase
      def test_created_resolve
        req = Request.new(:post)
        req.stubs(:created?).returns(true)
        assert_equal Request.resolve(req),
                     :created
      end
    end

!SLIDE

    class UnitTests < Test::Unit::TestCase
      def test_internal_error_resolve
        req = Request.new(:delete)
        req.stubs(:created?).returns(false)
        assert_equal Request.resolve(req),
                     :internal_error
      end
    end

!SLIDE
# Hypothetical propositional equality #

    postulate created? : Request → Bool

    resolve : Request → Status
    resolve _ = Created

    test-created-resolve :
      created? (req POST) ≡ true →
      resolve  (req POST) ≡ Created
    test-created-resolve p rewrite p =
      refl

!SLIDE

    test-internal-error-resolve :
      created? (req DELETE) ≡ false →
      resolve  (req DELETE) ≡ InternalError
    test-internal-error-resolve p rewrite p =
      refl

!SLIDE
# Well-typed universal quantification #

    test-created-resolve : ∀ {r} →
      created? r ≡ true →
      resolve  r ≡ Created
    test-created-resolve p rewrite p =
      refl

    test-internal-error-resolve : ∀ {r} →
      created? r ≡ false →
      resolve  r ≡ InternalError
    test-internal-error-resolve p rewrite p =
      refl

!SLIDE
# Mock with stub #

    class UnitTests < Test::Unit::TestCase
      def test_created_resolve
        req = mock
        req.stubs(:created?).returns(true)
        assert_equal Request.resolve(req),
                     :created
      end

      def test_internal_error_resolve
        req = mock
        req.stubs(:created?).returns(false)
        assert_equal Request.resolve(req),
                     :internal_error
      end
    end

!SLIDE
# Ill-typed universal quantification #

    test-created-resolve : ∀ {r} →
      resolve r ≡ Created
    test-created-resolve = refl

    -- resolve .r | (created? .r | method .r) !=
    --   Created of type Status
    -- when checking that the expression refl
    --   has type (resolve .r | (created? .r |
    --   method .r)) ≡ Created

!SLIDE
# Mock without stub #

    class UnitTests < Test::Unit::TestCase
      def test_created_resolve
        req = mock
        assert_equal Request.resolve(req),
                     :created
      end
    end

    test_created_resolve(UnitTests)
      ['resolve' in 'test_created_resolve']:
    unexpected invocation: 
      #<Mock:0x1011a0d18>.created?()

!SLIDE
# Ruby resolve implementation #

    class Request
      def self.resolve(r)
        if r.created?
          :created
        else
          :internal_error
        end
      end
    end

!SLIDE
# Agda resolve implementation #

    resolve : Request → Status
    resolve r with created? r
    ... | true  = Created
    ... | false = InternalError
