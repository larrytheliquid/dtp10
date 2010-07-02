require 'rubygems'
require 'test/unit'

METHODS = [:get, :put, :post, :delete]

Request = Struct.new(:method)

class Request
  def initialize(method)
    @method = method
  end

  def method() @method end
end

STATUSES = [:ok, :created, :internal_error]
