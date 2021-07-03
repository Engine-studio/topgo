# TopGo

Mobile application for TopGo company.

# TopGo routes and models
## Administrator
::Get curators:: `GET /api/curators`
* Response
```json
[
    {
        "id": 0,
        "surname": "String",
        "name": "String",
        "patronymic": "String",
        "phone": "String",
        "image": "String",
        "blocked": false      
    }
]
```
Phone format is string with 11 chars.
Image format is valid path on server without domain name.

::New curator:: `POST /api/curators`
* Body
```json
{
    "surname": "String",
    "name": "String",
    "patronymic": "String",
    "phone": "String",
    "password": "String"  
}
```

::Block curator:: `PUT /api/curators/block`
* Body
```json
{
    "id": 0
}
```

::Unblock curator:: `PUT /api/curators/unblock`
* Body
```json
{
    "id": 0
}
```

::Delete curator:: `DELETE /api/curators`
* Body
```json
{
    "id": 0
}
```

## Administrator and curator
::New notification:: `POST /api/notifications`
* Body
```json
{
    "title": "String",
    "text": "String"
}
```

::Get couriers:: `GET /api/couriers`
* Response
```json
[
    {
        "id": 0,
        "surname": "String",
        "name": "String",
        "patronymic": "String",
        "phone": "String",
        "image": "String",
        "action": "String",
        "rating": 0.0,
        "cash": 0.0,
        "terminal": 0.0,
        "salary": 0.0,
        "hasTerminal": false,
        "movement": 0,
		  "x": 0.0,
		  "y": 0.0,    
    }
]
```
Action is the field with description of current activity that courier do: ‘Заблокирован’, ‘Доставляет заказ №123123’, ‘Забирает заказ №123123’ или ‘Неактивен’.
Movement gets one of three values: 0, 1, 2 and shows movement type of a courier: 0 - pedestrian, 1 - biker, 2 - driver.
X and Y is coordinates on map.

::New courier:: `POST /api/couriers`
* Body
```json
{
    "surname": "String",
    "name": "String",
    "patronymic": "String",
    "phone": "String",
    "password": "String"  
}
```

::Block courier:: `PUT /api/couriers/block`
* Body
```json
{
    "id": 0
}
```

::Unblock courier:: `PUT /api/couriers/unblock`
* Body
```json
{
    "id": 0
}
```

::Delete courier:: `DELETE /api/couriers`
* Body
```json
{
    "id": 0
}
```

::Discard courier’s performance:: `PUT /api/couriers/discard`
* Body
```json
{
    "id": 0,
    "cash": false,
    "terminal": false,
    "salary": false
}
```

::Get restaurants:: `GET /api/restaurants`
* Response
```json
[
    {
        "id": 0,
        "name": "String",
        "address": "String",
        "open": [8, 0],
        "close": [22, 30],
        "phone": "String",
        "x": 0.0,
        "y": 0.0
    }
]
```

::New restaurant:: `POST /api/restaurants`
* Body
```json
{
    "name": "String",
    "address": "String",
    "phone": "String",
    "password": "String",
    "schedule": {
        "mon": [[8, 0], [20, 0]],
        "tue": [[8, 0], [20, 0]],
        "wed": [[8, 0], [20, 0]],
        "thu": [[8, 0], [20, 0]],
        "fri": [[8, 0], [20, 0]],
        "sat": [[8, 0], [20, 0]],
        "sun": [[8, 0], [20, 0]]
    }
}
```

::Delete restaurant:: `DELETE /api/restaurants`
* Body
```json
{
    "id": 0
}
```

## Courier
::Start work shift:: `PUT /api/couriers/begin`
* Body
```json
{
    "movement": 0,
    "begin": [0, 0],
    "end": [0, 0],
    "hasTerminal": false
}
```

::Stop work shift:: `PUT /api/couriers/end` 

::Get orders history:: `GET /api/orders/history`
* Response
```json
[
    {
        "id": 0,
        "address": {
            "from": "String",
            "to": "String"
        },
        "time": {
            "total": 0,
            "start": [0, 0],
            "stop": [0, 0]
        },
        "payment": {
            "sum": 0.0,
            "withCash": false
        },
        "points": {
            "appearance": 0.0,
            "behavior": 0.0 
        }
    }
]
```

::Get new order:: `GET /api/orders/new`
* Response
```json
[
    {
        "id": 0,
        "address": {
            "from": "String",
            "to": "String",
            "x": 0.0,
            "y": 0.0
        },
        "time": 0,
        "payment": {
            "sum": 0.0,
            "withCash": false
        }
    }
]
```

::Get current orders:: `GET /api/orders/current`
* Response
```json
[
    {
        "id": 0,
        "address": {
            "from": "String",
            "to": "String",
            "x": 0.0,
            "y": 0.0
        },
        "time": 0,
        "payment": {
            "sum": 0.0,
            "withCash": false
        }
    }
]
```

::Accept order:: `PUT /api/orders/accept`
* Body
```json
{
    "id": 0
}
```

::Decline order:: `PUT /api/orders/decline`
* Body
```json
{
    "id": 0
}
```

::Got order:: `PUT /api/orders/got`
* Body
```json
{
    "id": 0
}
```

::Delivered order:: `PUT /api/orders/delivered`
* Body
```json
{
    "id": 0
}
```

::Abnormal situation:: `GET /api/curators/help`
* Response
```json
{
    "id": 0,
    "surname": "String",
    "name": "String",
    "patronymic": "String",
    "phone": "String",
    "image": "String"
}
```

::Polling:: `POST /api/couriers/polling`
* Body
```json
{
    "x": 0.0,
    "y": 0.0
}
```
* Response
```json
[
    {
        "title": "String",
        "text": "String"
    }
]
```

Body contains actual coordinates of courier.
Response contains new notifications.

## General
::Login:: `POST /api/login`
* Body
```json
{
    "login": "String",
    "password": "String"  
}
```
* Response
```json
{
    "logined": true,
    "token": "String",
    "surname": "String",
    "name": "String",
    "patronymic": "String",
    "phone": "String",
    "image": "String",
    "courier": {
        "rating": 0.0,
        "shift": {
            "movement": 0,
            "begin": [0, 0],
            "end": [0, 0],
            "hasTerminal": false,
            "cash": 0.0,
            "terminal": 0.0,
            "salary": 0.0
        }
    },
    "administrator": {},
    "curator": {}
}
```

Fields _courier_, _administrator_ and _curator_ are optional.
Image is not null.
Shift might be null if courier is not working right now.

::Changing photo:: `PUT /api/couriers||curators||administrators`
* Body
```json
{
    "image": "String"
}
```

::Get documents:: `GET /api/documents`
* Response
```json
[
    {
        "id": 0,
        "date": "String",
        "additional": "String",
        "link": "String"
    }
]
```

Additional is an extra field for couriers to show shift details. Must not be null and equal empty string for curators and administrators
