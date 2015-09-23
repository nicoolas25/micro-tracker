# Micro-tracker

[![Build Status](https://travis-ci.org/nicoolas25/micro-tracker.svg?branch=development)](https://travis-ci.org/nicoolas25/micro-tracker)
[![Code Climate](https://codeclimate.com/github/nicoolas25/micro-tracker/badges/gpa.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker)
[![Test Coverage](https://codeclimate.com/github/nicoolas25/micro-tracker/badges/coverage.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker)
[![Gem Version](https://badge.fury.io/rb/utracker.svg)](http://badge.fury.io/rb/utracker)

Modern web application are more and more designed with micro-services.
Those services exchange messages in order to communicate with each other.
Eventually your architecture ends with a graph of services that could be
quite complex. Micro-tracker is all about tracking this micro-service's
interactions in order to know which service received which message, when
and from which other service. It will help you monitor your architecture
and debug faster.

## Use case

Imagine you have three services Alice, Bob and Carl. Each one is sending
messages to the two others. As good developer, you want to know exactly
which message has been sent and received.

Micro-tracker helps you with that. It provides a very simple wrapper for
your messages:

``` ruby
content = {'command' => 'list', 'target' => 'posts'}
message = Utracker::Message.pack(content)
```

Once you've packed your message, the content is accessible:

``` ruby
assert(message.content == content)
```

And you can pass this message to you message queue as you would have done
with your content:

``` ruby
rabbit_mq.push(message.to_json)
```

After that, ou can use the log capability of micro-tracker to keep track
that your process send this message:

``` ruby
message.log('sending_content')
```

The receiver can deserialize the received payload and log that he received
this message with:

``` ruby
serialization = rabbit_mq.pop
message = Utracker::Message.unpack(serialization)
message.log('processing_content')
```

If all of your processes use the same logger configuration:

``` ruby
Utracker.configure do |config|
  config[:service_name] = 'alice' # or 'bob' or 'carl'
  config[:logger_class] = Utracker::MongoDB::Logger
end
```

Then the logs will be normalized and centralized and you'll be able to follow
the flow of messages, replaying them, analyse trafic, smartly scale services
and so on.

## Backends

* MongoDB through [utracker-mongodb][backend-mongodb]

## Features

* [x] Pack and unpack messages into JSON
* [x] Assign an unique identifier to each packed message.
* [x] Retrieve the unique identifier when the message in unpacked.
* [x] Log events concerning a specific message.
* [x] Create messages from a _parent_ message.
* [x] Allow to filter content of the logs (password, etc).

## Useful tools on top of this

* [x] Flow drawer
* [ ] Broken service alert
* [ ] Scaling advisor
* [ ] Replay messages after a failure

[backend-mongodb]: https://github.com/nicoolas25/micro-tracker-mongodb
