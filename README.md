# BrZipCode

This gem helps you to find an address based on a brazilian zip code. For that, 3 webservices are used:

* [Postmon](http://postmon.com.br/ "Postmon")
* [Via CEP](http://viacep.com.br/ "Via CEP")
* [Correio Control](http://cep.correiocontrol.com.br "Correio Control")
* [República Virtual](http://republicavirtual.com.br/cep/ "República Virtual")
* [CEP Livre](http://ceplivre.com.br/ "CEP Livre")

The webservices are searched in order. If one is not available, the next is tested until one is available or none.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'br_zip_code'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install br_zip_code

## Usage

```ruby
BrZipCode.get("22451090")   #=> {:street=>"Rua Duque Estrada", :state=>"RJ", :city=>"Rio de Janeiro", :district=>"Gávea"}
BrZipCode.get("22.451-090") #=> {:street=>"Rua Duque Estrada", :state=>"RJ", :city=>"Rio de Janeiro", :district=>"Gávea"}
BrZipCode.get("22451-090")  #=> {:street=>"Rua Duque Estrada", :state=>"RJ", :city=>"Rio de Janeiro", :district=>"Gávea"}

BrZipCode.get("12345678")   #=> nil
BrZipCode.get("1234567")    #=> nil
```

### Basic JSON API
The route /zip_code/:zip_code.json (/zip_code/22441090.json, for example) is accessible.
Pass the zip_code and get the response, so you can create AJAX function to autocomplete addresses.

So, http://localhost:3000/zip_code/22441090.json will return:
```json
{
  "success":true,
  "zip_info":
  {
    "street_type":"Rua",
    "street":"Rua General Venâncio Flores",
    "state":"RJ",
    "city":"Rio de Janeiro",
    "neighborhood":"Leblon"
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/br_zip_code/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
