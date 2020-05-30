class Activity {
  final String name;
  final String description;
  final String categories;
  const Activity({this.name, this.description, this.categories});

  @override
  String toString() {
    return '${this.name}: ${this.description}: ${this.categories}';
  }
}
