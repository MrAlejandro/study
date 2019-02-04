module Exercise
  module Fp2
    class MyArray < Array
      # Использовать стандартные функции массива для решения задач нельзя.
      # Использовать свои написанные функции для реализации следующих - можно.

      # Написать свою функцию my_each
      def my_each
        for item in self
          yield item
        end
        self
      end

      # Написать свою функцию my_map
      def my_map
        new_arr = MyArray.new
        my_each { |item| new_arr << yield(item) }
        new_arr
      end

      # Написать свою функцию my_compact
      def my_compact
        new_arr = MyArray.new
        my_each { |item| new_arr << item unless item.nil? }
        new_arr
      end

      # Написать свою функцию my_reduce
      def my_reduce(initial = nil)
        acc = initial
        my_each do |item|
          acc = acc.nil? ? item : yield(acc, item)
        end
        acc
      end
    end
  end
end
