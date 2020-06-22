import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todolist/my_list_display.dart';
import 'package:todolist/new_list_item.dart';
import 'package:path_provider/path_provider.dart';

class MyToDoList extends StatefulWidget {
  @override
  _MyToDoListState createState() => _MyToDoListState();
}

class _MyToDoListState extends State<MyToDoList> {
  List<String> toDo;

  Future<void> getData() async{
    Directory doc = await getApplicationDocumentsDirectory();
    try{
      File f = File('${doc.path}/list');
      f.readAsString().then((String text) {
        Map<String, dynamic> m = json.decode(text);
        setState(() {
          for(dynamic text in m['data']){
            toDo.add(text.toString());
          }
        });
      });
    }catch(e){
      print('Error: $e');
      toDo = [];
    }
  }

  @override
  void initState() {
    toDo = [];
    getData();
    super.initState();
  }

  void writeData(File f) async{
    Map<String, dynamic> m = {
      'data': toDo
    };
    await f.writeAsString(json.encode(m));
  }

  Future<void> saveData() async{
    Directory d = await getApplicationDocumentsDirectory();
    try{
      File f = File('${d.path}/list');
      writeData(f);
    }catch(e){
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'TO-DO LIST',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'courier',
            letterSpacing: -1.0,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          MyList(toDo: toDo, onPressed: _deleteHandler),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () async{
                    String newListItem = await Navigator.push<String>(context, MaterialPageRoute<String>(builder: (BuildContext c) => NewListItem()));
                    if (newListItem != null && newListItem.isNotEmpty) {
                      setState(() => toDo.add(newListItem));
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('New'),
                  color: Colors.green[200],
              ),
              SizedBox(width: 10.0),
              if(toDo.length > 0) FlatButton.icon(
                  onPressed: () {
                    setState(() => toDo = []);
                  },
                  icon: Icon(Icons.delete_sweep),
                  label: Text('Delete All'),
                  color: Colors.red[200],
                ),
              SizedBox(width: 10.0),
              if(toDo.length > 0) FlatButton.icon(
                  onPressed: () {
                    //save the data in the file
                    saveData();
                  },
                  icon: Icon(Icons.save_alt),
                  label: Text('Save'),
                  color: Colors.blue[200],
                ),
            ],
          )
        ],
      )
    );
  }

  void _deleteHandler(String x){
    setState(() {
      toDo.remove(x);
    });
  }
}
