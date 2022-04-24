# chat
Realtime Chatting API application in Ruby on Rails

## Overview

- The API is a Chat API (Rails): Main service which provides most of the core management operations (create, update, get) of applications, chats and Realtime messages in this chats using Actioncable  , also supports searching through messages in chats using `elasticsearch`.
- 
## Starting Services
```bash
sudo docker-compose down && sudo docker-compose build && sudo docker-compose up
```
Make sure that `docker` and `docker-compose` are installed with `dockerd` running, also make sure that ports `3000` and  are available for the services to run on.

## Using Services

### Chat API (Rails)
This service exposes these endpoints for operating on applications, chats and messages.
#Note app_no is access token  generated with creation of applications to be idintifier
```
Verb  URI Pattern
----  -----------

GET   api/v1/applications/
POST  api/v1/applications?name={name}
GET   api/v1/applications/{app_no}
PUT  api/v1/applications/{app_no}?name={name}

GET   api/v1/applications/{app_no}/chats
GET   api/v1/applications/{app_no}/chats/{chat_id}

GET   api/v1/applications/{app_no}/chats/{chat_id}/messages
GET   api/v1/applications/{app_no}/chats/{chat_id}/messages/{message_number}
GET   api/v1/applications/{app_no}/chats/{chat_id}/messages/search?keyword={keyword}
PUT   api/v1/applications/{app_no}/chats/{chat_id}/messages/{message_id}?body={message_content}
```
#### Examples

##### Creating a new application
```bash
$ curl -X POST 'http://localhost:3000/api/v1/applications?name=first app'

# output
{"app_no":"TeyH8T9sDxVNJpatroSXK99h","app_name":"first app","created_at":"2022-04-17T23:52:50.000Z","updated_at":"2022-04-17T23:52:50.000Z","Chat_Count":1}
```
#### Create Chat Room 
curl -X POST http://localhost:3000/api/v1/applications/TeyH8T9sDxVNJpatroSXK99h/id=1

{"id":"1","created_at":"2022-04-17T23:52:56.000Z","updated_at":"2022-04-17T23:52:56.000Z",

}
##### Start Chating 

##### Getting messages
```bash
$ curl -X GET 'http://localhost:3000/applications/fPrv7vr57dkUsP4KfZ4BdSmt/chats/1/messages'

# output
[
  {
    "id": 1,
    "content": "test1 chat",
    "created_at":"2022-04-18T23:52:49.000Z","updated_at":"2022-04-18T23:52:49.000Z"
  },
  {
    "number": 2,
    "content": "test 2 ",
    "created_at":"2022-04-18T23:53:58.000Z","updated_at":"2022-04-18T23:53:58.000Z"
  }
]

```
##### Searching chats
```bash
$ curl -X GET 'http://localhost:3000/applications/fPrv7vr57dkUsP4KfZ4BdSmt/chats/1/messages/search?keyword=test 2'

# output
[
  {
    "number": 2,
    "content": "test 2",
    "created_at":"2022-04-19T23:30:20.000Z","updated_at":"2022-04-19T23:30:20.000Z"
  }
]
```


 
 ## How This Works
 -Cable — the WebSocket connection used to communicate all data for all channels.

-Channel — similar to what a controller does in a regular MVC setup. It holds the logic and defines behavior for server and client methods, such as subscriptions.

-Pub/Sub, or Publish-Subscribe — a message queue model whereby “publishers” send data to “subscribers” without specifying individual recipients. Action Cable uses this paradigm to communicate between the server and multiple clients.
Streams — these provide the mechanism by which channels broadcast to their subscribers.

-Broadcasting — the pub/sub link through which anything transmitted by a publisher is routed directly to the channel subscribers who are listening. Each channel can stream zero or more broadcastings.

- Redis — an open source, in-memory data structure store, used as a database, cache, and message broker. Action Cable uses Redis’ pub/sub functions to keep track of what’s been broadcasted on what cable and to whom.
 
 Chat/Message creation API uses `Redis` for two purposes, first of which is to cache and determine the next chat number
 and message number to respond to the user with, second of which is to queue jobs to `background job` workers hosted at the main Rails API. These `Sidekiq`
 workers are responsible of handling requests to create messages in the background, to allow for better scaling in case a huge number of requests is received.
 
 
 - i try to build a service get last 10 messages and put them into cache using redis and sneaker gem then put them into queue , start RabbitMQ dashboard to route them to multi servers using rabbitmq round robin exchange
 
 
     


