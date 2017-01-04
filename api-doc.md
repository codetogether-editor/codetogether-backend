# Codetogether API

## HTTP API

### POST /files

Creates a file. Requires authentication.

#### Payload
```
{
  file: {
    name: "", # String, required
  }
}
```

#### Response on success
```
201 Created
{
  file: {
    id: "",
    name: "",
    events: []
  }
}
```

### GET /files/:id

Retrieves a file. Requires authentication

#### Response on success
```
200 Ok
{
  file: {
    id:    "",
    name:  ""
    users: [""] # List of user ids of users that are involved in that file
  }
}
```

#### Response on error
```
404 Not Found
```

### GET /users/:id

Retrieves a user. Requires authentication

#### Response on success
```
200 Ok
{
  user: {
    id: "",
    name: "",
    email: "",
    avatar_url: ""
  }
}
```

#### Response on error
```
404 Not Found
```

### GET /user

Retrieves the current logged in user.

#### Response on success
The same as for `GET /users/:id`


## Channels API

### file:[file_id]

#### Incoming: "event"

```
{
  data: {}
}
```

Payload accepts any JSON that represents an operation on file.
Does not respond.

#### Outgoing: "event"

```
{
  data: {},
  user_id: ""
}
```

Sent out to everybody subscribed to a file on any event reported by any user.
The payload is the exact same that was received in the incoming event.
