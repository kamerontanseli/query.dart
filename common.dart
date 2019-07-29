Function deepPropertyName(List<String> path) {
  return (Map obj) => path.fold(obj, (before, next) {
    return before[next] is Map || before[next] is List
        ? before[next]
        : before;
  });
}
