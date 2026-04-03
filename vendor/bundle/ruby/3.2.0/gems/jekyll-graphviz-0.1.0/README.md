# Jekyll::Graphviz

A liquid tag to convert with Graphviz for Jekyll.

## Installation

Add this line to your application's Gemfile:

```ruby
group :jekyll_plugins do
  gem 'jekyll-graphviz'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-graphviz

## Usage

~~~~~~~~~~~~~~~~~~~~~~~
---
---

{% graph some graph title %}
a -- b
b -- c
c -- a
{% endgraph %}

{% digraph some digraph title %}
a -> b
b -> c
c -> a
{% enddigraph %}

{% graphviz %}
digraph "some graphviz title" {
  a -> b
  b -> c
  c -> a
}
{% enddigraphviz %}
~~~~~~~~~~~~~~~~~~~~~~~

### Configs and Default Values

~~~~~~~~~~~~~~~~~~~~~~~yaml
# _config.yaml
graphviz:
  options: "-Tsvg" # 'dot' command option
  command: "dot"   # execute this string. specify full path to 'dot' if you need
~~~~~~~~~~~~~~~~~~~~~~~

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jekyll-graphviz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

