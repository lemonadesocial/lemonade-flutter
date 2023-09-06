class AnimationUtils {
  static double interpolate({
    required double value,
    required double low1,
    required double high1,
    required double low2,
    required double high2,
  }) {
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
  }

  static int calculateMaxItemsInRow({
    required double rowWidth,
    required double itemWidth,
    required double separatorWidth,
  }) {
    double totalWidthForOneItemAndSeparator = itemWidth + separatorWidth;
    int numberOfItems = (rowWidth / totalWidthForOneItemAndSeparator).ceil();
    return numberOfItems;
  }

  static List<List<T>> chunkList<T>({
    required List<T> list,
    required int chunkSize,
  }) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }
}
