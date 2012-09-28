module Her
  module Model
    # This module interacts with Her::API to fetch HTTP data
    module HTTP
      # Automatically inherit a superclass' api
      def her_api # {{{
        @her_api ||= begin
          superclass.her_api if superclass.respond_to?(:her_api)
        end
      end # }}}

      # Link a model with a Her::API object
      def uses_api(api) # {{{
        @her_api = api
      end # }}}

      # Main request wrapper around Her::API. Used to make custom request to the API.
      # @private
      def request(params={}) # {{{
        parsed_data = her_api.request(default_params.merge(params))
        if block_given?
          yield parsed_data
        else
          parsed_data
        end
      end # }}}

      # Make a GET request and return either a collection or a resource
      #
      # @example
      #   class User
      #     include Her::Model
      #   end
      #
      #   @popular_users = User.get(:popular)
      #   # Fetched via GET "/users/popular"
      def get(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        get_raw(path, params) do |parsed_data|
          if parsed_data[:data].is_a?(Array)
            new_collection(parsed_data)
          else
            new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
          end
        end
      end # }}}

      # Make a GET request and return the parsed JSON response (not mapped to objects)
      def get_raw(path, params={}, &block) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        request(params.merge(:_method => :get, :_path => path), &block)
      end # }}}

      # Make a GET request and return a collection of resources
      def get_collection(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        get_raw(path, params) do |parsed_data|
          new_collection(parsed_data)
        end
      end # }}}

      # Make a GET request and return a collection of resources
      def get_resource(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        get_raw(path, params) do |parsed_data|
          new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
        end
      end # }}}

      # Make a POST request and return either a collection or a resource
      def post(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        post_raw(path, params) do |parsed_data|
          if parsed_data[:data].is_a?(Array)
            new_collection(parsed_data)
          else
            new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
          end
        end
      end # }}}

      # Make a POST request and return the parsed JSON response (not mapped to objects)
      def post_raw(path, params={}, &block) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        request(params.merge(:_method => :post, :_path => path), &block)
      end # }}}

      # Make a POST request and return a collection of resources
      def post_collection(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        post_raw(path, params) do |parsed_data|
          new_collection(parsed_data)
        end
      end # }}}

      # Make a POST request and return a collection of resources
      def post_resource(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        post_raw(path, params) do |parsed_data|
          new(parsed_data[:data])
        end
      end # }}}

      # Make a PUT request and return either a collection or a resource
      def put(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        put_raw(path, params) do |parsed_data|
          if parsed_data[:data].is_a?(Array)
            new_collection(parsed_data)
          else
            new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
          end
        end
      end # }}}

      # Make a PUT request and return the parsed JSON response (not mapped to objects)
      def put_raw(path, params={}, &block) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        request(params.merge(:_method => :put, :_path => path), &block)
      end # }}}

      # Make a PUT request and return a collection of resources
      def put_collection(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        put_raw(path, params) do |parsed_data|
          new_collection(parsed_data)
        end
      end # }}}

      # Make a PUT request and return a collection of resources
      def put_resource(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        put_raw(path, params) do |parsed_data|
          new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
        end
      end # }}}

      # Make a PATCH request and return either a collection or a resource
      def patch(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        patch_raw(path, params) do |parsed_data|
          if parsed_data[:data].is_a?(Array)
            new_collection(parsed_data)
          else
            new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
          end
        end
      end # }}}

      # Make a PATCH request and return the parsed JSON response (not mapped to objects)
      def patch_raw(path, params={}, &block) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        request(params.merge(:_method => :patch, :_path => path), &block)
      end # }}}

      # Make a PATCH request and return a collection of resources
      def patch_collection(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        patch_raw(path, params) do |parsed_data|
          new_collection(parsed_data)
        end
      end # }}}

      # Make a PATCH request and return a collection of resources
      def patch_resource(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        patch_raw(path, params) do |parsed_data|
          new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
        end
      end # }}}

      # Make a DELETE request and return either a collection or a resource
      def delete(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        delete_raw(path, params) do |parsed_data|
          if parsed_data[:data].is_a?(Array)
            new_collection(parsed_data)
          else
            new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
          end
        end
      end # }}}

      # Make a DELETE request and return the parsed JSON response (not mapped to objects)
      def delete_raw(path, params={}, &block) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        request(params.merge(:_method => :delete, :_path => path), &block)
      end # }}}

      # Make a DELETE request and return a collection of resources
      def delete_collection(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        delete_raw(path, params) do |parsed_data|
          new_collection(parsed_data)
        end
      end # }}}

      # Make a DELETE request and return a collection of resources
      def delete_resource(path, params={}) # {{{
        path = "#{build_request_path(params)}/#{path}" if path.is_a?(Symbol)
        delete_raw(path, params) do |parsed_data|
          new(parsed_data[:data].merge :_metadata => parsed_data[:data], :_errors => parsed_data[:errors])
        end
      end # }}}

      # Define custom GET requests
      #
      # @example
      #   class User
      #     include Her::Model
      #     custom_get :popular
      #   end
      #
      #   User.popular
      #   # Fetched from GET "/users/popular"
      def custom_get(*paths) # {{{
        metaclass = (class << self; self; end)
        paths.each do |path|
          metaclass.send(:define_method, path.to_sym) do |*args|
            get(path, args.first || Hash.new)
          end
        end
      end # }}}

      # Define custom POST requests
      def custom_post(*paths) # {{{
        metaclass = (class << self; self; end)
        paths.each do |path|
          metaclass.send(:define_method, path.to_sym) do |*args|
            post(path, args.first || Hash.new)
          end
        end
      end # }}}

      # Define custom PUT requests
      def custom_put(*paths) # {{{
        metaclass = (class << self; self; end)
        paths.each do |path|
          metaclass.send(:define_method, path.to_sym) do |*args|
            put(path, args.first || Hash.new)
          end
        end
      end # }}}

      # Define custom PATCH requests
      def custom_patch(*paths) # {{{
        metaclass = (class << self; self; end)
        paths.each do |path|
          metaclass.send(:define_method, path.to_sym) do |*args|
            patch(path, args.first || Hash.new)
          end
        end
      end # }}}

      # Define custom DELETE requests
      def custom_delete(*paths) # {{{
        metaclass = (class << self; self; end)
        paths.each do |path|
          metaclass.send(:define_method, path.to_sym) do |*args|
            delete(path, args.first || Hash.new)
          end
        end
      end # }}}

      # Set default parameters
      def default_params(params = nil)
        if params
          @default_params = params
        else
          @default_params ||= {}
        end
      end
    end
  end
end
