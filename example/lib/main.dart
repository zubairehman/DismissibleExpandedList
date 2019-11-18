import 'package:dismissible_expanded_list/dismissible_expanded_list.dart';
import 'package:dismissible_expanded_list/model/entry.dart';
import 'package:example/mock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: ExpansionTileSample(),
    );
  }
}

class ExpansionTileSample extends StatefulWidget {
  @override
  _ExpansionTileSampleState createState() => _ExpansionTileSampleState();
}

class _ExpansionTileSampleState extends State<ExpansionTileSample> {
  String title = 'Not Yet Selected';
  String selectedId = '1';
  bool removeTileOnDismiss = true;

  final List<ExpandableListItem> list = mockData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2e6f85),
          title: const Text('ExpansionTile'),
        ),
        body: Material(
          child: MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[_buildLeftSide(), _buildRightSide()],
                )
              : Row(
                  children: <Widget>[_buildRightSide()],
                ),
        ),
      ),
    );
  }

  Widget _buildRightSide() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            DismissibleExpandableList(
          parentIndex: index,
          entry: list[index],
          elevation: 3.0,
          titleStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleSelectedStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          subTitleStyle: TextStyle(
            color: Colors.black54,
            fontSize: 12.0,
          ),
          subTitleSelectedStyle: TextStyle(
            color: Colors.black54,
            fontSize: 12.0,
          ),
          removeTileOnDismiss: removeTileOnDismiss,
          allowBatchSwipe: true,
          allowChildSwipe: true,
          allowParentSelection: true,
          showBorder: false,
          showInfoBadge: true,
//          selectedId: selectedId,
          rightSwipeColor: Colors.green,
          leftSwipeColor: Colors.red,
          lineColor: Colors.grey[400],
          badgeWidth: 80.0,
          iconColor: Colors.black87,
          iconSelectedColor: Colors.black87,
          selectionColor: Color(0xFFcee9f0),
          trailingIcon: Icons.info_outline,
          onItemClick: (parentIndex, childIndex, ExpandableListItem item) {
            print('onItemClick called');
            onItemClick(parentIndex, childIndex);
          },
          onItemDismissed:
              (parentIndex, childIndex, direction, removeTileOnDismiss, item) {
            if (direction == DismissDirection.endToStart) {
              onItemDismissed(parentIndex, childIndex);
            } else {
              onItemDismissed(parentIndex, childIndex);
            }
          },
        ),
        itemCount: mockData.length,
      ),
    );
  }

  Widget _buildLeftSide() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0, right: 2.0),
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Text(title),
      ),
    );
  }

  // general methods:-----------------------------------------------------------
  void onItemClick(int parentIndex, int childIndex) {
    setState(
      () {
        if (childIndex == -1) {
          title = mockData[parentIndex].title;
          selectedId = mockData[parentIndex].id;

          // setting entry to true
          mockData.forEach((item) => item.reset());
          mockData[parentIndex].selected = true;
        } else {
          selectedId = mockData[parentIndex].children[childIndex].id;
          title = mockData[parentIndex].children[childIndex].title;

          // setting entry to true
          mockData.forEach((item) => item.reset());
          mockData[parentIndex].selected = true;
          mockData[parentIndex].children[childIndex].selected = true;
        }
      },
    );
  }

  void onItemDismissed(int parentIndex, int childIndex) {
    setState(
      () {
        if (childIndex == -1) {
          mockData.removeAt(parentIndex);
        } else {

          // check to see if its the last child
          // if yes, then remove parent as well
          // else, only remove child
          if(mockData[parentIndex].children != null && mockData[parentIndex].children.length > 1) {
            mockData[parentIndex].children.removeAt(childIndex);
          } else {
            mockData.removeAt(parentIndex);
          }
        }
      },
    );
  }
}
