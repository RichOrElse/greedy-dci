module Greedy
  module DCI
    module Context
      def to_proc
        method(:call).to_proc
      end
    end
  end
end
