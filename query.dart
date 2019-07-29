Map<String, Function> comparators = {
  'lt': lt,
  'gt': gt,
  'lte': lte,
  'gte': gte,
  'eq': eq,
  'not': not,
  'startsWith': startsWith,
  'endsWith': endsWith,
  'istartsWith': istartsWith,
  'iendsWith': iendsWith,
  'contains': contains,
  'icontains': icontains,
  'regex': regex,
  'inside': inside
};

Function lt(Function property, int value) {
  bool compare(Map obj) => property(obj) < value;
  return compare;
}

Function gt(Function property, int value) {
  bool compare(Map obj) => property(obj) > value;
  return compare;
}

Function lte(Function property, int value) {
  bool compare(Map obj) => property(obj) <= value;
  return compare;
}

Function gte(Function property, int value) {
  bool compare(Map obj) => property(obj) >= value;
  return compare;
}

Function eq(Function property, int value) {
  bool compare(Map obj) => property(obj) == value;
  return compare;
}

Function not(Function property, int value) {
  bool compare(Map obj) => property(obj) != value;
  return compare;
}

Function startsWith(Function property, String value) {
  bool compare(Map obj) => property(obj).toString().startsWith(value);
  return compare;
}

Function endsWith(Function property, String value) {
  bool compare(Map obj) => property(obj).toString().endsWith(value);
  return compare;
}

Function istartsWith(Function property, String value) {
  bool compare(Map obj) =>
      property(obj).toString().toLowerCase().startsWith(value);
  return compare;
}

Function iendsWith(Function property, String value) {
  bool compare(Map obj) =>
      property(obj).toString().toLowerCase().endsWith(value);
  return compare;
}

Function contains(Function property, String value) {
  bool compare(Map obj) => property(obj).toString().contains(value);
  return compare;
}

Function icontains(Function property, String value) {
  bool compare(Map obj) =>
      property(obj).toString().toLowerCase().contains(value);
  return compare;
}

Function regex(Function property, RegExp value) {
  bool compare(Map obj) => value.hasMatch(property(obj).toString());
  return compare;
}

Function inside(Function property, dynamic value) {
  bool compare(Map obj) {
    var pred = property(obj);
    if (pred is List) {
      return pred.contains(value);
    } else if (pred is Map) {
      return pred.containsKey(value.toString());
    } else {
      return false;
    }
  }

  ;
  return compare;
}

Function deepPropertyName(List<String> path) {
  return (Map obj) => path.fold(obj, (before, next) {
    return before[next] is Map || before[next] is List
        ? before[next]
        : before;
  });
}

class Query {
  Map query = {};
  Query(this.query) {}

  Function _generatePredicate() {
    List<Function> pipe = [];

    query.forEach((key, value) {
      List<String> parts = key.toString().split('__').toList();
      List<String> steps = parts.sublist(0, parts.length - 1);
      String comparator = parts.last;
      Function propertyName = deepPropertyName(steps);

      if (comparators.containsKey(comparator)) {
        pipe.add(comparators[comparator](propertyName, value));
      } else {
        throw ('$comparator not supported');
      }
    });

    bool predicate(Map item) {
      return item.keys.every(
        (key) => pipe.fold(true, (before, next) => before && next(item))
      );
    }

    return predicate;
  }

  map(List<Map> arr) => arr.map(this._generatePredicate()).toList();

  filter(List<Map> arr) => arr.where(this._generatePredicate()).toList();
}
