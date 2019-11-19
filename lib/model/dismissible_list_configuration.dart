import 'package:dismissible_expanded_list/constants/text_styles.dart';
import 'package:flutter/material.dart';

class DismissibleListConfig {
  var badgeWidth = 80.0;
  var elevation = 3.0;
  var infoIconSize = 15.0;
  var removeTileOnDismiss = true;
  var allowBatchSwipe = true;
  var allowChildSwipe = true;
  var allowParentSelection = true;
  var showBorder = false;
  var showInfoBadge = true;
  var titleStyle = TextStyles.title;
  var titleSelectedStyle = TextStyles.titleSelected;
  var subTitleStyle = TextStyles.subTitle;
  var subTitleSelectedStyle = TextStyles.subTitleSelected;
  var trailingIcon = Icons.info_outline;
  var lineColor = Colors.grey[400];
  var selectionColor = Color(0xFFcee9f0);
  var rightSwipeColor = Colors.green;
  var leftSwipeColor = Colors.red;
  var iconColor = Colors.black87;
  var iconSelectedColor = Colors.black87;
  var backgroundColor = Colors.white;
}
