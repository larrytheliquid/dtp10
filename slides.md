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

!SLIDE bullets
# Software testing #

* assertions
* unit tests
* integration tests

!NOTES

Specifically using the domain of testing

!SLIDE
# Agda types #

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
# Ruby types #

    METHODS = [:get, :put, :post, :delete]

    class Request
      def initialize(method)
        @method = method
      end

      def method() @method end
    end

    STATUSES = [:ok, :created, :internal_error]

