import 'dart:io';

import 'package:band_names/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Band> bands = [
    Band(id: '1',name: 'Matisse',votes: 5),
    Band(id: '2',name: 'Sin bandera',votes: 3),
    Band(id: '3',name: 'Camila',votes: 4),
    Band(id: '4',name: 'La Arrolladora',votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Band Names',style: TextStyle(color: Colors.black),),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) { 
        
        return _bandTile(bands[index]);
       },), 
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         elevation: 1,
         onPressed: addNewBand ,
       ),
     
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red[400],
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.restore_from_trash,color: Colors.white,),
              Text('Delete Band',style: TextStyle(color: Colors.white,),
              ),
            ],
          ),
        ),
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}'),
          onTap: (){

          },
        ),
    
    
    );
  }



  addNewBand(){

    final textController = new TextEditingController();
    if(Platform.isIOS){
        return showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text('Add new band'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              
              onPressed:(){
                addBandToList(textController.text);
              },
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,

            )
          ],

        )
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: (_){
        return CupertinoAlertDialog(
          title: Text('add new Band'),
          content: CupertinoTextField(
            controller: textController,
            
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed:(){
                addBandToList(textController.text);
              },  
            ),
             CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed:(){
                Navigator.pop(context);
              },  
            )
              
          ],
        );
      }
    );

    
  }


  void addBandToList(String name){
    if(name.length>0){
      this.bands.add(Band(id: DateTime.now().toString(), name: name));

      setState(() {
        
      });

    }

    Navigator.pop(context);
  }

}