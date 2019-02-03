module Exercise
  module Arrays
    class << self
      def replace(array)
        max = array.max
        array.map { |num| num.positive? ? max : num }
      end

      def search(_array, _query)
      end
    end
  end
end
