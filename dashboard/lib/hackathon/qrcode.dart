import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(QRHome());
}

class QRHome extends StatefulWidget{
  @override
  _QRHomeState createState() => _QRHomeState();
}


class _QRHomeState extends State<QRHome> {
  List<Widget> tiles = new List<Widget>();

  void addTile(textL, textS){
    setState(() {
      tiles.add(new InfoTile(textL: textL, textS: textS));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QR Page',
        theme: ThemeData(
          canvasColor: Colors.white,
          buttonColor: Colors.blue,
          textTheme: TextTheme(
            button: TextStyle(fontSize:30, color:Colors.white)
          )
        ),
        home: QRPage(tiles: tiles, addTile: addTile)
    );
  }
}


class QRPage extends StatelessWidget{

  final List<Widget> tiles;
  final Function addTile;

  QRPage({@required this.tiles, @required this.addTile});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Page', style: TextStyle(fontSize: 30)),
          toolbarHeight: 70,
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 80),
                  QrImage(
                    data: "1234567890987654321",
                    version: QrVersions.auto,
                    size: 350.0,
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              HistoryPage(tiles:tiles, addTile:addTile)),
                      );
                    },
                    padding: const EdgeInsets.only(top:10, bottom:10,
                        left:30, right:30),
                    child: Text('View Recent Activity',
                        style:TextStyle(fontSize:30, color:Colors.white)),
                  )
                ]
            )
        )
    );
  }
}


class InfoTile extends StatelessWidget{
  final String textL;
  final String textS;

  InfoTile({this.textL, this.textS});

  @override
  Widget build(BuildContext context){
    return Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                          '$textL',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                      )
                  ),
                  Text(
                      '$textS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      )
                  )
                ]
            )
        )
    );
  }
}


class HistoryPage extends StatelessWidget{

  final List<Widget> tiles;
  final Function addTile;
  final rng = new Random();

  HistoryPage({@required this.tiles, @required this.addTile});

  void handleChange(){
    addTile(rng.nextInt(1000000000).toString(),
        rng.nextInt(1000000000).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Page', style: TextStyle(fontSize: 30)),
        toolbarHeight: 70,
      ),
      body: Column(
          children: <Widget>[
            Expanded(
              child:  ListView.builder(
                itemCount: tiles.length,
                itemBuilder: (BuildContext context, int index){
                  return tiles[index];
                },
              ),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addTile(rng.nextInt(1000000000).toString(),
                rng.nextInt(1000000000).toString());
          }
      ),
    );
  }
}