# Strong Parameters
---------------------------------------

This README would demenstrate:

[What is Strong Parameters ?](#question1)

[How does it work ?](#question2)

[Blacklisting VS Whitelisting ?](#question3)

[Why are we using whitelisting ?](#question4)

[What cause the error ?](#question5)

[Reference](#reference)

--------------------------------------

<a name="question1"/>
## What is Strong Parameters ?

![alt text](https://github.com/paulliu87/StrongParams/blob/master/download.png "Strong Parameters")

With this plugin Action Controller parameters are forbidden to be used in Active Model mass assignments until they have been whitelisted.

```ruby

class PeopleController < ActionController::Base
  # This will raise an ActiveModel::ForbiddenAttributesError exception
  # because it's using mass assignment without an explicit permit
  # step.
  def create
    Person.create(params[:person])
  end
 
  # This will pass with flying colors as long as there's a person key
  # in the parameters, otherwise it'll raise a
  # ActionController::ParameterMissing exception, which will get
  # caught by ActionController::Base and turned into a 400 Bad
  # Request error.
  def update
    person = current_account.people.find(params[:id])
    person.update!(person_params)
    redirect_to person
  end
 
  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def person_params
      params.require(:person).permit(:name, :age)
    end
end

```
----------------------------------------------------

<a name="question2"/>
## How does it work ?

On a superficial level, every request wraps its params in `ActionController::Parameters`, which allows you to whitelist specific keys.

<a name="question3"/>
## Blacklisting VS Whitelisting ?

Blacklisting is to `reject` the stuff that we don't want to pass to model.

```ruby

# Blacklisted Request Parameters

class BlacklistingUsersController < ApplicationController
  def update
    params[:user].delete(:admin)
    user = User.find(params[:id])
    user.update_attributes(params[:user])
  end
end

```

Whitelisting is to `accept` the stuff that we want to pass to model.

```ruby

# Whitelisted Request Parameters, as suggested by DHH

class WhitelistingUsersController < ApplicationController
  def update
    user = User.find(params[:id])
    user.update_attributes user_params
  end

  private

  def user_params
    params[:user].slice :first_name, :last_name, :email
  end
end

```

* The code is explicit about the parameters it's sending to the model.

* Updating new, sensitive parameters in your model won't implicitly be allowed by a whitelist.

-------------

<a name="question4"/>
## Why are we using whitelisting ?

`ActiveModel::ForbiddenAttributesError`

![alt text](https://github.com/paulliu87/StrongParams/blob/master/you-shall-not-pass-thumb.png "you-shall-not-pass-thumb")

--------------

<a name="question5"/>
## What cause the error ?

Live Code
 
----------------------------------------

<a name="reference"/>
## Reference

[RailsGuides](http://edgeguides.rubyonrails.org/action_controller_overview.html#strong-parameters)

[Strong Parameters by Example](http://blog.trackets.com/2013/08/17/strong-parameters-by-example.html)

[A Rule of Thumb for Strong Parameters](http://patshaughnessy.net/2014/6/16/a-rule-of-thumb-for-strong-parameters)

[You Should Be Whitelisting Parameters](https://www.happybearsoftware.com/whitelisting)


