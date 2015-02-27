# Micro-tracker

Modern web application are more and more designed with micro-services. Those services exchange messages in order to communicate with each other. Eventually your architecture ends with a graph of services that could be quite complex. Micro-tracker is all about tracking this micro-service's interactions in order to know which service received which message, when and from which other service. It will help you monitor your architecture and debug faster.

## Properties

* [ ] Assign an unique identifier to each packed message.
* [ ] Retrieve the unique identifier when the message in unpacked.
* [ ] Log events concerning a message.
* [ ] Create messages using a parent message.

## Useful tools on top of this

* [ ] Broken service alert
* [ ] Scaling advisor
* [ ] Replay messages after a failure

## Example

``` ruby
require 'utracker'

UTracker.configure do |config|
  config.service_name = 'Service 1'
end


def send_message(message)
  UTracker::Message.pack(message).tap do |packed_message|
    packed_message.log('sending')
  end
end

def receive_message(packed_message)
  UTracker::Message.unpack(packed_message).tap do |u_message|
    u_message.log('receiving')    
  end
end


message = { 'some' => 'payload', 'with' => 'Hash format' }
packed_message = send_message(message)
u_message = receive_message(packed_message)

assert(u_message.content == message)

new_message = process(u_message.content)
packed_new_message = u_message.pack(new_message)
packed_new_message.log('forwarding')


# Output in the log/database could be:
#
# datetime                      ; service   ; message    ; event uuid                           ; parent uuid                          ; content
# 2015-02-26 09:31:21.000 +0100 ; Service 1 ; sending    ; 037df340-9fc0-0132-5620-56847afe9799 ;                                      ; ...
# 2015-02-26 09:31:21.001 +0100 ; Service 1 ; receiving  ; 037df340-9fc0-0132-5620-56847afe9799 ;                                      ; ...
# 2015-02-26 09:31:21.002 +0100 ; Service 1 ; forwarding ; 80053800-9fc1-0132-5620-56847afe9799 ; 037df340-9fc0-0132-5620-56847afe9799 ; ...
```
