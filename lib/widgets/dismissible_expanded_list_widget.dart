library dismissible_expanded_list;

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
import 'package:dismissible_expanded_list/constants/text_styles.dart';
import 'package:dismissible_expanded_list/model/dismissible_list_configuration.dart';
import 'package:dismissible_expanded_list/model/entry.dart';
import 'package:dismissible_expanded_list/model/rectangular_clipper.dart';
import 'package:dismissible_expanded_list/utils/timeline/timeline_painter.dart';
import 'package:dismissible_expanded_list/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';

// type definitions:------------------------------------------------------------
typedef void OnItemDismissed(
  int parentIndex,
  int childIndex,
  DismissDirection onDismissed,
  bool removeTileOnDismiss,
  ExpandableListItem item,
);
typedef void OnItemClick(
    int parentIndex, int childIndex, ExpandableListItem item);

// constants:-------------------------------------------------------------------
const Duration _kExpand = Duration(milliseconds: 200);

class DismissibleExpandableList extends StatefulWidget {
  final int parentIndex;
  final OnItemDismissed onItemDismissed;
  final OnItemClick onItemClick;
  final ExpandableListItem entry;
  final DismissibleListConfig config;

  DismissibleExpandableList({
    @required this.entry,
    @required this.parentIndex,
    @required this.config,
    this.onItemDismissed,
    this.onItemClick,
  }) {
    assert(config != null,
        'Dismissible List Configuration cannot be null, please provide valid configution using DismissibleExpandableList(config: DismissibleListConfig())');
    if (config.showInfoBadge) {
      assert(entry.badgeText != null);
    }
  }

  @override
  _DismissibleExpandableListState createState() =>
      _DismissibleExpandableListState();
}

class _DismissibleExpandableListState extends State<DismissibleExpandableList>
    with TickerProviderStateMixin {
  // global key
  final GlobalKey<CustomExpansionTileState> _expansionTile = new GlobalKey();

  // animation variables:-------------------------------------------------------
  AnimationController _expandCollapseController;
  AnimationController _iconAnimationController;
  Animation<double> _iconTurns;
  bool _isExpanded = false;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  @override
  void initState() {
    super.initState();
    _initControllers();
    _onExpansionChange(true);
  }

  @override
  void dispose() {
    _expandCollapseController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.entry, widget.parentIndex);
  }

  Widget _buildTiles(ExpandableListItem root, int parentIndex) {
//    print('parentIndex $parentIndex');

    // check to see if its a single item with no child
    if (root.children.isEmpty) {
      return widget.config.allowBatchSwipe
          ? _buildDismissibleTile(root, parentIndex, -1)
          : _buildCardTile(root, parentIndex, -1);
    }

    return Stack(
      children: <Widget>[
        CustomExpansionTile(
          key: _expansionTile,
          showBorder: widget.config.showBorder,
          initiallyExpanded: shouldExpand(root),
          onExpansionChanged: (isExpanded) {
            setState(() {
              _onExpansionChange(isExpanded);
            });
          },
          listTile: widget.config.allowBatchSwipe
              ? _buildDismissibleTile(root, parentIndex, -1)
              : _buildCardTile(root, parentIndex, -1),
          children: root.children
              .asMap()
              .map(
                (childIndex, entry) => MapEntry(
                  childIndex,
                  Container(
                    height: 90.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AnimatedBuilder(
                          builder: (BuildContext context, Widget child) =>
                              _buildLine(childIndex),
                          animation: _expandCollapseController,
                        ),
                        Expanded(
                          child: widget.config.allowChildSwipe
                              ? _buildDismissibleTile(
                                  entry, parentIndex, childIndex)
                              : _buildCardTile(entry, parentIndex, childIndex),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        )
      ],
    );
  }

  Widget _buildDismissibleTile(
      ExpandableListItem root, int parentIndex, int childIndex) {
//    print('childIndex $childIndex  id: ${widget.selectedId}');

    return Dismissible(
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify widgets.
      key: PageStorageKey<ExpandableListItem>(root),
      // Provide a function that tells the app
      // what to do after an item has been swiped away.
      confirmDismiss: (direction) async {
        widget.onItemDismissed(parentIndex, childIndex, direction,
            widget.config.removeTileOnDismiss, root);
        return widget.config.removeTileOnDismiss;
      },
      // Show a red background as the item is swiped away.
      background: Container(color: widget.config.rightSwipeColor),
      secondaryBackground: Container(color: widget.config.leftSwipeColor),
      child: _buildCardTile(root, parentIndex, childIndex),
    );
  }

  Widget _buildCardTile(
      ExpandableListItem root, int parentIndex, int childIndex) {
    return Card(
      elevation: widget.config.listElevation,
      color: !widget.config.allowParentSelection && root.children.isNotEmpty
          ? widget.config.backgroundColor
          : root.id != null && root.selected
              ? widget.config.selectionColor
              : widget.config.backgroundColor,
      child: _buildListTileContent(root, parentIndex, childIndex),
    );
  }

  Widget _buildListTileContent(
      ExpandableListItem root, int parentIndex, int childIndex) {
    return Container(
      height: 80.0,
      child: Stack(
        children: <Widget>[
          widget.config.showInfoBadge ? _buildBadge(root) : SizedBox.shrink(),
          _buildListItem(root, parentIndex, childIndex),
          widget.config.topLeftIcon != null
              ? _buildCornerIconWidget(
                  root,
                  radiusTopLeft: 4.0,
                  topLeft: true,
                  icon: widget.config.topLeftIcon,
                  alignment: Alignment.topLeft,
                  paddingTop: widget.config.cornerIconPadding,
                  paddingLeft: widget.config.cornerIconPadding,
                )
              : SizedBox.shrink(),
          widget.config.bottomLeftIcon != null
              ? _buildCornerIconWidget(
                  root,
                  radiusBottomLeft: 4.0,
                  bottomLeft: true,
                  icon: widget.config.bottomLeftIcon,
                  alignment: Alignment.bottomLeft,
                  paddingBottom: widget.config.cornerIconPadding,
                  paddingLeft: widget.config.cornerIconPadding,
                )
              : SizedBox.shrink(),
          widget.config.bottomRightIcon != null
              ? _buildCornerIconWidget(
                  root,
                  radiusBottomRight: 4.0,
                  bottomRight: true,
                  icon: widget.config.bottomRightIcon,
                  alignment: Alignment.bottomRight,
                  paddingBottom: widget.config.cornerIconPadding,
                  paddingRight: widget.config.cornerIconPadding,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildListItem(
      ExpandableListItem root, int parentIndex, int childIndex) {
    return InkWell(
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          root.children != null && root.children.isNotEmpty
              ? _buildLeadingWidget(root, widget.config.leadingIconForBatch)
              : _buildLeadingWidget(root, widget.config.leadingIconForChild),
          SizedBox(width: 8.0),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTitle(root),
                _buildSubTitle(root),
                widget.config.icons != null && widget.config.icons.isNotEmpty
                    ? _buildInfoIcons(root)
                    : SizedBox.shrink(),
              ],
            ),
          ),
          _buildTrailingWidget(root),
          SizedBox(width: 8.0),
        ],
      ),
      onTap: () {
        widget.onItemClick(parentIndex, childIndex, root);

        //only collapse if its a parent
        if (!root.id.contains('.') && root.children.isNotEmpty) {
          _expansionTile.currentState.toggle();
        }
      },
    );
  }

  Widget _buildCornerIconWidget(
    ExpandableListItem root, {
    double radiusTopLeft = 0.0,
    double radiusBottomLeft = 0.0,
    double radiusBottomRight = 0.0,
    double radiusRight = 0.0,
    double paddingLeft = 4.0,
    double paddingBottom = 4.0,
    double paddingTop = 4.0,
    double paddingRight = 4.0,
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
    Alignment alignment,
    IconData icon,
  }) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: alignment,
          child: ClipPath(
            clipper: RectangularClipper(
              topLeft: topLeft,
              topRight: topRight,
              bottomLeft: bottomLeft,
              bottomRight: bottomRight,
            ),
            child: Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: root.id != null && root.selected
                    ? widget.config.cornerBackgroundColor
                    : widget.config.cornerSelectionColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusTopLeft),
                  bottomLeft: Radius.circular(radiusBottomLeft),
                  bottomRight: Radius.circular(radiusBottomRight),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: alignment,
          child: Padding(
            padding: EdgeInsets.only(
              left: paddingLeft,
              bottom: paddingBottom,
              top: paddingTop,
              right: paddingRight,
            ),
            child: Icon(icon, size: widget.config.infoIconSize),
          ),
        )
      ],
    );
  }

  Widget _buildLeadingWidget(ExpandableListItem root, IconData leadingIcon) {
    return Icon(
      leadingIcon,
      size: widget.config.leadingIconSize,
      color: shouldApplySelection(root)
          ? widget.config.iconSelectedColor
          : widget.config.iconColor,
    );
  }

  Widget _buildTitle(ExpandableListItem root) {
    return Text(
      root.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: shouldApplySelection(root)
          ? widget.config.titleSelectedStyle ?? titleSelectedStyle
          : widget.config.titleStyle ?? titleStyle,
    );
  }

  Widget _buildSubTitle(ExpandableListItem root) {
    return root.subTitle != null && root.subTitle.isNotEmpty
        ? Text(
            root.subTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: shouldApplySelection(root)
                ? widget.config.subTitleSelectedStyle ?? subTitleSelectedStyle
                : widget.config.subTitleStyle ?? subTitleStyle,
          )
        : SizedBox.shrink();
  }

  Widget _buildTrailingWidget(ExpandableListItem root) {
    return AnimatedBuilder(
      animation: _expandCollapseController.view,
      builder: (BuildContext context, Widget child) => root.children.length > 0
          ? RotationTransition(
              turns: _iconTurns,
              child: Icon(
                Icons.expand_more,
                size: 18.0,
                color: shouldApplySelection(root)
                    ? widget.config.iconSelectedColor
                    : widget.config.iconColor,
              ),
            )
          : SizedBox.shrink(),
    );
  }

  // info icons:----------------------------------------------------------------
  Widget _buildInfoIcons(ExpandableListItem root) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: widget.config.icons
            .map((icon) => Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(
                    icon.icon,
                    size: widget.config.infoIconSize,
                    color: shouldApplySelection(root)
                        ? widget.config.iconSelectedColor
                        : widget.config.iconColor,
                  ),
                ))
            .toList(),
      ),
    );
  }

  // badge:---------------------------------------------------------------------
  Widget _buildBadge(ExpandableListItem root) {
    return Align(
      alignment: Alignment.topRight,
      child: Card(
        elevation: widget.config.infoBadgeElevation,
        margin: EdgeInsets.all(0.0),
        shape: ContinuousRectangleBorder(),
        child: Container(
          width: widget.config.badgeWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(3.0)),
            color: root.badgeColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Text(
            root.badgeText,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(fontSize: 10.0, color: root.badgeTextColor),
          ),
        ),
      ),
    );
  }

  // line:----------------------------------------------------------------------
  Widget _buildLine(int index) {
    return Container(
      width: 25.0,
      child: CustomPaint(
        painter: TimelinePainter(
            lineColor: widget.config.lineColor,
            backgroundColor: Colors.blue,
            firstElement: index == 0,
            lastElement: widget.entry.children.length == index + 1,
            controller: _expandCollapseController),
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
  void _initControllers() {
    _expandCollapseController =
        AnimationController(duration: _kExpand, vsync: this);
    _iconAnimationController =
        AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _iconAnimationController.drive(_halfTween.chain(_easeInTween));
    _expandCollapseController.forward();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _iconAnimationController.value = 1.0;
  }

  void _onExpansionChange(bool isExpanded) {
    _isExpanded = isExpanded;
    if (_isExpanded)
      _iconAnimationController.forward();
    else
      _iconAnimationController.reverse().then<void>((dynamic value) {
        setState(() {
          // Rebuild without widget.children.
        });
      });
    PageStorage.of(context)?.writeState(context, _isExpanded);
  }

  bool shouldExpand(ExpandableListItem root) {
    return root.selected;
  }

  bool shouldApplySelection(ExpandableListItem root) {
    return widget.config.allowParentSelection
        ? root.selected
        : root.children.length == 0 && root.selected;
  }
}
