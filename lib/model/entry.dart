class ExpandableListItem {
  final String id;
  final String title;
  final String subTitle;
  final List<ExpandableListItem> children;
  bool selected;

  ExpandableListItem({
    this.id,
    this.title,
    this.subTitle,
    this.selected = false,
    this.children = const <ExpandableListItem>[],
  });
}
