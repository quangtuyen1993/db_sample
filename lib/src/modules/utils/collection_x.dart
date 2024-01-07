extension CollectionX<T> on Iterable<T> {
  Iterable<R> mapNotNull<R>(R? Function(T) transfer) {
    return map((t) => transfer(t)).whereType<R>();
  }
}
