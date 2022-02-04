extension L<T> on Iterable<T> {
  List<K> mapIndex<K>(Function(T item, int index) map) {
    int i = 0;
    return this.map<K>((element) => map(element, i++)).toList();
  }
}
