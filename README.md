# Renderror

Renderror makes it easy to render JSON:Api compliant error messages from your Rails API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'renderror'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install renderror

Then run the installer:

    $ rails g renderror:install

## Basic Usage

Out of the box Renderror allows you to call `render_errors(errors)` from anywhere in your controllers to render a simple json array of those errors. The only requirement is that the errors respond to `.to_json` and to `.status`. Out of the box they will not be converted to JSON:Api Syntax, to do that see the **Custom Errors** section of this Readme.

## Auto Rescue

Renderror has the ability to automatically rescue from common exceptions and render the correct error messages. It just requires a small amount of setup. 

```ruby 
class ApiController < ApplicationController
  renderror_auto_rescue :bad_request, :not_found, :invalid_document,
                        :cancan
end
```

We recommend including this in a base controller of your API to ensure that these exceptions are rescued everywhere. You can turn on an off as many of the auto rescue flags as you wish. More details on each of these options can be found below.

#### `:bad_request`

Including this will automatically rescue from `ActionController::BadRequest` and give the following response. 

```json
{
  "errors": [
    {
      "title": "Bad Request",
      "status": "400",
      "detail": "Bad Request"
    }
  ]
}
```

#### `:not_found`

Including this will automatically rescue from `ActiveRecord::RecordNotFound` and render a response formatted similiar to:

```json
{
  "errors": [
    {
      "title": "Not Found",
      "status": "404",
      "detail": "Could not find User with id 1"
    }
  ]
}
```

#### `:invalid_document`

Ties into [Active Model Serializers](https://github.com/rails-api/active_model_serializers) `JsonApi::Deserialization::InvalidDocument` method, which is used to deserialize request params. If the request params are determined to be invalid, Renderror will rescue and respond with a `Bad Request` status and error.

#### `:cancan`

Ties into the [CanCanCan](https://github.com/CanCanCommunity/cancancan) gem to allow your app to auto rescue from `CanCan::AccessDenied` and respond with a `Forbidden` error.

```json
{
  "errors": [
    {
      "title": "Forbidden",
      "status": "403",
      "detail": "You are not authorized to access this resource"
    }
  ]
}
```

## Additional Methods

There is also a number of situations where Renderror can be triggered manually, such as when wanting to render model errors or invalid authentication errors. You can do this using the following methods.

#### `render_unprocessable(resource)`

This can be called inside a controller to render validation errors

```ruby
def create
  user = User.new(user_params)

  if user.save
    respond_with user
  else
    render_unprocessable user 
  end
end  
```

This would return the following JSON if the user failed validation

```json 
{
  "errors": [
    {
      "status": "422",
      "title": "Unprocessable Entity",
      "detail": "Name can't be blank",
      "source": {
        "pointer": "/data/attributes/name"  
      }
    },
    {
      "status": "422",
      "title": "Unprocessable Entity",
      "detail": "Email can't be blank",
      "source": {
        "pointer": "/data/attributes/email"  
      }
    }
  ]
}
```

#### `render_invalid_authentication`

This addon hooks into Devise's error handling and helper methods to render unauthorized errors compliant with the JSON:Api format.

```ruby 
def create
  use_case = ::Sessions::CreateSession.perform(session_attributes)

  if use_case.success?
    respond_with use_case.session
  else
    raise_invalid_authentication User
  end
end
```


#### `render_reform_unprocessable(form)`

Renderror also works with the [Reform](https://github.com/trailblazer/reform) gem from Trailblaizer.
Similar to `render_unprocessable`, however takes an instance of a `Reform::Form` and renders the errors from there:

```ruby
def create
  form = UserForm.new(User.new)

  if form.validate(form_attributes) && form.save
    respond_with form.model
  else
    render_reform_unprocessable form
  end
end
```

## Customising Responses

After running the `install` command you can simply open the `renderror.en.yml` file to change any of the default titles and details for each message.

## Custom Errors

If you with to make your own errors, you can do so by simply inheriting from the `Renderror::BaseError` class.

```ruby
class ImATeapot < BaseError

  def status
    '418'
  end

  private

  def default_title
    "I'm a teapot"
  end

  def default_detail
    "Short and Stout"
  end
end
```

From there you can either choose to `raise` the error, or `render` it. Both these methods can take `title:`, `detail:`, and `pointer:` keyword arguments if you wish to override the defaults

#### Example Raise
```ruby
raise ImATeapot, title: "I'm a little teapot", detail: "Tip me over, pour me out"
```

#### Example Render

```ruby
render_errors(ImATeapot.new)
```

```json
{
  "errors": [
    {
      "title": "I'm a teapot",
      "status": "418",
      "detail": "Tip me over, pour me out"
    }
  ]
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Papercloud/renderror. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Renderror project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Papercloud/renderror/blob/master/CODE_OF_CONDUCT.md).
