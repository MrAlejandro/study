module Exercise
  module Arrays
    class << self
      def replace(array)
        max = array.max
        array.map { |num| num.positive? ? max : num }
      end

      def search(array, query)
        size = array.size
        return -1 if size.zero?

        iter = lambda do |left, right|
          return -1 if right < left

          mid_index = left + (right - left) / 2
          return mid_index if array[mid_index] == query

          left, right = array[mid_index] > query ? [left, mid_index - 1] : [mid_index + 1, right]
          iter.call(left, right)
        end

        iter.call(0, size - 1)
      end
    end
  end
end
