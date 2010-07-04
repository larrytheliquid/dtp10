require 'rubygems'
require 'test/unit'
require 'mocha'

METHODS = [:get, :put, :post, :delete]

class Request
  def initialize(method)
    @method = method
  end

  def method() @method end
end

STATUSES = [:ok, :created, :internal_error]
