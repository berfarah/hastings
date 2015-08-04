# Hastings

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hastings'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hastings

## Command Line Interface
An interface to quickly get up and running with hastings

  hastings new [name]
  # creates a hastings app [name] or current directory
  # ---- generates config.yml with commented out options
  # ---- generates scripts/.keep

  hastings generate [script_name]
  # creates a script from the default template

  hastings run [script]
  # default: give list of scripts
  # runs script with name

  hastings test [script]
  # default: give list of scripts
  # runs script in noop mode

## API

### Variable scope
In order to ensure variables work with our various proxies, we have a variable scope
```ruby
Hastings.script do
  var.my_variable = "value"

  var.my_variable
  # => "value"
end
```

### File system
```ruby
# => File.new("path/to/file.ext")
f = file "path/to/file.ext"
f.basename # => "file.ext"
f.older_than? Time.now   # => true|false
f.created_on? Date.today # => true|false
f.copy_to path, overwrite: true
f.move_to path, overwrite: true

dir "path/to/directory"
# => Dir.new("path/to/directory")


```

## Usage example
See [examples](./tree/master/examples)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
