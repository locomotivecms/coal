# Coal

[![Code Climate](https://codeclimate.com/github/locomotivecms/coal/badges/gpa.svg)](https://codeclimate.com/github/locomotivecms/coal) [![Dependency Status](https://gemnasium.com/locomotivecms/coal.svg)](https://gemnasium.com/locomotivecms/coal) [![Build Status](https://travis-ci.org/locomotivecms/coal.svg?branch=master)](https://travis-ci.org/locomotivecms/coal) [![Coverage Status](https://coveralls.io/repos/locomotivecms/coal/badge.svg?branch=master)](https://coveralls.io/r/locomotivecms/coal?branch=master)

The Ruby API Client for LocomotiveCMS.

## Installation [WIP]

    gem install locomotivecms_coal --pre

## Usage

### Authentication

    client = Locomotive::Coal::Client.new('http://www.myengine.dev/locomotive/api', { email: <EMAIL>, api_key: <API KEY> })

### Resources

#### MyAccount

**Get the name of the logged in account**

    my_account = client.my_account.get
    puts my_account.name + " / " + my_account.email

#### Sites

**Get all my sites**

    my_sites = client.sites.all
    puts "I've got #{my_sites.size}"

**Create a new site**

    my_site = client.sites.create(name: 'Acme', subdomain: 'acme', locales: ['en'], timezone: 'UTC')

**Destroy a site**

    my_site = client.sites.destroy(my_site._id)

#### Content Types

**Get a content type by its slug**

*Note:* We first need to log in to the site the content type belongs to. It can be done by calling the scope_by method of the client instance.

    site = client.sites.by_subdomain('acme')
    site_client = client.scope_by(site)

    content_type = site_client.contents.projects

#### Content Entries

**Get all the first 10 entries filtered by a property (published)**

    articles = site_client.contents.articles.all({ published: true })

**Loop over all the content entries**

    page = 1
    while page do
      articles = site_client.contents.articles.all({ published: true }, page: page)
      articles.each { |article| puts article.title }
      page = articles._next_page
    end

**Update a content entry**

    article = site_client.contents.articles.all.first
    site_client.contents.articles.update(article._id, { title: 'Hello world'})

## TODO

We only implemented a few resources (my_account, sites, content types and content entries) and for some of them, not all the actions have been implemented.

Check the issues section of the repository to see what is missing.

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
