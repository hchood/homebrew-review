## Homebrews
Hombrewed beers that users submit for their friends to review

### Attributes
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when homebrew was created | `"2012-01-01T12:00:00Z"` |
| **id** | *number* | unique identifier of homebrew | `10` |
| **updated_at** | *date-time* | when homebrew was updated | `"2012-01-01T12:00:00Z"` |
| **brewer_id** | *number* | id of the user who added the homebrew | `5` |
| **name** | *string* | name the user gave the homebrew | `"Extra-hoppy IPA"` |
| **date_brewed** | *date-time* | name the user gave the homebrew | `"2015-01-12T20:20:47-05:00"` |
| **description** | *string* | an optional description of the homebrew | `"A hoppier version of my regular IPA."` |
### Homebrews Info
Info for existing homebrew.

```
GET /homebrews/{homebrew_id}
```


#### Curl Example
```bash
$ curl -n -X GET http://localhost:3000/api//homebrews/$HOMEBREW_ID

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": 10,
  "updated_at": "2012-01-01T12:00:00Z",
  "brewer_id": 5,
  "name": "Extra-hoppy IPA",
  "date_brewed": "2015-01-12T20:20:47-05:00",
  "description": "A hoppier version of my regular IPA."
}
```

### Homebrews List
List existing homebrews.

```
GET /homebrews
```


#### Curl Example
```bash
$ curl -n -X GET http://localhost:3000/api//homebrews

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "created_at": "2012-01-01T12:00:00Z",
    "id": 10,
    "updated_at": "2012-01-01T12:00:00Z",
    "brewer_id": 5,
    "name": "Extra-hoppy IPA",
    "date_brewed": "2015-01-12T20:20:47-05:00",
    "description": "A hoppier version of my regular IPA."
  }
]
```


## Users
The app's users

### Attributes
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when user was created | `"2012-01-01T12:00:00Z"` |
| **id** | *number* | unique identifier of user | `5` |
| **updated_at** | *date-time* | when user was updated | `"2012-01-01T12:00:00Z"` |
| **email** | *email* | email address of user | `"bobloblaw@bobloblawslawblog.com"` |
| **first_name** | *string* | first name of user | `"Bob"` |
| **last_name** | *string* | last name of user | `"Loblaw"` |
### Users Info
Info for existing user.

```
GET /users/{user_id}
```


#### Curl Example
```bash
$ curl -n -X GET http://localhost:3000/api//users/$USER_ID

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": 5,
  "updated_at": "2012-01-01T12:00:00Z",
  "email": "bobloblaw@bobloblawslawblog.com",
  "first_name": "Bob",
  "last_name": "Loblaw"
}
```

### Users List
List existing users.

```
GET /users
```


#### Curl Example
```bash
$ curl -n -X GET http://localhost:3000/api//users

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "created_at": "2012-01-01T12:00:00Z",
    "id": 5,
    "updated_at": "2012-01-01T12:00:00Z",
    "email": "bobloblaw@bobloblawslawblog.com",
    "first_name": "Bob",
    "last_name": "Loblaw"
  }
]
```


