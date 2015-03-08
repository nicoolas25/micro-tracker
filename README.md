# Micro-tracker

[![Build Status](https://travis-ci.org/nicoolas25/micro-tracker.svg?branch=development)](https://travis-ci.org/nicoolas25/micro-tracker)
[![Code Climate](https://codeclimate.com/github/nicoolas25/micro-tracker/badges/gpa.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker)
[![Test Coverage](https://codeclimate.com/github/nicoolas25/micro-tracker/badges/coverage.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker)

Modern web application are more and more designed with micro-services. Those services exchange messages in order to communicate with each other. Eventually your architecture ends with a graph of services that could be quite complex. Micro-tracker is all about tracking this micro-service's interactions in order to know which service received which message, when and from which other service. It will help you monitor your architecture and debug faster.

## Features

* [x] Assign an unique identifier to each packed message.
* [x] Retrieve the unique identifier when the message in unpacked.
* [x] Log events concerning a message.
* [x] Create messages using a parent message.
* [x] Allow to filter the payload in logs.

## Backends

* MongoDB through [utracker-mongodb][backend-mongodb]

## Useful tools on top of this

* [ ] Broken service alert
* [ ] Scaling advisor
* [ ] Replay messages after a failure

[backend-mongodb]: https://github.com/nicoolas25/micro-tracker-mongodb
