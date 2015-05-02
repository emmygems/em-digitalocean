module Digitalocean
  module ClassMethods
    using EventObject
    extend self

    def ns(name, &b)
      self.def name do
        this = self
        Object.new.tap do |ob|
          ob.def :bind do |object, klass|
            ClassMethods.bind this, object, klass
          end
          ob.instance_exec(self, &b)
        end
      end
    end

    def bind(api, object, klass)
      raise "#{klass} is not API object" unless klass.respond_to?(:api)

      klass.api.each do |name, params|
        variables = Addressable::Template.new(params[:path]).variables

        # auto-bind for no variables
        if variables.empty? && !object.respond_to?(name)
          object.def name do
            api.op klass.send(name)
          end
        end

        # auto-bind for id variable
        if variables.size == 1
          var_name = variables.first

          object.def name do |value|
            api.op klass.send(name, params: {var_name => value})
          end
        end

        if variables.size == 2
          var_name1 = variables.first
          var_name2 = variables.last

          object.def name do |var1, var2|
            api.op klass.send(name, params: { var_name1 => var1, var_name2 => var2 })
          end
        end
      end
    end

    #<<<
  end
end
