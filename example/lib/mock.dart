// The entire multilevel list displayed by this app.

import 'package:dismissible_expanded_list/model/entry.dart';

final List<ExpandableListItem> mockData = <ExpandableListItem>[
  ExpandableListItem(
    id: '1',
    title: getTextWidget('Chapter A'),
    subTitle: getTextWidget('Subtitle'),
    selected: false,
    children: <ExpandableListItem>[
      ExpandableListItem(
        id: '1.1',
        title: getTextWidget('Section A0'),
        subTitle: getTextWidget('Subtitle'),
        selected: false,
      ),
      ExpandableListItem(
        id: '1.2',
        title: getTextWidget('Section A1'),
        subTitle: getTextWidget('Subtitle'),
        selected: false,
      ),
      ExpandableListItem(
        id: '1.3',
        title: getTextWidget('Section A2'),
        subTitle: getTextWidget('Subtitle'),
        selected: false,
      ),
    ],
  ),
  ExpandableListItem(
    id: '2',
    title: getTextWidget('Chapter B'),
    subTitle: getTextWidget('Subtitle'),
    selected: false,
    children: <ExpandableListItem>[
      ExpandableListItem(
        id: '2.1',
        title: getTextWidget('Section B0'),
        subTitle: getTextWidget('Subtitle'),
      ),
      ExpandableListItem(
        id: '2.2',
        title: getTextWidget('Section B1'),
        subTitle: getTextWidget('Subtitle'),
      ),
    ],
  ),
  ExpandableListItem(
    id: '3',
    title: getTextWidget('Chapter C'),
    subTitle: getTextWidget('Subtitle'),
    selected: false,
    children: <ExpandableListItem>[
      ExpandableListItem(
        id: '3.1',
        title: getTextWidget('Section C0'),
        subTitle: getTextWidget('Subtitle'),
      ),
      ExpandableListItem(
        id: '3.2',
        title: getTextWidget('Section C1'),
        subTitle: getTextWidget('Subtitle'),
      ),
      ExpandableListItem(
        id: '3.3',
        title: getTextWidget('Section C2'),
        subTitle: getTextWidget('Subtitle'),
      ),
    ],
  ),
  ExpandableListItem(
    id: '4',
    title: getTextWidget('Chapter D'),
    subTitle: getTextWidget('Subtitle'),
  ),
];

String getTextWidget(String text) {
  return text + ' and some more text';
}
