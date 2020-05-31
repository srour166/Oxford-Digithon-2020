class Activity {
  final int id;
  final String name;
  final String description;
  final String categories;
  const Activity({this.id, this.name, this.description, this.categories});

  @override
  String toString() {
    return '${this.id}, ${this.name}: ${this.description}: ${this.categories}';
  }
}
