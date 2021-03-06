require 'sidekiq'
require 'forwardable'
require 'routemaster/client/backends/sidekiq/worker'
require 'routemaster/client/backends/sidekiq/configuration'

module Routemaster
  module Client
    module Backends
      class Sidekiq
        class << self
          extend Forwardable

          attr_reader :options

          def configure
            self.tap do
              Configuration.configure do |c|
                yield c
              end
              @options = {'class' => Worker}.merge Configuration.sidekiq_options
            end
          end

          def send_event(*args)
            opts = @options.merge('args' => args)
            ::Sidekiq::Client.push opts

            # The push will throw an exception if there is a problem
            true
          end
        end
      end
    end
  end
end
