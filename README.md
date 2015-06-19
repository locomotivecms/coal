# Coal

[![Code Climate](https://codeclimate.com/github/locomotivecms/coal/badges/gpa.svg)](https://codeclimate.com/github/locomotivecms/coal) [![Dependency Status](https://gemnasium.com/locomotivecms/coal.svg)](https://gemnasium.com/locomotivecms/coal) [![Build Status](https://travis-ci.org/locomotivecms/coal.svg?branch=master)](https://travis-ci.org/locomotivecms/coal) [![Coverage Status](https://coveralls.io/repos/locomotivecms/coal/badge.svg?branch=master)](https://coveralls.io/r/locomotivecms/coal?branch=master)

The Ruby API Client for LocomotiveCMS V3 (WIP).

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Authentication](#authentication)
  - [Resources](#resources)
      - [MyAccount](#my-account)
      - [Sites](#sites)
      - [Pages](#pages)
      - [Content Types](#content-types)
      - [Content Entries](#content-entries)
      - [Snippets](#snippets)
      - [Theme Assets](#theme-assets)
      - [Content Assets](#content-assets)
- [What is missing](#todo)
- [Contributing](#contributing)
- [How to write specs](#how-to-write-specs)
- [Credits](#credits)
- [License](#license)

## Installation

    gem install locomotivecms_coal --pre

## Usage

First, load the gem:

    require 'locomotive/coal'

### Authentication

    client = Locomotive::Coal::Client.new('http://www.myengine.dev', { email: <EMAIL>, api_key: <API KEY> })

You can get the version of the remote running Engine by calling the following method:

    client.engine_version

*Note:* Coal supports Engine version **~> 3.0.x**. However, if you do need to request an Engine running a 2.5.x version, use following code instead:

    client = Locomotive::Coal::ClientV2.new('http://www.myengine.dev', { email: <EMAIL>, api_key: <API KEY> })

We do not garantee that all the API resources will work with the V2 Client but PRs are accepted of course.

### Resources

#### MyAccount

**Get the name of the logged in account**

    my_account = client.my_account.get
    puts my_account.name + " / " + my_account.email

**If not logged in, then it's possible to create your account**

    client = Locomotive::Coal::Client.new('http://www.myengine.dev')
    client.my_account.create(name: 'John Doe', email: 'john@doe.net', password: 'easyone', password_confirmation: 'easyone')

**Update my account**

    client.my_account.update(name: 'Jane Doe')

#### Sites

**Get all my sites**

    my_sites = client.sites.all
    puts "I've got #{my_sites.size}"

**Create a new site**

    my_site = client.sites.create(name: 'Acme', subdomain: 'acme', locales: ['en'], timezone: 'UTC')

**Destroy a site**

    my_site = client.sites.destroy(my_site._id)

#### Pages

*Note:* We first need to log in to the site. It can be done by calling the scope_by method of the client instance.

    site = client.sites.by_handle('acme')
    site_client = client.scope_by(site)

For the **V2 Client**, that would be this instead:

    site = client.sites.by_subdomain('acme')

**Get the list of pages in English**

    pages = site_client.pages.all(:en)

**Get only the id/fullpath attributes**

    pages = site_client.pages.fullpaths(:en)

It is required when we need the id of an existing page according to its fullpath.

**Create a page**

    page = site_client.pages.create(title: 'About us', slug: 'about-us', parent: 'index', template: 'Locomotive rocks!')

**Update a page in French**

    site_client.pages.update(page._id, { template: 'Locomotive est trop fort!!!' }, :fr)

**Destroy a page**

    site_client.pages.destroy(page._id)

#### Content Types

**Get a content type by its slug**

*Note:* We first need to log in to the site the content type belongs to. It can be done by calling the scope_by method of the client instance.

    site = client.sites.by_subdomain('acme')
    site_client = client.scope_by(site)

    content_type = site_client.contents.projects

#### Content Entries

**Get the first 10 entries filtered by a property (published)**

    articles = site_client.contents.articles.all({ published: true })

**Loop over all the content entries**

    page = 1
    while page do
      articles = site_client.contents.articles.all({ published: true }, page: page)
      articles.each { |article| puts article.title }
      page = articles._next_page
    end

*Note:* You can also use the following syntax

    content_type = site_client.contents.projects
    articles = site_client.content_entries(content_type).all

**Create a content entry**

    first_article = site_client.contents.articles.create(title: 'Hello world')

**Update a content entry**

    article = site_client.contents.articles.all.first
    site_client.contents.articles.update(article._id, { title: 'Hello world'})

**Update a content entry in a different locale**

    # create the article in the default locale
    article = site_client.contents.articles.create(title: 'Hello world')

    # then update the title in another locale
    site_client.contents.articles.update(article._id, { title: 'Bonjour le monde'}, :fr)

**Destroy a content entry**

    site_client.contents.articles.destroy(article._id)

#### Snippets

**Get the list of snippets**

    snippets = site_client.snippets.all

**Create a snippet**

    snippet = site_client.snippets.create(name: 'Header', slug: 'header', template: 'Locomotive rocks!')

    # create a snippet in different locales

    snippet = site_client.snippets.create(name: 'Header', slug: 'header', template: { en: 'Locomotive rocks!', fr: 'Locomotive déchire !' })

**Update a snippet**

    site_client.snippets.update('header', template: 'Locomotive rocks!!!')

**Destroy a snippet**

    site_client.snippets.destroy('header')

#### Theme assets

**Get the list of theme assets**

    assets = site_client.theme_assets.all

**Create a theme asset**

    asset = site_client.theme_assets.create(source: Locomotive::Coal::UploadIO.new('<local path of my image>'), folder: 'images/header')

**Update a theme asset**

    site_client.theme_assets.update(asset._id, source: Locomotive::Coal::UploadIO.new('<local path of my new image>'))

**Destroy a theme asset**

    site_client.theme_assets.destroy(asset._id)

#### Content assets

**Get the list of content assets**

    assets = site_client.content_assets.all

**Create a content asset**

    asset = site_client.content_assets.create(source: Locomotive::Coal::UploadIO.new('<local path of my image>'))

**Update a content asset**

    site_client.content_assets.update(asset._id, source: Locomotive::Coal::UploadIO.new('<local path of my new image>'))

**Destroy a content asset**

    site_client.content_assets.destroy(asset._id)

#### Memberships
**Get the list of memberships**

    memberships = site_client.memberships.all

**Create a membership**

    membership = site_client.memberships.create(role: 'author', account_email: 'nic@example.com')

**Update a membership**

    site_client.memberships.update(account_email: 'nic@example.com', role: 'admin')

**Destroy a membership**

    site_client.memberships.destroy(membership._id)

## What is missing?

We only implemented a few resources (my_account, sites, content types, memberships and content entries) and for some of them, not all the actions have been implemented.

Check the issues section of the repository to see what is missing.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/locomotivecms/coal )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## How to write specs

**Engine configuration:**

1. You need to run the last version (master branch) of the [Locomotive engine](https://github.com/locomotivecms/engine).
2. Pick a different database name to run your Coal specs against.
3. Run ````bundle exec rake development:bootstrap````
4. Run the Locomotive server ````bundle exec rails server````

**System configuration:**

- edit your /etc/hosts file (*NIX systems) and add 2 lines
      127.0.0.0     www.example.com acme.example.com

## Credits

[Christian](https://github.com/cblavier), [Greg](https://github.com/gregKawet) and [Ben](https://github.com/stiiig) from the Cogip/Insert International LTD who brainstormed with me (a very long time) to find this awesome name.

## License

Copyright (c) 2015 NoCoffee. MIT Licensed, see LICENSE for details.
