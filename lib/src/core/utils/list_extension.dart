extension ReplaceWhere<T> on List<T> {
  void replaceIfExists(T newElement, T oldElement) {
    final int index = indexWhere((element) => element == oldElement);
    if (index != -1) {
      this[index] = newElement;
    }
  }
}
