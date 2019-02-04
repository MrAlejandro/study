module Exercise
  module Fp
    class << self
      # Обратиться к параметрам фильма можно так:
      # film["name"], film["rating_kinopoisk"], film["rating_imdb"],
      # film["genres"], film["year"], film["access_level"], film["country"]
      def rating(films)
        summary =
          films
          .select { |film| film['country'].to_s.split(',').size > 1 && film['rating_kinopoisk'].to_f.positive? }
          .reduce(rating: 0.0, qty: 0) do |acc, movie|
            { rating: acc[:rating] + movie['rating_kinopoisk'].to_f, qty: acc[:qty] + 1 }
          end

        summary[:rating] / summary[:qty]
      end

      def chars_count(films, threshold)
        films
          .select { |film| film['rating_kinopoisk'].to_f >= threshold }
          .reduce(0) { |qty, film| qty + film['name'].count('и') }
      end
    end
  end
end
