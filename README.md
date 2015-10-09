# Hako::EnvProviders::Etcenv
Provide variables from [etcd](https://github.com/coreos/etcd) to [hako](https://github.com/eagletmt/hako) using [etcenv](https://github.com/sorah/etcenv).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hako-etcenv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hako-etcenv

## Usage

```yaml
image: ryotarai/hello-sinatra
env:
  $providers:
    - type: etcenv
      url: https://127.0.0.1:2379
      ca_file: /etc/etcd/ca.crt
      ssl_cert: /etc/etcd/client.crt
      ssl_key: /etc/etcd/client.key
      root: /hako/hello-sinatra
  PORT: 3000
  MESSAGE: '#{username}-san!'
port: 3000
scheduler:
  type: echo
```

It pulls `username` variable from etcd with `/hako/hello-sinatra/username` key.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hako-etcenv.

