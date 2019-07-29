query.dart
===

A Django inspired query library.

---
### Example
```dart
 Query get_ids = new Query({ 'id__lt': 5 });
 List<Map> ids = [{'id': 2}, {'id': 6}, {'id': 4}];
 get_ids.filter(ids); // {id: 2}, {id: 4}
 get_ids.map(ids); // [true, false, true]
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

### Supports Nested Maps and methods

```dart
List<Map> sample_data = [
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


Query get_user = new Query({
    "time__getFullYear__eq": 2016, // method
    "user__username__icontain": "ron"// object
});

get_user.filter(sample_data);
// [{id: 2...}]

```

# aggregate.dart 
---
A Django inspired aggregation library.
### Example
```dart
List<Map> scores = [{user: {score: 25}}, {user: {score: 50}}, {user: {score: 60}}, {user: {score: 70}}];
Aggregate stats = new Aggregate('user__score');
stats.avg("user__score", scores); // averAggregatee: 51.25
stats.max("user__score", scores); // max: 70
stats.min("user__score", scores); // min: 25
stats.sum("user__score", scores); // summation: 205
stats.count("user__score", scores); // all objs with field: 4
```
