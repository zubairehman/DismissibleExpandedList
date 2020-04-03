import 'package:dismissible_expanded_list/constants/text_styles.dart' as style;
import 'package:flutter/material.dart';

class DismissibleListConfig {
  double badgeWidth;
  double listTileHeight;
  double listElevation;
  double infoBadgeElevation;
  double infoIconSize;
  double leadingIconSize;
  double cornerIconPadding;
  bool removeTileOnDismiss;
  bool allowBatchSwipe;
  bool allowChildSwipe;
  bool allowParentSelection;
  bool showBorder;
  bool showInfoBadge;
  bool showTrailingIcon;
  TextStyle titleStyle;
  TextStyle titleSelectedStyle;
  TextStyle subTitleStyle;
  TextStyle subTitleSelectedStyle;
  IconData leadingIconForBatch;
  IconData leadingIconForChild;
  IconData trailingIcon;
  IconData topLeftIcon;
  IconData bottomLeftIcon;
  IconData bottomRightIcon;
  IconData topRightIcon;
  Color lineColor;
  Color selectionColor;
  Color rightSwipeColor;
  Color leftSwipeColor;
  Color iconColor;
  Color iconSelectedColor;
  Color backgroundColor;
  Color cornerBackgroundColor;
  Color cornerSelectionColor;
  List<Icon> icons;

  DismissibleListConfig({
    this.badgeWidth = 80.0,
    this.listTileHeight = 80.0,
    this.listElevation = 3.0,
    this.infoBadgeElevation = 0.0,
    this.infoIconSize = 16.0,
    this.leadingIconSize = 20.0,
    this.cornerIconPadding = 3.0,
    this.removeTileOnDismiss = true,
    this.allowBatchSwipe = true,
    this.allowChildSwipe = true,
    this.allowParentSelection = true,
    this.showBorder = false,
    this.showInfoBadge = true,
    this.showTrailingIcon = false,
    this.titleStyle = style.titleStyle,
    this.titleSelectedStyle = style.titleSelectedStyle,
    this.subTitleStyle = style.subTitleStyle,
    this.subTitleSelectedStyle = style.subTitleSelectedStyle,
    this.leadingIconForBatch = Icons.layers,
    this.leadingIconForChild = Icons.work,
    this.trailingIcon = Icons.info_outline,
    this.topLeftIcon,
    this.bottomLeftIcon,
    this.bottomRightIcon,
    this.topRightIcon,
    this.lineColor = const Color(0xFFe0e0e0),
    this.selectionColor = const Color(0xFFcee9f0),
    this.rightSwipeColor = Colors.green,
    this.leftSwipeColor = Colors.red,
    this.iconColor = Colors.black87,
    this.iconSelectedColor = Colors.black87,
    this.backgroundColor = Colors.white,
    this.cornerBackgroundColor = Colors.white,
    this.cornerSelectionColor = const Color(0xFFf3f3f3),
    this.icons = const [],
  });
}
