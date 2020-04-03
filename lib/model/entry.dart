import 'package:flutter/material.dart';

class ExpandableListItem {
  final String id;
  final String title;
  final String subTitle;
  final Widget tileBody;
  final String badgeText;
  final List<ExpandableListItem> children;
  final Color badgeColor;
  final Color badgeTextColor;
  bool selected;

  ExpandableListItem({
    this.badgeTextColor,
    this.badgeColor,
    this.badgeText,
    this.id,
    this.title,
    this.subTitle,
    this.tileBody,
    this.selected = false,
    this.children = const <ExpandableListItem>[],
  });

  reset() {
    this.selected = false;

    // if there are any children, call rest on them as well
    this.children.forEach((item) => item.reset());
  }
}
