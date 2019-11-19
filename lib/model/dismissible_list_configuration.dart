import 'package:dismissible_expanded_list/constants/text_styles.dart';
import 'package:flutter/material.dart';

class DismissibleListConfig {
  double badgeWidth = 80.0;
  double listElevation = 3.0;
  double infoBadgeElevation = 0.0;
  double infoIconSize = 15.0;
  bool removeTileOnDismiss = true;
  bool allowBatchSwipe = true;
  bool allowChildSwipe = true;
  bool allowParentSelection = true;
  bool showBorder = false;
  bool showInfoBadge = true;
  TextStyle titleStyle = TextStyles.title;
  TextStyle titleSelectedStyle = TextStyles.titleSelected;
  TextStyle subTitleStyle = TextStyles.subTitle;
  TextStyle subTitleSelectedStyle = TextStyles.subTitleSelected;
  IconData trailingIcon = Icons.info_outline;
  Color lineColor = Colors.grey[400];
  Color selectionColor = Color(0xFFcee9f0);
  Color rightSwipeColor = Colors.green;
  Color leftSwipeColor = Colors.red;
  Color iconColor = Colors.black87;
  Color iconSelectedColor = Colors.black87;
  Color backgroundColor = Colors.white;

  DismissibleListConfig({
    this.badgeWidth,
    this.listElevation,
    this.infoBadgeElevation,
    this.infoIconSize,
    this.removeTileOnDismiss,
    this.allowBatchSwipe,
    this.allowChildSwipe,
    this.allowParentSelection,
    this.showBorder,
    this.showInfoBadge,
    this.titleStyle,
    this.titleSelectedStyle,
    this.subTitleStyle,
    this.subTitleSelectedStyle,
    this.trailingIcon,
    this.lineColor,
    this.selectionColor,
    this.rightSwipeColor,
    this.leftSwipeColor,
    this.iconColor,
    this.iconSelectedColor,
    this.backgroundColor,
  });
}
