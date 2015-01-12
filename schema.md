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


