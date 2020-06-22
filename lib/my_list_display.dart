import 'package:flutter/material.dart';

class MyList extends StatelessWidget {

  final List<String> toDo;
  final Function onPressed;

  MyList({this.toDo, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      //add decoration later
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: toDo.map((String x){
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      '${toDo.indexOf(x) + 1}. $x',
                      style: TextStyle(fontSize: 18.0)
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    size: 20.0,
                  ),
                  onTap: () => onPressed(x),
                )
              ],
            ),
          );
        }).toList(),
      )
    );
  }
}
