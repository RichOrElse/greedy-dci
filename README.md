# Greedy::DCI

[![Gem Version](https://badge.fury.io/rb/greedy-dci.svg)](https://badge.fury.io/rb/greedy-dci)

A Toolkit for rapid prototyping of interactors, use cases and service objects, using the DCI paradigm.

> **WARNING!**
> This implementation will blow the method cache, slow down performance and consume excessive resources (*hence the name*), therefore **production usage is seriously discouraged**. Instead, use of a [Wrapper Based alternative](https://github.com/RichOrElse/wrapper-based) is highly recommended.

## What is DCI?

DCI (Data, context and interaction) is a new Role-Based Paradigm for specifying collaborating objects.
Trygve Reenskaug is the originator best known for formulating the MVC (model–view–controller) pattern.

You can read more about DCI at the following links:

* http://dci.github.io/
* http://dci-in-ruby.info/
* http://fulloo.info/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'greedy-dci'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install greedy-dci

## Usage

```ruby
require 'greedy/dci'

# Data

Purchase = Struct.new(:toy, :buyer)
Deliver = Struct.new(:toy, :recipient, :purchase, :status)

# Behaviors

module Buyer
  def buy(toy)
    Purchase.new toy, self
  end
end

module Recipient
  def receive(purchased)
    Deliver.new purchased.toy, self, purchased, :pending
  end
end

# Contexts

PurchaseToy = Greedy.context { |purchaser|
                                using purchaser.as Buyer
                                using purchaser.as Recipient

                                def call(toy)
                                  purchased = purchaser.buy toy
                                  purchaser.receive purchased
                                end
                              }


GiftToy = Greedy.context { |gifter, giftee|
                            using gifter.as Buyer
                            using giftee.as Recipient

                            def call(toy)
                              gift = gifter.buy toy
                              giftee.receive gift
                            end
                          }

# Interactions

finn_purchase_toy = PurchaseToy[purchaser: 'Finn']
finn_purchase_toy.call 'Rusty sword'
finn_purchase_toy.('Armor of Zeldron')
finn_purchase_toy['The Enchiridion']

['Card Wars', 'Ice Ninja Manual', 'Bacon'].each &GiftToy[gifter: 'Jake', giftee: 'Finn']
```

[View more examples](https://github.com/RichOrElse/greedy-dci/tree/master/examples)

## Context methods

### to_proc

Returns call method as a Proc.

```ruby
['Card Wars', 'Ice Ninja Manual', 'Bacon'].map &GiftToy[gifter: 'Jake', giftee: 'Finn']
```

### context[params,...]

Square brackets are alias for call method.

```ruby
TransferMoney[from: source_account, to: destination_account][amount: 100]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RichOrElse/greedy-dci.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

