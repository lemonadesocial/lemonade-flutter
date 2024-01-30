class ListUtils {
  static T? findWithConditionOrFirst<T>({
    required List<T> items,
    required bool Function(T item) condition,
  }) {
    if (items.isEmpty) return null;
    for (T item in items) {
      if (condition(item)) {
        return item;
      }
    }
    return items.first;
  }
}
