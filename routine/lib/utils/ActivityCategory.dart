class ActivityCategory {
  final String name;
  final String imageUrl;
  const ActivityCategory({this.name, this.imageUrl});

  @override
  String toString() {
    return '${this.name}: ${this.imageUrl}';
  }
}
