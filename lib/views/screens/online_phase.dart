
import 'package:flutter/material.dart';

class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  GlobalKey _key = GlobalKey();

  double _x = 0;
  double _y = 0;
  Offset _offset = Offset.zero;
  Map<String, double> coordinate = {};
  int counter = 0;


  void _getOffset(GlobalKey key) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    setState(() {
      _x = position.dx;
      _y = position.dy;
    });
    print(_x);
    print(_y);
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Color(0xff030712),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(coordinate);
            setState(() {
              counter = counter + 1;
            });
          } ,
          child: Icon(Icons.calculate)),
      body: LayoutBuilder(
        builder: (context, constraints){
          return Center(
            child: Stack(
                children: [
                  GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 3,
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        color: Colors.teal,
                      ),
                      Container(
                        color: Colors.cyan,
                      ),
                      Container(
                        color: Colors.yellowAccent,
                      ),
                      Container(
                        color: Colors.deepOrange,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.greenAccent,
                      ),
                      Container(
                        color: Colors.purpleAccent,
                      ),
                      Container(
                        color: Colors.indigo,
                      ),
                      Container(
                        color: Colors.white,
                      ),
                      Container(
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
              Positioned(
                // left: 248,
                // top: 91.42857142857233,
                // child: Icon(Icons.location_on, color: Colors.blueGrey, size: 50),
                child: Draggable(
                  childWhenDragging: Container(),
                  feedback: Icon(Icons.add_location, color: Colors.black,size: 50),
                  onDragEnd: (details) {
                    setState(() {
                      final adjustment = MediaQuery.of(context).size.height -
                          constraints.maxHeight;
                      _offset = Offset(
                          details.offset.dx, details.offset.dy - adjustment);
                      coordinate["x_point$counter"] = details.offset.dx;
                      coordinate["y_point$counter"] = details.offset.dy - adjustment;

                    });
                  },
                  child: Icon(Icons.add_location, color: Colors.black, size: 50),
                  ),
                ),
            ]),
          );
        }
      ),
    );
  }
}
