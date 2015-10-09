require 'etcd'
require 'etcenv/environment'
require 'hako/env_provider'
require 'uri'

module Hako
  module EnvProviders
    class Etcenv < EnvProvider
      def initialize(options)
        unless options['url']
          validation_error!('url must be set')
        end
        unless options['root']
          validation_error!('root must be set')
        end
        uri = URI.parse(options.fetch('url'))
        @etcd = Etcd.client(
          host: uri.host,
          port: uri.port,
          use_ssl: uri.scheme == 'https',
          ca_file: options.fetch('ca_file', nil),
          ssl_cert: options.fetch('ssl_cert', nil),
          ssl_key: options.fetch('ssl_key', nil),
        )
        @root = options.fetch('root')
      end

      def ask(variables)
        env = {}
        ::Etcenv::Environment.new(@etcd, @root).expanded_env.each do |key, val|
          if variables.include?(key)
            env[key] = val
          end
        end
        env
      end
    end
  end
end
