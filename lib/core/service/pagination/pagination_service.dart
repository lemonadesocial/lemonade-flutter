class PaginationService<T, I> {
  List<T> _items = [];
  int _currentPage = 1;
  bool _reachedEnd = false;
  
  Future<List<T>> Function(int skip, bool reachedEnd, {I? input}) getDataFn;
  int limit;

  PaginationService({
    required this.getDataFn,
    this.limit = 100,
  });

  List<T> get items => _items;

  int get currentPage => _currentPage;

  int get skip => (currentPage - 1) * 30;

  bool get reachedEnd => _reachedEnd;

  Future<List<T>> fetch(I? input) async {
    if (_reachedEnd) {
      return _items;
    }

    final newItems = await getDataFn(skip, _reachedEnd, input: input);

    if (newItems.isEmpty) {
      _reachedEnd = true;
    } else {
      _currentPage++;
      _items = [..._items, ...newItems];
    }
    return _items;
  }

  Future<List<T>> refresh(I? input) async {
    _currentPage = 1;
    _reachedEnd = false;
    
    final newItems = await getDataFn(skip, _reachedEnd, input: input);
    _items = newItems;

    return _items;
  }
}
