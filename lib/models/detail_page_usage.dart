enum DetailPageUsage {
  create('create'),
  view('view'),
  edit('edit');

  final String value;
  const DetailPageUsage(this.value);

  static DetailPageUsage? fromString(String? value) {
    if (value == null) {
      return null;
    }
    return DetailPageUsage.values.firstWhere((e) => e.value == value);
  }
}
