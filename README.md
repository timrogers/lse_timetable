# lse_timetable

Find a user's timetable at the London School of Economics using their username and password.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lse_timetable', '~> 0.0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lse_timetable

## Usage

You'll need to set up the client with the API username and password - this can be found by intercepting requests from [LSE Mobile app](http://www.lse.ac.uk/intranet/LSEServices/IMT/guides/lseMobile.aspx) (see my blog [here](http://timrogers.uk/2014/07/12/discovering-private-apis-with-charles-app/) for details):

```ruby
LseTimetable.api_username = "application_sec_user"
LseTimetable.api_password = "insert-password-here"
```

If an API username and password are not specified, method calls will raise a `LseTimetable::GenericError` exception.

Now, you can fetch the timetable with a LSE user's username and password:

```ruby
results = LseTimetable.fetch(username: "ROGERST", password: "foo")
```

The `.fetch` method also accepts `from` and `to` options with a `DateTime` to specify the period you want to grab the timetable for. By default, we'll load data from today to next Friday.

If a user's authentication details are incorrect, `.fetch` will raise a `LseTimetable::AuthenticationError` exception. Other errors, including an incorrect API username and password, will raise an `LseTimetable::GenericError`, the message of which will be the response body.

`.fetch` returns an array of `LseTimetable::TimetableItem` objects, each of which have the following attributes:

* course_title,
* course_code,
* type *('Lecture' or 'Class')*
* starts_at *(as `DateTime`)*
* finishes_at *(as `DateTime`)*
* location

## Contributing

1. Fork it ( https://github.com/timrogers/lse_timetable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2014 Tim Rogers. Open source subject to the MIT License - see LICENSE.txt.