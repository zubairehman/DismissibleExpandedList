import 'package:dismissible_expanded_list/constants/text_styles.dart' as style;
import 'package:flutter/material.dart';

class DismissibleListConfig {
  double badgeWidth;
  double listElevation;
  double infoBadgeElevation;
  double infoIconSize;
  bool removeTileOnDismiss;
  bool allowBatchSwipe;
  bool allowChildSwipe;
  bool allowParentSelection;
  bool showBorder;
  bool showInfoBadge;
  TextStyle titleStyle;
  TextStyle titleSelectedStyle;
  TextStyle subTitleStyle;
  TextStyle subTitleSelectedStyle;
  IconData trailingIcon;
  Color lineColor;
  Color selectionColor;
  Color rightSwipeColor;
  Color leftSwipeColor;
  Color iconColor;
  Color iconSelectedColor;
  Color backgroundColor;

  DismissibleListConfig({
    this.badgeWidth = 80.0,
    this.listElevation = 3.0,
    this.infoBadgeElevation = 0.0,
    this.infoIconSize = 15.0,
    this.removeTileOnDismiss = true,
    this.allowBatchSwipe = true,
    this.allowChildSwipe = true,
    this.allowParentSelection = true,
    this.showBorder = false,
    this.showInfoBadge = true,
    this.titleStyle = style.titleStyle,
    this.titleSelectedStyle = style.titleSelectedStyle,
    this.subTitleStyle = style.subTitleStyle,
    this.subTitleSelectedStyle = style.subTitleSelectedStyle,
    this.trailingIcon = Icons.info_outline,
    this.lineColor = const Color(0xFFe0e0e0),
    this.selectionColor = const Color(0xFFcee9f0),
    this.rightSwipeColor = Colors.green,
    this.leftSwipeColor = Colors.red,
    this.iconColor = Colors.black87,
    this.iconSelectedColor = Colors.black87,
    this.backgroundColor = Colors.white,
  });
}
