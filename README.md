# Greedy::DCI

Toolkit for rapid prototyping of interactors, use cases and service objects. Using DCI (Data, context and interaction) 
the new programming paradigm from the inventor of the MVC pattern. This implimentation consumes excessive resources (hence the name) 
and is not recommended for production.

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
Purchase = Struct.new(:toy, :buyer)
Deliver = Struct.new(:toy, :recipient, :purchase, :status)

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

finn_purchase_toy = PurchaseToy[purchaser: 'Finn']
finn_purchase_toy.call 'Rusty sword'
finn_purchase_toy.('Armor of Zeldron')
finn_purchase_toy['The Enchiridion']

['Card Wars', 'Ice Ninja Manual', 'Bacon'].each &GiftToy[gifter: 'Jake', giftee: 'Finn']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/richorelse/greedy-dci.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

