# DscLcmConfiguration

This gem helps build configuration scripts for the Windows PowerShell Desired State Configuration Local Configuration Manager.

It currently supports the initial release of WMF 4, WMF 4 with the unversioned update, and WMF 5.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dsc_lcm_configuration'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dsc_lcm_configuration

## Usage

```ruby
require 'dsc_lcm_configuration'

# This will create an object that can generate a WMF 4 (without the update)
# compatible LCM configuration.
DscLcmConfiguration::Factory.create()
```

`#create` takes two parameters, the first is the version of the LCM.

* 'wmf4' will create a WMF4 RTM compatible configuration
* 'wmf4_with_update' supports the additional LCM settings introduced in the unversioned update to WMF 4
* 'wmf5' supports WMF 5.0 RTM (not the preview builds)

The second parameter is an array of options.  Which options are supported depends on the version of WMF you are targeting.


## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smurawski/dsc_lcm_configuration.

