# EventbriteContacts

Interact with the Eventbrite API to get, create and delete Contacts and Lists

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eventbrite_contacts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eventbrite_contacts

## Usage

The Eventbrie API authenticates a user using Oauth2 so an Oauth token must be
obtained. An Oauth stragey, such as the gem **omniauth-eventbrite** can be used to return
the Eventbrite Oauth token

Instantiate a client:

```ruby
client = ::EventbriteContacts::Client.new("my_eventbrite_token", "my_eventbrite_user_id")
```

Call the following methods on the client. options={} is an optional parameter in methods that
  return a paginated response. If no argument is given the default page returned will be 1.
  Supply the page in the following format:

```ruby
{page: 3}
```

To get a users contact lists

```ruby
client.get_lists(options={})
```

To get a specific list

```ruby
client.get_list("my_list_id")
```

To add a new list

```ruby
client.add_list("my_new_list_name")
```

To delete a list

```ruby
client.delete_list("my_list_id")
```

To return all the contacts in a list. The response is an array of hashes

```ruby
client.get_all_contacts("my_list_id")
```

To get a paginated response of contacts in a list

```ruby
client.get_contacts("my_list_id", options={})
```

To add a contact to a list

```ruby
client.add_contact("my_list_id", contact)
```

Where contact is a hash with the following attributes:

```ruby
{
  email: "eric@cantona.com",
  first_name: "Eric",
  last_name: "Cantona"
}
```

To delete a contact

```ruby
client.delete_contact("my_list_id", "eric@cantona.com")
```

There is currently no option to update with the Eventbrite API. Their docs recommend to first
delete and then add a list or contact in order to update

For reference: https://www.eventbrite.com/developer/v3/quickstart/

## Contributing

1. Fork it ( https://github.com/cjlofts/eventbrite_contacts/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
