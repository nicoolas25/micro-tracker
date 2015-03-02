# Micro-tracker

<img src="https://travis-ci.org/nicoolas25/micro-tracker.svg" alt="Build status thanks to Travis CI." />
<img src="https://d3s6mut3hikguw.cloudfront.net/github/nicoolas25/micro-tracker/badges/gpa.svg" alt="GPA thanks to CodeClimate" />
<img src="https://d3s6mut3hikguw.cloudfront.net/github/nicoolas25/micro-tracker/badges/coverage.svg" alt="Code coverage thanks to CodeClimate" />

Modern web application are more and more designed with micro-services. Those services exchange messages in order to communicate with each other. Eventually your architecture ends with a graph of services that could be quite complex. Micro-tracker is all about tracking this micro-service's interactions in order to know which service received which message, when and from which other service. It will help you monitor your architecture and debug faster.

## Properties

* [x] Assign an unique identifier to each packed message.
* [x] Retrieve the unique identifier when the message in unpacked.
* [x] Log events concerning a message.
* [x] Create messages using a parent message.

## Useful tools on top of this

* [ ] Broken service alert
* [ ] Scaling advisor
* [ ] Replay messages after a failure
