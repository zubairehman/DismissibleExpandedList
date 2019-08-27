class ExpandableListItem {
  final String id;
  final String title;
  final String subTitle;
  final String badgeText;
  final List<ExpandableListItem> children;
  bool selected;

  ExpandableListItem({
    this.badgeText,
    this.id,
    this.title,
    this.subTitle,
    this.selected = false,
    this.children = const <ExpandableListItem>[],
  });
}
