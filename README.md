ruby-lol | *Riot-API wrapper for Ruby and RoR*
 =====
ruby-lol is a wrapper to the [Riot Games API](https://developer.riotgames.com).
This a Fork of the original [Ruby-LoL Gem](https://github.com/mikamai/ruby-lol) developed by mikamai. This fork is maintained by MateCrate, organizer of the [League of Legends City Masters](https://city-masters.de/) Tournament.

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

# All Champion Masteries
client.champion_mastery.all

# Player's total champion master score
client.champion_mastery.total_score(summoner_id: "12345678")

# Find Champion Mastery - optional param summoner_id
client.champion_mastery.find(champion_id, summoner_id: "123455"
```
#### [CHAMPION-V3](https://developer.riotgames.com/api-methods/#champion-v3)
```ruby
client.champion
# => Lol::ChampionRequest

# Get all - optional param free_to_play [Boolean] to retrieve only free to play champions
client.champion.all(free_to_play: true)

# Find Champion by id
client.champion.find(champion_id)
```

#### [LEAGUE-V3](https://developer.riotgames.com/api-methods/#league-v3)
```ruby
client.league
# => Lol::LeagueRequest

# Get the challenger league for a given queue
# Default queue: "RANKED_SOLO_5x5"
client.league.find_challenger(queue: "RANKED_SOLO_5x5")

# Get the master league for a given queue
# Default queue: "RANKED_SOLO_5x5"
client.league.find_master(queue: "RANKED_SOLO_5x5")

# Get leagues in all queues for a given summoner ID
client.league.summoner_leagues(summoner_id:)

# Get league positions in all queues for a given summoner ID
client.league.summoner_positions(summoner_id:)
```

#### [LOL-STATUS-V3](https://developer.riotgames.com/api-methods/#lol-status-v3)
```ruby
client.lol_status
# => Lol::LolStatusRequest

# Get League of Legends status for the given shard
client.lol_status.shard_data
```

#### [MATCH-V3](https://developer.riotgames.com/api-methods/#match-v3)
```ruby
client.match
# => Lol::MatchRequest

# Get match by match ID
# options [Integer] forAccountId Optional used to identify the participant to be unobfuscated
# options [Integer] forPlatformId Optional used to identify the participant to be unobfuscated (for when user have changed regions)
client.match.find(options={}, match_id:)

# Get match timeline by match ID
client.match.find_timeline(match_id)

# Get match IDs by tournament code
client.match.ids_by_tournament_code(tournament_code)

# Get match by match ID and tournament code
client.match.find_by_tournament(match_id, tournament_code)

# Get matchlist for ranked games played on given account ID and platform ID and filtered using given filter parameters, if any
# options [Array<Integer>] queue Set of queue IDs for which to filtering matchlist.
# options [Integer] beginTime The begin time to use for filtering matchlist specified as epoch milliseconds.
# options [Integer] endTime The end time to use for filtering matchlist specified as epoch milliseconds.
# options [Integer] beginIndex The begin index to use for filtering matchlist.
# options [Integer] endIndex The end index to use for filtering matchlist.
# options [Array<Integer>] season Set of season IDs for which to filtering matchlist.
# options [Array<Integer>] champion Set of champion IDs for which to filtering matchlist.
client.match.all(options={}, account_id:)

# Get matchlist for last 20 matches played on given account ID and platform ID
client.match.recent(account_id:)
```

#### [RUNES-V3](https://developer.riotgames.com/api-methods/#runes-v3)
```ruby
client.runes
# => Lol::RunesRequest

# Get rune pages for a given summoner ID
client.runes.by_summoner_id(summoner_id)
```

#### [SPECTATOR-V3](https://developer.riotgames.com/api-methods/#spectator-v3)
```ruby
client.spectator
# => Lol::SpectatorRequest

# Get current game information for the given summoner ID
client.spectator.current_game(summoner_id:)

# Get list of featured games
client.spectator.featured_games
```

#### [SUMMONER-V3](https://developer.riotgames.com/api-methods/#summoner-v3)
```ruby
client.summoner
# => Lol::SummonerRequest

# Get Summoner by Id
client.summoner.find("123456789")

# Get Summoner by Name
client.summoner.find_by_name("Faker")

# Get Summoner by AccountId
client.summoner.find_by_account_id("123456789")
```

#### [TOURNAMENT-STUB-V3](https://developer.riotgames.com/api-methods/#tournament-stub-v3)

Used if you activate ``` use_stub_api: true ``` while intializing the client. Usage like Tournament-API.

#### [TOURNAMENT-V3](https://developer.riotgames.com/api-methods/#tournament-v3)
```ruby
client.tournament
# => Lol::TournamentRequest

# Creates a tournament provider and returns its ID
client.tournament.create_provider(url:)

# Creates a tournament and returns its ID
client.tournament.create_tournament(provider_id:, name: nil)

# Create a tournament code for the given tournament
client.tournament.create_codes( tournament_id:,
                                count: nil,
                                allowed_participants: nil,
                                map_type: "SUMMONERS_RIFT",
                                metadata: nil, team_size: 5,
                                pick_type: "TOURNAMENT_DRAFT",
                                spectator_type: "ALL" )

# Update the pick type, map, spectator type, or allowed summoners for a code
client.tournament.update_code( tournament_code,
                               allowed_participants: nil,
                               map_type: nil,
                               pick_type: nil,
                               spectator_type: nil )

# Returns the tournament code details
client.tournament.find_code(tournament_code)

# Gets a list of lobby events by tournament code
client.tournament.all_lobby_events(tournament_code:)
```


## Making Static Requests
The Riot API has a [section](https://developer.riotgames.com/static-data.html) carved out for static-data. These requests don't count against your rate limit. The mechanism for using them is similar to the standard requests above.

Each static endpoint has two possible requests: `get` and `get(id)`. `get` returns an array of OpenStructs representing the data from Riot's API, and `get(id)` returns an OpenStruct with a single record.

Here are some examples:

```ruby
client.static
# => Lol::StaticRequest
**NOTE**: StaticRequest is not meant to be used directly, but can be!

client.static.champions
# => Lol::StaticRequest (for endpoint /static-data/champion)

client.static.champions.get(:all)
# => [OpenStruct] (with keys from http://developer.riotgames.com/api/methods#!/378/1349)

client.static.champions.get(id)
# => OpenStruct (with keys from http://developer.riotgames.com/api/methods#!/378/1349)

client.static.versions.get(:all)
client.static.masteries.get(:all)
client.static.summoner_spells.get(:all)
client.static.runes.get(:all)
client.static.items.get(:all)
client.static.reforged_runes.get(:all)
client.static.realms.get(:all)
```

You can also pass query parameters as listed in the Riot API documentation. For example:

```ruby

# returns all attributes
client.static.champions.get(champData: 'all')

# returns only lore information
client.static.champions.get(champData: 'lore')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog
 - 2.0.1 Updated Gems
 - 2.0.0 Updated to RIOT API Version 4
 - 1.3.1 Updated outdated docs
 - 1.3.0 Added feature to use the tournament-stub api
 - 0.9.14 Fixed a caching bug
 - 0.9.13 Updated to latest API version
 - 0.9.12 Fixed a caching bug
 - 0.9.11 Added caching support via REDIS
 - 0.9.7 Updated LeagueRequest to API v2.3
 - 0.9.6 Updated SummonerRequest and GameRequest to API v1.3
 - 0.9.5 Fixed documentation
 - 0.9.4 Completed support for updated API