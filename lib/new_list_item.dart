import 'package:flutter/material.dart';

class NewListItem extends StatefulWidget {
  @override
  _NewListItemState createState() => _NewListItemState();
}

class _NewListItemState extends State<NewListItem> {
  String newItem;
  GlobalKey<FormState> _key;

  @override
  void initState() {
    newItem = "";
    _key = new GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New List Item'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: newItem,
                decoration: InputDecoration(
                  hintText: 'Title',
                  labelText: 'New List Item',
                ),
                onChanged: (String val){
                  setState(() {
                    newItem = val;
                  });
                },
                validator: (String val){
                  if(val == '')
                    return 'To-Do List item can not be empty';
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: (){
                        if(_key.currentState.validate())
                          Navigator.pop(context, newItem);
                      },
                      icon: Icon(Icons.save),
                      label: Text('Done'),
                  ),
                  FlatButton.icon(
                    onPressed: (){
                        Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                    label: Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
