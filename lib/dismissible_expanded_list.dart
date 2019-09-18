library dismissible_expanded_list;

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
import 'package:dismissible_expanded_list/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dismissible_expanded_list/model/entry.dart';
import 'package:dismissible_expanded_list/utils/timeline/timeline_painter.dart';
import 'package:dismissible_expanded_list/widgets/custom_expansion_tile.dart';

// type defs:-------------------------------------------------------------------
typedef void OnItemDismissed(int parentIndex, int childIndex,
    DismissDirection onDismissed, bool removeTileOnDismiss);
typedef void OnItemClick(int parentIndex, int childIndex);

// constants:-------------------------------------------------------------------
const Duration _kExpand = Duration(milliseconds: 200);

class DismissibleExpandableList extends StatefulWidget {
  final int parentIndex;
  final double badgeWidth;
  final String selectedId;
  final bool removeTileOnDismiss;
  final bool allowBatchSwipe;
  final bool allowChildSwipe;
  final bool allowParentSelection;
  final bool showBorder;
  final bool showInfoBadge;
  final Color rightSwipeColor;
  final Color leftSwipeColor;
  final Color lineColor;
  final Color selectionColor;
  final Color iconColor;
  final Color iconSelectedColor;
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle titleSelectedStyle;
  final TextStyle subTitleSelectedStyle;
  final IconData trailingIcon;
  final ExpandableListItem entry;
  final OnItemDismissed onItemDismissed;
  final OnItemClick onItemClick;

  DismissibleExpandableList({
    @required this.entry,
    @required this.lineColor,
    @required this.parentIndex,
    @required this.selectionColor,
    this.onItemDismissed,
    this.onItemClick,
    this.removeTileOnDismiss = true,
    this.allowBatchSwipe = false,
    this.allowChildSwipe = true,
    this.showInfoBadge = false,
    this.allowParentSelection = false,
    this.selectedId,
    this.showBorder,
    this.rightSwipeColor = Colors.green,
    this.leftSwipeColor = Colors.red,
    this.trailingIcon,
    this.iconColor = Colors.black,
    this.iconSelectedColor = Colors.black,
    this.titleStyle,
    this.subTitleStyle,
    this.titleSelectedStyle,
    this.subTitleSelectedStyle,
    this.badgeWidth = 60.0,
    this.backgroundColor = Colors.white,
  }) {
    if (showInfoBadge) {
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
  AnimationController _controller;
  AnimationController _controller1;
  Animation<double> _iconTurns;
  bool _isExpanded = false;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _controller1 = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _controller1.drive(_halfTween.chain(_easeInTween));
    _controller.forward();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller1.value = 1.0;
    onExpansionChange(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
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
      return widget.allowBatchSwipe
          ? _buildDismissibleTile(root, parentIndex, -1)
          : _buildListTileCard(root, parentIndex, -1);
    }

    return Stack(
      children: <Widget>[
        CustomExpansionTile(
          key: _expansionTile,
          showBorder: widget.showBorder,
          initiallyExpanded: shouldExpand(root),
          onExpansionChanged: (isExpanded) {
            setState(() {
              onExpansionChange(isExpanded);
            });
          },
          listTile: widget.allowBatchSwipe
              ? _buildDismissibleTile(root, parentIndex, -1)
              : _buildListTileCard(root, parentIndex, -1),
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
                          animation: _controller,
                        ),
                        Expanded(
                          child: widget.allowChildSwipe
                              ? _buildDismissibleTile(
                                  entry, parentIndex, childIndex)
                              : _buildListTileCard(
                                  entry, parentIndex, childIndex),
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
        widget.onItemDismissed(
            parentIndex, childIndex, direction, widget.removeTileOnDismiss);
        return widget.removeTileOnDismiss;
      },
      // Show a red background as the item is swiped away.
      background: Container(color: widget.rightSwipeColor),
      secondaryBackground: Container(color: widget.leftSwipeColor),
      child: Card(
        color: !widget.allowParentSelection && root.children.isNotEmpty
            ? widget.backgroundColor
            : root.id != null && root.id == widget.selectedId
                ? widget.selectionColor
                : widget.backgroundColor,
        child: _buildListTile(root, parentIndex, childIndex),
      ),
    );
  }

  Widget _buildListTile(
      ExpandableListItem root, int parentIndex, int childIndex) {
    return Stack(
      children: <Widget>[
        widget.showInfoBadge ? _buildBadge(root) : SizedBox.shrink(),
        ListTile(
          contentPadding:
              EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
          title: _buildTitle(root),
          subtitle: _buildSubTitle(root),
          onTap: () {
            widget.onItemClick(parentIndex, childIndex);

            //only collapse if its a parent
            if (!root.id.contains('.') && root.children.isNotEmpty) {
//          CustomExpansionTile.of(context).toggle();
              _expansionTile.currentState.toggle();
            }
          },
        ),
      ],
    );
  }

  Widget _buildListTileCard(
      ExpandableListItem root, int parentIndex, int childIndex) {
    return Card(
      color: !widget.allowParentSelection && root.children.isNotEmpty
          ? widget.backgroundColor
          : root.id != null && root.id == widget.selectedId
              ? widget.selectionColor
              : widget.backgroundColor,
      child: Stack(
        children: <Widget>[
          widget.showInfoBadge ? _buildBadge(root) : SizedBox.shrink(),
          ListTile(
            contentPadding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
            title: _buildTitle(root),
            subtitle: _buildSubTitle(root),
            onTap: () {
              widget.onItemClick(parentIndex, childIndex);

              //only collapse if its a parent
              if (!root.id.contains('.') && root.children.isNotEmpty) {
//          CustomExpansionTile.of(context).toggle();
                _expansionTile.currentState.toggle();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(ExpandableListItem root) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Text(
            root.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: shouldApplySelection(root)
                ? widget.titleSelectedStyle ?? TextStyles.titleSelected
                : widget.titleStyle ?? TextStyles.title,
          ),
        ),
        widget.trailingIcon != null
            ? Icon(
                widget.trailingIcon,
                size: 15.0,
                color: shouldApplySelection(root)
                    ? widget.iconSelectedColor
                    : widget.iconColor,
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _buildSubTitle(ExpandableListItem root) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget child) => Row(
        children: <Widget>[
          Expanded(
            child: Text(
              root.subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: shouldApplySelection(root)
                  ? widget.subTitleSelectedStyle ?? TextStyles.subTitleSelected
                  : widget.subTitleStyle ?? TextStyles.subTitle,
            ),
          ),
          root.children.length > 0
              ? RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    Icons.expand_more,
                    size: 18.0,
                    color: shouldApplySelection(root)
                        ? widget.iconSelectedColor
                        : widget.iconColor,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildBadge(ExpandableListItem root) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: widget.badgeWidth,
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
    );
  }

  Widget _buildLine(int index) {
    return Container(
      width: 25.0,
      child: CustomPaint(
        painter: TimelinePainter(
            lineColor: widget.lineColor,
            backgroundColor: Colors.blue,
            firstElement: index == 0,
            lastElement: widget.entry.children.length == index + 1,
            controller: _controller),
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
  void onExpansionChange(bool isExpanded) {
    _isExpanded = isExpanded;
    if (_isExpanded)
      _controller1.forward();
    else
      _controller1.reverse().then<void>((dynamic value) {
        setState(() {
          // Rebuild without widget.children.
        });
      });
    PageStorage.of(context)?.writeState(context, _isExpanded);
  }

  bool shouldExpand(ExpandableListItem root) {
    return widget.selectedId.split('.')[0] == root.id;
  }

  bool shouldApplySelection(ExpandableListItem root) {
    return widget.allowParentSelection
        ? root.id == widget.selectedId
        : root.children.length == 0 && root.id == widget.selectedId;
  }
}
