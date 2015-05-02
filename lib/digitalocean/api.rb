module Digitalocean
  class API
    using EventObject
    extend ClassMethods

    attr_accessor :token
    attr_accessor :username
    attr_accessor :password

    def initialize(token: nil, username: nil, password: nil)
      @token    = token
      @username = username
      @password = password
    end

    def operation(request)
      Operation.new(self, request)
    end

    def op(r)
      operation(r)
    end

    ns :account do |api|
      bind self, Account
    end

    ns :account_keys do |api|
      bind self, Account::Keys
    end

    ns :actions do |api|
      bind self, Actions
    end

    ns :domains do |api|
      bind self, Domains
    end

    ns :domain_records do |api|
      bind self, Domains::Records
    end

    ns :droplets do |api|
      # Droplet Actions
      self.def :execute_action do |id, params|
        api.op.call Droplets.execute_action(params: {id: id}, json: params)
      end

      # Disable Backups
      self.def :disable_backups do |id|
        execute_action(id, type: 'disable_backups')
      end

      # Reboot a Droplet
      self.def :reboot do |id|
        execute_action(id, type: 'reboot')
      end

      # Power Cycle a Droplet
      self.def :power_cycle do |id|
        execute_action(id, type: 'power_cycle')
      end

      # Shutdown a Droplet
      self.def :shutdown do |id|
        execute_action(id, type: 'shutdown')
      end

      # Power Off a Droplet
      self.def :power_off do |id|
        execute_action(id, type: 'power_off')
      end

      # Power Off a Droplet
      self.def :power_on do |id|
        execute_action(id, type: 'power_on')
      end

      # Restore a Droplet
      self.def :restore do |id, image|
        execute_action(id, type: 'power_on', image: image)
      end

      # Password reset a Droplet
      self.def :password_reset do |id|
        execute_action(id, type: 'password_reset')
      end

      # Resize a Droplet
      self.def :resize do |id, disk, size|
        execute_action(id, type: 'resize', disk: disk, size: size)
      end

      # Rebuild a Droplet
      self.def :rebuild do |id, image|
        execute_action(id, type: 'rebuild', image: image)
      end

      # Rename a Droplet
      self.def :rename do |id, name|
        execute_action(id, type: 'rename', name: name)
      end

      # Change the Kernel
      self.def :change_kernel do |id, kernel|
        execute_action(id, type: 'change_kernel', kernel: kernel)
      end

      # Enable IPv6
      self.def :enable_ipv6 do |id|
        execute_action(id, type: 'enable_ipv6')
      end

      # Enable Private Networking
      self.def :enable_private_networking do |id|
        execute_action(id, type: 'enable_private_networking')
      end

      # Snapshot a Droplet
      self.def :snapshot do |id|
        execute_action(id, type: 'snapshot')
      end

      # Upgrade a Droplet
      self.def :upgrade do |id|
        execute_action(id, type: 'upgrade')
      end

      # Retrieve a Droplet Action
      self.def :retrive_action do |id, action|
        Droplets.retrieve_action(params: {id: id, action: action})
      end

      # Other API methods
      bind self, Droplets
    end

    ns :images do |api|
      bind self, Images
    end

    ns :regions do |api|
      bind self, Regions
    end

    ns :sizes do |api|
      bind self, Sizes
    end

=begin
    def droplet
      @droplet ||= begin
        droplet = Object.new
        op = method(:operation)

        # Droplet Actions
        droplet.def :execute_action do |id, params|
          op.call Droplet.execute_action(params: {id: id}, json: params)
        end

        # Disable Backups
        droplet.def :disable_backups do |id|
          op.call Droplet.execute_action
        end

        Droplet.api.each do |name, params|
          variables = Addressable::Template.new(params[:path]).variables

          if variables.empty? && !droplet.respond_to?(name)
            droplet.def name do
              op.call Droplet.send(name)
            end
          end

          if variables.include?('id')
            droplet.def name do |id|
              op.call Droplet.send(name, params: {id: id})
            end
          end
        end

        droplet
      end
    end
=end

    #<<<
  end
end
