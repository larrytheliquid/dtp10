require 'rubygems'
require 'test/unit'
require 'mocha'

METHODS  = [:get, :put, :post, :delete]

Request  = Struct.new(:method)

def req(m)       Request.new(m)               end
def meth(r)      r.method                     end

def req_post()   @req_post   ||= req(:post)   end
def req_delete() @req_delete ||= req(:delete) end

STATUSES = [:ok, :created, :internal_error]
