// The entire multilevel list displayed by this app.

import 'package:dismissible_expanded_list/model/entry.dart';
import 'package:flutter/material.dart';

final List<ExpandableListItem> mockData = <ExpandableListItem>[
  ExpandableListItem(
    id: '1',
    title: getTextWidget('Chapter A'),
    subTitle: getTextWidget('Subtitle'),
    selected: true,
    badgeText: 'In Progress',
    badgeColor: Color(0xFFFFE082),
    badgeTextColor: Color(0xFF000000),
    children: <ExpandableListItem>[
      ExpandableListItem(
        id: '1.1',
        title: getTextWidget('Section A0'),
        subTitle: getTextWidget('Subtitle'),
        selected: true,
        badgeText: 'Not Started',
        badgeColor: Color(0xFFFFE082),
        badgeTextColor: Color(0xFF000000),
      ),
      ExpandableListItem(
        id: '1.2',
        title: getTextWidget('Section A1'),
        subTitle: getTextWidget('Subtitle'),
        selected: false,
        badgeText: 'In-Progress',
        badgeColor: Color(0xFFFFE082),
        badgeTextColor: Color(0xFF000000),
      ),
      ExpandableListItem(
        id: '1.3',
        title: getTextWidget('Section A2'),
        subTitle: getTextWidget('Subtitle'),
        selected: false,
        badgeText: 'Completed',
        badgeColor: Color(0xFF44b468),
        badgeTextColor: Color(0xFFFFFFFF),
      ),
      ExpandableListItem(
        id: '1.3',
        title: getTextWidget('Section A2'),
        subTitle: getTextWidget('Subtitle'),
        selected: false,
        badgeText: 'Problem',
        badgeColor: Color(0xFFc32d2e),
        badgeTextColor: Color(0xFFFFFFFF),
      ),
    ],
  ),
  ExpandableListItem(
    id: '2',
    title: getTextWidget('Chapter B'),
    subTitle: getTextWidget('Subtitle'),
    selected: false,
    badgeText: 'Completed',
    badgeColor: Color(0xFF44b468),
    badgeTextColor: Color(0xFFFFFFFF),
    children: <ExpandableListItem>[
      ExpandableListItem(
        id: '2.1',
        title: getTextWidget('Section B0'),
        subTitle: getTextWidget('Subtitle'),
        badgeText: 'In-Progress',
        badgeColor: Color(0xFFFFE082),
        badgeTextColor: Color(0xFF000000),
      ),
      ExpandableListItem(
        id: '2.2',
        title: getTextWidget('Section B1'),
        subTitle: getTextWidget('Subtitle'),
        badgeText: 'Problem',
        badgeColor: Color(0xFFc32d2e),
        badgeTextColor: Color(0xFFFFFFFF),
      ),
    ],
  ),
  ExpandableListItem(
    id: '4',
    title: getTextWidget('Chapter D'),
    subTitle: getTextWidget('Subtitle'),
    badgeText: 'Completed',
    badgeColor: Color(0xFF44b468),
    badgeTextColor: Color(0xFFFFFFFF),
    children: <ExpandableListItem>[],
  ),
];

String getTextWidget(String text) {
  return text;
}
