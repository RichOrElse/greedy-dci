module Greedy
  module DCI
    class Role
      def initialize(obj)
        @obj = obj
      end

      def as(responsibility)
        type = @obj.singleton_class
        Module.new { refine(type) { prepend responsibility } }
      end

      def self.to_proc
        method(:new).to_proc
      end
    end
  end
end
