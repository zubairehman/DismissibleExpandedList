import 'package:dismissible_expanded_list/dismissible_expanded_list.dart';
import 'package:example/mock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpansionTileSample());
}

class ExpansionTileSample extends StatefulWidget {
  @override
  _ExpansionTileSampleState createState() => _ExpansionTileSampleState();
}

class _ExpansionTileSampleState extends State<ExpansionTileSample> {
  String title = 'Not Yet Selected';
  String selectedId = '1.1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(
                    left: 5.0, top: 5.0, bottom: 5.0, right: 2.0),
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(title),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    DismissibleExpandableList(
                  parentIndex: index,
                  entry: mockData[index],
                  removeTileOnDismiss: true,
                  allowBatchSwipe: true,
                  allowChildSwipe: false,
                  showBorder: false,
                  showInfoBadge: true,
                  badgeColor: Colors.green,
                  badgeTextColor: Colors.white,
                  selectedId: selectedId,
                  rightSwipeColor: Colors.green,
                  leftSwipeColor: Colors.red,
                  lineColor: Colors.grey[400],
                  selectionColor: Colors.red,
                  trailingIcon: Icons.info_outline,
                  onItemClick: (parentIndex, childIndex) {
                    setState(() {
                      if (childIndex == -1) {
                        title = mockData[parentIndex].title;
                        selectedId = mockData[parentIndex].id;
                      } else {
                        selectedId =
                            mockData[parentIndex].children[childIndex].id;
                        title =
                            mockData[parentIndex].children[childIndex].title;
                      }
                    });
                  },
                  onItemDismissed: (parentIndex, childIndex, direction,
                      removeTileOnDismiss) {
                    if (childIndex == -1) {
                      // show message
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(mockData[parentIndex].title)));

                      // Remove the item from the data source.
                      if (removeTileOnDismiss) {
                        setState(() {
                          mockData.removeAt(parentIndex);
                        });
                      }
                    } else {
                      // show message
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              mockData[index].children[childIndex].title)));

                      // Remove the item from the data source.
                      if (removeTileOnDismiss) {
                        setState(() {
                          mockData[index].children.removeAt(childIndex);
                        });
                      }
                    }
                  },
                ),
                itemCount: mockData.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
