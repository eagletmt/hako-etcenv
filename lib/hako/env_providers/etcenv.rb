require 'etcd'
require 'etcenv/environment'
require 'hako/env_provider'
require 'openssl'
require 'uri'

module Hako
  module EnvProviders
    class Etcenv < EnvProvider
      def initialize(_root_path, options)
        unless options['url']
          validation_error!('url must be set')
        end
        unless options['root']
          validation_error!('root must be set')
        end
        @uri = URI.parse(options.fetch('url'))
        @ca_file = options.fetch('ca_file', nil)
        @ssl_cert = options.fetch('ssl_cert', nil)
        @ssl_key = options.fetch('ssl_key', nil)
        @root = options.fetch('root')
      end

      def ask(variables)
        env = {}
        ::Etcenv::Environment.new(etcd_client, @root).expanded_env.each do |key, val|
          if variables.include?(key)
            env[key] = val
          end
        end
        env
      end

      def can_ask_keys?
        false
      end

      private

      def etcd_client
        @etcd_client ||= Etcd.client(
          host: @uri.host,
          port: @uri.port,
          use_ssl: @uri.scheme == 'https',
          ca_file: @ca_file,
          ssl_cert: ssl_cert(@ssl_cert),
          ssl_key: ssl_key(@ssl_key),
        )
      end

      def ssl_cert(cert_path)
        if cert_path
          OpenSSL::X509::Certificate.new(::File.read(cert_path))
        end
      end

      def ssl_key(key_path)
        if key_path
          OpenSSL::PKey::RSA.new(::File.read(key_path))
        end
      end
    end
  end
end
