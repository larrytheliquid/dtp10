!SLIDE

Unit & integration test composition via lemmas
==============================================
Larry Diehl
-----------

<div style="display: none;">

A shared general semantics between informal & formal software
verification.

Noticed similarity while working on the verification of an Agda-based
web framework.

Hearing unit & integration tests within the context of dependent typing
may seem strange... we would expect to hear terms closer to lemmas &
proofs. Although all dependently typed examples shown here will indeed
be equivalent to proofs, we will show a way of developing dependently
typed software that feels familiar to users of less formal languages,
but has extra benefits.

Ruby used for examples of more mainstream software development, and
Agda used for the dependently typed examples.

!SLIDE
# Motivations #

<div style="display: none;">

A lot more informal software engineers than dependently typed
programmers.

Hopefully as a result experienced programmers will have an easier time
transitioning to DTP. Conversely, established software development
techniques might help illuminate similar techniques within the young
field of dependently typed software development.
... help both fields understand each other.

!SLIDE
# Algebraic datatypes & records #

    data Method : Set where
      GET PUT POST DELETE : Method

    record Request : Set where
      constructor req
      field
        meth : Method
    open Request public

    req-post   = req POST
    req-delete = req DELETE

    data Status : Set where
      OK Created InternalError : Status

<div style="display: none;">

Small & incomplete data type core to be used for code examples of a
toy version of the web application problem domain.

!SLIDE
# Constants & classes #

    METHODS  = [:get, :put, :post, :delete]

    Request  = Struct.new(:meth)

    def req(m) Request.new(m) end
    def meth(r) r.meth end

    def req_post
      @req_post ||= req(:post)
    end
    def req_delete
      @req_delete ||= req(:delete)
    end

    STATUSES = [:ok, :created, :internal_error]

!SLIDES
# Equality assertion (passing) #

    class Tests < Test::Unit::TestCase
      def test_meth
        assert_equal meth(req_post), :post
      end
    end

<div style="display: none;"> 

flipped assert_equal argument order to make it look more similar

!SLIDE
# Propositional equality #

    data _≡_ {a : Set} (x : a) : a → Set where
      refl : x ≡ x

!SLIDE
# Propositional equality (well-typed) #

    test-meth : meth req-post ≡ POST
    test-meth = refl

!SLIDE
# Equality assertion (failing) #

    class Tests < Test::Unit::TestCase
      def test_meth
        assert_equal meth(req_post), :get
      end
    end

    # 1) Failure:
    # test_meth(Tests)
    # <:get> expected but was <:post>.

!SLIDE
# Propositional equality (ill-typed) #

    test-meth : meth req-post ≡ GET
    test-meth = refl

    -- POST != GET of type Method
    -- when checking that the expression refl
    --   has type POST ≡ GET

!SLIDE
# `created?` (diverging) & `resolve` (complete) #

    def created?(_) raise end

    def resolve(r)
      if created?(r)
        :created
      else
        :internal_error
      end
    end

!SLIDE
# `created?` (postulated) & `resolve` (complete) #

    postulate created? : Request → Bool

    resolve : Request → Status
    resolve r with created? r
    ... | true  = Created
    ... | false = InternalError

!SLIDE
# Stub #

    class Tests < Test::Unit::TestCase
      def test_created_resolve
        stubs(:created?).
          with(req_post).returns(true)
        assert_equal resolve(req_post),
                     :created
      end

      def test_internal_error_resolve
        stubs(:created?).
          with(req_delete).returns(false)
        assert_equal resolve(req_delete),
                     :internal_error
      end
    end

!SLIDE
# Hypothetical propositional equality #

    test-created-resolve :
      created? req-post ≡ true →
      resolve req-post ≡ Created
    test-created-resolve p rewrite p =
      refl

    test-internal-error-resolve :
      created? req-delete ≡ false →
      resolve req-delete ≡ InternalError
    test-internal-error-resolve p rewrite p =
      refl

!SLIDE
# Universal quantification (with hypothesis) #

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
# Mock (with stub) #

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

!SLIDE
# `created?` (complete) #

    class Request
      def created?
        meth == :post
      end
    end

---------------------------------------

    created? : Request → Bool
    created? r with meth r
    ... | POST = true
    ... | _    = false

<div style="display: none;">

No need to change tests/proofs (refactoring)

Mock differs in the complete scenario in that it still requires a
stub, & similarly universal quantification still requires a hypothesis

!SLIDE
# Universal quantification (no hypothesis) #

    test-created-resolve : ∀ {r} →
      resolve r ≡ Created
    test-created-resolve = refl

    -- resolve .r | (created? .r | meth .r) !=
    --   Created of type Status
    -- when checking that the expression refl
    --   has type (resolve .r | (created? .r |
    --   meth .r)) ≡ Created

<div style="display: none;">

Universal quantification in affect causes all functions that use it to
behave as if they were postulated/diverging

!SLIDE
# Mock (no stub) #

    class Tests < Test::Unit::TestCase
      def test_created_resolve
        r = mock
        assert_equal resolve(r), :created
      end
    end

    #     1) Failure:
    # test_created_resolve(Tests)
    #     [in `meth'
    #      in `created?'
    #      in `resolve'
    #      in `test_created_resolve']:
    # unexpected invocation:
    #   #<Mock:0x1011a0340>.meth()

<div style="display: none;">

Mocked methods simply do not have methods defined

To see how mock / universal quantification differs we must look at
what happens when created? is completed

!SLIDE
# Proof composition #

    test-POST-created : ∀ {r} →
      meth r ≡ POST →
      created? r ≡ true
    test-POST-created p rewrite p = refl

    test-POST-resolve : ∀ {r} →
      meth r ≡ POST →
      resolve r ≡ Created
    test-POST-resolve p =
      test-created-resolve (test-POST-created p)

!SLIDE
# Test composition #

    class Tests < Test::Unit::TestCase
      def test_created_resolve
        r = mock
        stubs(:created?).with(r).returns(true)
        assert_equal resolve(r), :created
      end
    end

---------------------------------------

    class Tests < Test::Unit::TestCase
      def test_created_resolve(r=mock)
        stubs(:created?).with(r).returns(true)
        assert_equal resolve(r), :created
        r
      end
    end

!SLIDE
# Test composition #

    class Tests < Test::Unit::TestCase
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
    end

!SLIDE bullets
# Last remarks #

* Stronger must-diverge stub
* lazy vs strict

<div style="display: none;">

More similarities than shown. For example, if diverging functions are
defined but never used than of course they will not cause failures.

Further, informal version fails on method invocation while formal
version fails on unsolvable case analysis.

Rewrites may be performed more than once, just as stubs with multiple
values may be defined.

Composition becomes powerful with things like the Middleware type.

!SLIDE
# Questions? #
