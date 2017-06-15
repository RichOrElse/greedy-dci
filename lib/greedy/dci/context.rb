module Greedy
  module DCI
    module Context
      def to_proc
        method(:call).to_proc
      end

      def [](*args)
        call(*args)
      end
    end
  end
end
