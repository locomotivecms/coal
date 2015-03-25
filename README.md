# Coal

[![Code Climate](https://codeclimate.com/github/locomotivecms/coal/badges/gpa.svg)](https://codeclimate.com/github/locomotivecms/coal) [![Dependency Status](https://gemnasium.com/locomotivecms/coal.svg)](https://gemnasium.com/locomotivecms/coal) [![Build Status](https://travis-ci.org/locomotivecms/coal.svg?branch=master)](https://travis-ci.org/locomotivecms/coal) [![Coverage Status](https://coveralls.io/repos/locomotivecms/coal/badge.svg?branch=master)](https://coveralls.io/r/locomotivecms/coal?branch=master)

The Ruby API Client for LocomotiveCMS.

## Installation [WIP]

    gem install locomotivecms_coal --pre

## Usage

    client = Locomotive::Coal::Client.new('http://www.myengine.dev/locomotive/api', { email: <EMAIL>, api_key: <API KEY> })

    # Get the name of the logged in account
    my_account = client.my_account.get
    puts my_account.name + " / " + my_account.email

    # Get all my sites
    my_sites = client.sites.all
    puts "I've got #{my_sites.size}"

    # Get all the articles (if there is a "Articles" content type)



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
