# Ruby Pair Programming Interview

- [Ruby Pair Programming Interview](#ruby-pair-programming-interview)
  - [Getting Started](#getting-started)
  - [Considerations](#considerations)
    - [Auth](#auth)
    - [Transactions](#transactions)
  - [Test Scenarios](#tests-scenarios)
  - [API](#api)
  - [Conclusion](#conclusion)

## Getting Started

First, prepare your environment:

 - Start postgresql service locally
 - Create the database user `paywith_api` with password `paywith` or change the values on [database.yml](https://github.com/egoforia/ruby-pair-programming-interview/blob/development/config/database.yml)

Setup rails and database:

 - `bundle install`
 - `rake db:create`
 - `rake db:migrate`

And we are good to start rails server:

 - `rails s`

## Considerations

### Auth

I didn't bother to implement authentication for this challenge as Vlad advised me

As we don't have authentication we can't know who the user is so you'll see `user_id` as a parameter of the requests for accounts, transactions and credit cards.

Yeah, this is a dirty solution and would be a very bad decision to deploy it to production *(please, don't do this!)* but it works for this challenge

I'm open to discuss authentication if you want

### Transactions

I've write up some pseudocode to demonstrate how transactions would be processed and have considerated that it would be synchronous for this challenge. The following code can be found on [transaction model](https://github.com/egoforia/ruby-pair-programming-interview/blob/development/app/models/transaction.rb).

The logic is encapsulated on a database transaction to make atomic changes on database to avoid any error that could happen on the process and to assure countability

And it can be easily refactored if we want to transactions be asynchronous on the future

#### Transfer balance

```ruby
def transfer_balance
  self.transaction do
    begin
      self.from_account.transfer(self.amount, self.to_account)
      self.success!
    rescue
      self.error!
    end
  end
end
```

#### Process credit card

```ruby
def process_credit_card
  self.transaction do
    self.to_account.deposit(self.amount)
    self.success!
  end
end
```

## API

API is documented with Swagger using the gem [rswag](https://github.com/rswag/rswag)

To access the API documentation, start `rails server` and go to the following link: http://localhost:3000/api-docs

## Test scenarios

Tests has been written using [rspec-rails](https://github.com/rspec/rspec-rails). To run specs use the command `rspec`.

I've used the [rspec DSL of rswag](https://github.com/rswag/rswag#the-rspec-dsl) to write request specs and to guarantee that Swagger documentation and the tests are in sync

## Conclusion

I really appreciate the opportunity to make this challenge and I'm looking forward to join Paywith team
