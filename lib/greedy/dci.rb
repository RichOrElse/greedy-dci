require "greedy/dci/version"
require "greedy/dci/role"

module Greedy
  module DCI
    def context(&block)
      roles = block.parameters.map &:last
      -> **where do
        actors = where.values_at(*roles)
        Struct.new(*roles) { class_exec(*actors.map(&Role), &block) }.new *actors
      end
    end
  end

  extend DCI
end
