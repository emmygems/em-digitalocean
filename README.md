# Digitalocean API



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'em-digitalocean'
```

Then `require 'digitalocean'`

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install em-digitalocean

## Usage

https://cloud.digitalocean.com/settings/applications

```ruby
api = Digitalocean::API.new(token: 'TOKEN')
```

## API

```ruby
api = Digitalocean::API.new(token: 'TOKEN')
droplets = api.droplets.all.sync
# {:droplets=>[{:id=>0, :name=>"droplet", :memory=>512, :vcpus=>1, :disk=>20, :locked=>false ...}]}
droplet = api.droplets.show(droplets[:droplets].first[:id]).sync
# {:droplet=>{:id=>0, :name=>"droplet", :memory=>512, :vcpus=>1, :disk=>20, :locked=>false, :status=>"active", ...}}
```

## Droplet Actions

* `api.droplets.disable_backups(id).sync`
* `api.droplets.reboot(id).sync`
* `api.droplets.power_cycle(id).sync`
* `api.droplets.shutdown(id).sync`
* `api.droplets.power_off(id).sync`
* `api.droplets.power_on(id).sync`
* `api.droplets.restore(id, image).sync`
* `api.droplets.password_reset(id).sync`
* `api.droplets.resize(id, disk, size).sync`
* `api.droplets.rebuild(id, image).sync`
* `api.droplets.rename(id, name).sync`
* `api.droplets.change_kernel(id, kernel).sync`
* `api.droplets.enable_ipv6(id, kernel).sync`
* `api.droplets.enable_private_networking(id, kernel).sync`
* `api.droplets.snapshot(id).sync`
* `api.droplets.upgrade(id).sync`
* `api.droplets.retrive_action(id, action).sync`

## Raise

config/initializers/digitalocean.rb
```ruby
require 'digitalocean'
Digitalocean.api = Digitalocean::API.new(token: 'TOKEN')
```

Request:

```ruby
actions = Digitalocean.api.actions.sync
```
