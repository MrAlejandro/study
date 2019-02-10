module Inatra
  class << self
    ALLOWED_VERBS = [:get, :post].freeze
    NOT_FOUND = [404, {}, ['Not Found']].freeze

    def routes(&block)
      @routes ||= {}
      instance_exec(&block)
    end

    def call(env)
      verb = env.fetch('REQUEST_METHOD').downcase.to_sym
      path = env.fetch('PATH_INFO').to_sym
      response(verb, path) || NOT_FOUND
    end

    def method_missing(method_name, *args, &block)
      path = args.first.to_s
      register_route(method_name, path, block)
    end

    def respond_to_missing?(method_name)
      ALLOWED_VERBS.include?(method_name)
    end

    protected

    def register_route(verb, path, deferred)
      @routes[verb] ||= {}
      @routes[verb][path.to_sym] = deferred
    end

    def response(verb, path)
      deferred = stored_routes.dig(verb, path)
      deferred&.call
    end

    def stored_routes
      @routes || {}
    end
  end
end
