Query.js
===
---
### Example
```javascript
 var get_ids = Qs({  
    id__lt: 5
 });
 var ids = [{id: 2}, {id: 6}, {id: 4}];
 ids.filter(get_ids); // {id: 2}, {id: 4}
 ids.map(get_ids); // [true, false, true]
```

### Filter Options
| Filter | comparison | Example   |
| ------ |:--------   | ----------|
| lt     | a < b      | id__lt: 3  |
| gt     | a > b      | id__gt: 4  |
| lte    | a <= b     |  id__lte: 3 |
| gte    | a >= b     |  id__gte: 5 |
| eq     | a === b    |  id__eq: 2 |
| not    | a !== b    |  title__not: "Hello" |
| startswith | a.match(/^b/) |  title__startswith: "hello" |
| endswith | a.match(/b$/) |  title__endswith: "goodbye" |
| istartswith | a.toLowerCase().match(/^b/) |  title__istartswith: "hello" |
| iendswith | a.toLowerCase().match(/b$/) |  title__iendswith: "goodbye" |
| contain | a.indexOf(b) > -1 |  title__contain: "hello" |
| icontain | a.toLowerCase().indexOf(b) > -1 |  title__icontain: /[hello]/g |
| rgx    | a.match(b) |  title__rgx: /[hello]/g |
| irgx    | a.toLowerCase().match(b) |  title__irgx: /[hello]/g |
| in | b.indexOf(a) > -1 |  id__in: [1,2,3] |

### Supports Nested Objects and methods

```javascript
var sample_data = [
    {
     id: 2,
     time: new Date(),
     user: {
        username: "kameron"
     }
    },
    {
     id: 3,
     time: new Date(),
     user: {
        username: "bradley"
     }
    },
];


var get_user = Qy({
    "time__getFullYear__eq": 2016, // method
    "user__username__icontain": "ron"// object
});

sample_data.filter(get_users_from_2016);
// [id: 2...]

```