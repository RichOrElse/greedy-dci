require "greedy/dci/version"
require "greedy/dci/role"
require "greedy/dci/context"

module Greedy
  module DCI
    def context(&block)
      roles = block.parameters.map &:last
      -> **where do
        actors = where.values_at(*roles)
        Struct.new(*roles) do
          include Context
          class_exec(*actors.map(&Role), &block)
        end.new *actors
      end
    end
  end

  extend DCI
end
