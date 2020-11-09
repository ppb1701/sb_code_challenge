import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridCell extends StatelessWidget {
  final name;
  final data;
  GridCell(this.name, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              name,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0
              ),
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.black,),
          Text(
            data,
            softWrap: true,
            style: TextStyle(
                fontSize: 13.0
            ),
          ),
        ],
      ),
    );
  }
}
