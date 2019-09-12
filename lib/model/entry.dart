import 'package:flutter/material.dart';

class ExpandableListItem {
  final String id;
  final String title;
  final String subTitle;
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
    this.selected = false,
    this.children = const <ExpandableListItem>[],
  });
}
