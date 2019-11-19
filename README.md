# dismissible_expanded_list

A Flutter package to provided dismissible and expanded list.

## Getting Started

Use this package as a library
-----------------------------

**1. Depend on it**

Add this to your package's pubspec.yaml file:

```
dependencies:
  dismissible_expanded_list: ^0.2.x
```

**2. Install it**

You can install packages from the command line:

with Flutter

```
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.

**3. Import it**

Now in your Dart code, you can use:

```
import 'package:dismissible_expanded_list.dart';
```

| Property              | Type                  | Default Value               | Description                                                                                                                                                                                                                                                                           |
|-----------------------|-----------------------|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| badgeWidth            | double                | 80.0                        | The (optional) param to control badge width displayed at the top right.                                                                                                                                                                                                               |
| infoBadgeElevation    | double                | 0.0                         | The (optional) param to control the card elevation for info badge displayed at the top right.                                                                                                                                                                                         |
| listElevation         | double                | 3.0                         | The (optional) param to control the card elevation for dismissible list item.                                                                                                                                                                                                         |
| infoIconSize          | double                | 15.0                        | The (optional) param to control the size of info icon displayed in-front of the title.                                                                                                                                                                                                |
| removeTileOnDismiss   | bool                  | true                        | The (optional) param to control either to remove dismissible list items from list or to keep them. If `true` item will be remove from the list and the rest of the items will adjust accordingly, else item will stay at its place and a callback with swiped item will be returned.  |
| allowBatchSwipe       | bool                  | true                        | The (optional) param to control parent/batch swipe at once. If `true` parent/batch will be swiped and removed from list, else it wont and will act as a normal list item.                                                                                                             |
| allowChildSwipe       | bool                  | true                        | The (optional) param to control child swipe. If `true` user will be able to swipe the child else it won't and will act as a normal list item.                                                                                                                                         |
| allowParentSelection  | bool                  | true                        | The (optional) param to control parent selection. If `true` by selecting a child parent will also be selected else only child will show as selected.                                                                                                                                  |
| showBorder            | bool                  | false                       | The (optional) param to add an extra border between expanded and other list items when one of the list item is expanded. If `true` an extra border will be added to top and bottom of expanded item to distinguish it from other items else there will be no boarder.                 |
| showInfoBadge         | bool                  | true                        | The (optional) param to control either to show info badge or not. if `true` info badge will be displayed at the top right corner of the dismissible list item.                                                                                                                        |
| titleStyle            | TextStyle             | TextStyles.title            | The (optional) param to set font style of the title.                                                                                                                                                                                                                                  |
| titleSelectedStyle    | TextStyle             | TextStyles.titleSelected    | The (optional) param to set selected font style of the title.                                                                                                                                                                                                                         |
| subTitleStyle         | TextStyle             | TextStyles.subTitle         | The (optional) param to set font style of the sub-title.                                                                                                                                                                                                                              |
| subTitleSelectedStyle | TextStyle             | TextStyles.subTitleSelected | The (optional) param to set selected font style of the sub-title.                                                                                                                                                                                                                     |
| trailingIcon          | IconData              | Icons.info_outline          | The (optional) param to set the trailing icon.                                                                                                                                                                                                                                        |
| lineColor             | Color                 | Colors.grey[400]            | The (optional) param to set the line color of the expanded list item.                                                                                                                                                                                                                 |
| selectionColor        | Color                 | Color(0xFFcee9f0)           | The (optional) param to set the list item selection color.                                                                                                                                                                                                                            |
| rightSwipeColor       | Color                 | Colors.green                | The (optional) param to set the swipe color of the list item when swiped from left to right.                                                                                                                                                                                          |
| leftSwipeColor        | Color                 | Colors.red                  | The (optional) param to set the swipe color of the list item when swiped from right to left.                                                                                                                                                                                          |
| iconColor             | Color                 | Colors.black87              | The (optional) param to set the trailing icon color.                                                                                                                                                                                                                                  |
| iconSelectedColor     | Color                 | Colors.black87              | The (optional) param to set the trailing icon color when list item is selected.                                                                                                                                                                                                       |
| backgroundColor       | Color                 | Colors.white                | The (optional) param to set the background color of list item.                                                                                                                                                                                                                        |
| parentIndex           | int                   | null                        | The (required) param to populate list item data.                                                                                                                                                                                                                                      |
| entry                 | ExpandableListItem    | null                        | The (required) param to populate list item data.                                                                                                                                                                                                                                      |
| config                | DismissibleListConfig | null                        | The (required) param to set the dismissible list item configuration. e.g. background color, trailing icon size etc.                                                                                                                                                                   |
| onItemClick           | OnItemClick           | null                        | The (optional) param to get the call back whenever list item will be tapped.                                                                                                                                                                                                          |
| onItemDismissed       | OnItemDismissed       | null                        | The (optional) param to get the call back whenever list item will be swiped.                                                                                                                                                                                                          |
