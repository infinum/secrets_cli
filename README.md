# SecretsCli

This is a CLI for easier use of [vault](https://www.vaultproject.io/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'secrets_cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install secrets_cli

## Prerequisites

`vault` must be installed on system. This gem adds a dependancy to `vault-binaries` which will install `vault` for you.

Following environemt variables need to be set:
   VAULT_ADDR - this is an address to vault server
   SECRETS_VAULT_AUTH_METHOD - this is auth method ('github' or 'token' supported for now)
   SECRETS_VAULT_AUTH_TOKEN - this is vault auth token

## Usage

All commands have --help with detailed descriptions of options.
Some of the commands have --verbose switch which will print out the commands it run.

### Init

    $ secrets init

This will create `.secrets` file with project configuration. The command will ask you all it needs to know if you do not
supply the config through options.

### Auth

    $ secrets auth

You need to first authenticate yourself on vault server to be able to read and write.
Needs to be done only once for token.

### Read

    $ secrets read

This will only read from vault.

### Pull

    $ secrets pull

This will pull from vault and write to your secrets file.

### Push

    $ secrets push

This will push from your secrets file to vault.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/secrets_cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

