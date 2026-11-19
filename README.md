# StateTransitions
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "state_transitions"
```

And then execute:
```bash
bundle
```

Install migrations:
```bash
rails state_transitions:install:migrations
```

Run migrations:
```bash
rails db:migrate
```

Include the module in a model:
```ruby
class Project < ApplicationRecord
  include StateTransitions
end
```

Track current user on state transitions from requests:
```ruby
class ApplicationController
  around_action :set_state_transitions_current

private

  def set_state_transitions_current
    StateTransitions::Current.user = current_user
    yield
  ensure
    StateTransitions::Current.user = nil
  end
end
```

## Contributing
Contribution directions go here.

## Build path filtering

This repository has one RSpec build. `peak_flow.yml` keeps that build broad for
source, tests, configuration, lockfiles, and repository metadata, while
documentation-only changes (`*.md` and `docs/**`) are excluded. Because the
graph has one lane, per-lane savings are not separately measurable, but
deliveries are filtered; a documentation-only change is the terminal
skipped-path probe.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
