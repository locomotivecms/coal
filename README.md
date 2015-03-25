# Coal

The Ruby API Client for LocomotiveCMS.

## Installation [WIP]

    gem install locomotivecms_coal --pre

## Usage

    client = Locomotive::Coal::Client.new('http://www.myengine.dev/locomotive/api', { email: <EMAIL>, api_key: <API KEY> })

    # Get the name of the logged in account
    client.my_account.name

## TODO

see the list in the issues section.

## Credits ##

[Christian](https://github.com/cblavier), [Greg](https://github.com/gregKawet) and [Ben](https://github.com/stiiig) from the Cogip/Insert International LTD who brainstormed with me (a very long time) to find this awesome name.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/locomotivecms/coal )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2015 NoCoffee. MIT Licensed, see LICENSE for details.
