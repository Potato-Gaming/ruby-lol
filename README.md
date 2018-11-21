ruby-lol
 =====

[![Gem Version](https://badge.fury.io/rb/ruby-lol.png)](http://badge.fury.io/rb/ruby-lol) [![Coverage Status](https://coveralls.io/repos/mikamai/ruby-lol/badge.png)](https://coveralls.io/r/mikamai/ruby-lol) [![Build Status](https://travis-ci.org/mikamai/ruby-lol.png?branch=master)](https://travis-ci.org/mikamai/ruby-lol) [![Dependency Status](https://gemnasium.com/mikamai/ruby-lol.png)](https://gemnasium.com/mikamai/ruby-lol) [![Inline docs](http://inch-ci.org/github/mikamai/ruby-lol.png?branch=master)](http://inch-ci.org/github/mikamai/ruby-lol)


ruby-lol is a wrapper to the [Riot Games API](https://developer.riotgames.com).

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-lol'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-lol

# Usage

[ WIP ]

### Initialize the client
```ruby
require 'lol'

client = Lol::Client.new "my_api_key", region: "euw"
# => <Lol::Client:0x000000020c0b28 @api_key="my_api_key", @region="euw", @cached=false>

# You can cache requests using Redis now
# ttl defaults to 900
client = Lol::Client.new "my_api_key", region: "euw", redis: "redis://localhost:6379", ttl: 900

# You can specify your rate limits so that the library will throttle requests to avoid errors
client = Lol::Client.new "new_api_key", region: "euw", rate_limit_requests: 1, rate_limit_seconds: 10

# With the use_stub_api parameter you can activate to use the tournament-stub api. By default the tournament api will be used
client = Lol::Client.new "new_api_key", region: "euw", use_stub_api: true
```

## RIOT API Endpoints

#### [CHAMPION-MASTERY-V3](https://developer.riotgames.com/api-methods/#champion-mastery-v3)
```ruby
client.champion_mastery
# => Lol::ChampionMasteryRequest
```
#### [CHAMPION-V3](https://developer.riotgames.com/api-methods/#champion-v3)
```ruby
client.champion
# => Lol::ChampionRequest
```

#### [LEAGUE-V3](https://developer.riotgames.com/api-methods/#league-v3)
```ruby
client.league
# => Lol::LeagueRequest
```

#### [LOL-STATUS-V3](https://developer.riotgames.com/api-methods/#lol-status-v3)
```ruby
client.lol_status
# => Lol::LolStatusRequest
```

#### [MATCH-V3](https://developer.riotgames.com/api-methods/#match-v3)
```ruby
client.match
# => Lol::MatchRequest
```
#### [SPECTATOR-V3](https://developer.riotgames.com/api-methods/#spectator-v3)
```ruby
client.spectator
# => Lol::SpectatorRequest
```

#### [SUMMONER-V3](https://developer.riotgames.com/api-methods/#summoner-v3)
```ruby
client.summoner
# => Lol::SummonerRequest

# Get Summoner by Name
client.summoner.find_by_name("Faker")

# Get Summoner by Id
client.summoner.find("123456789")

# Get Summoner by AccountId
client.summoner.find_by_account_id("123456789")
```

#### [TOURNAMENT-STUB-V3](https://developer.riotgames.com/api-methods/#tournament-stub-v3)

Used if you activate ``` use_stub_api: true ``` while intializing the client. Usage like Tournament-API.

#### [TOURNAMENT-V3](https://developer.riotgames.com/api-methods/#tournament-v3)
```ruby
client.tournament
# => Lol::TournamentRequest
```


## Making Static Requests
The Riot API has a [section](http://developer.riotgames.com/api/methods#!/378) carved out for static-data. These requests don't count against your rate limit. The mechanism for using them is similar to the standard requests above.

Each static endpoint has two possible requests: `get` and `get(id)`. `get` returns an array of OpenStructs representing the data from Riot's API, and `get(id)` returns an OpenStruct with a single record. Here are some examples:

```ruby
client.static
# => Lol::StaticRequest
**NOTE**: StaticRequest is not meant to be used directly, but can be!

client.static.champion
# => Lol::StaticRequest (for endpoint /static-data/champion)

client.static.champion.get
# => [OpenStruct] (with keys from http://developer.riotgames.com/api/methods#!/378/1349)

client.static.champion.get(id)
# => OpenStruct (with keys from http://developer.riotgames.com/api/methods#!/378/1349)
```

You can also pass query parameters as listed in the Riot API documentation. For example:

```ruby

# returns all attributes
client.static.champion.get(champData: 'all')

# returns only lore information
client.static.champion.get(champData: 'lore')
```

**NOTE**: The realm endpoint is not implemented. Let us know if you need it, but it seemed somewhat unnecessary.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog
 - 0.9.14 Fixed a caching bug
 - 0.9.13 Updated to latest API versions
 - 0.9.12 Fixed a caching bug
 - 0.9.11 Added caching support via REDIS
 - 0.9.7 Updated LeagueRequest to API v2.3
 - 0.9.6 Updated SummonerRequest and GameRequest to API v1.3
 - 0.9.5 Fixed documentation
 - 0.9.4 Completed support for updated API


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/mikamai/ruby-lol/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
