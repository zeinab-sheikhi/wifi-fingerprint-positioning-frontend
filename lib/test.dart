import 'package:access_point/utils/data/preferences_util.dart';
import 'package:flutter/material.dart';

class OnLinePhase extends StatefulWidget {
  @override
  _OnLinePhaseState createState() => _OnLinePhaseState();
}

class _OnLinePhaseState extends State<OnLinePhase> {

  int counter = 0;
  List<double> _yCoordinates = [0, 543.9999999999995, 528.6666666666663, 511.99999999999943,
    498.008463541666, 483.34179687499926, 468.0084635416658, 454.00846354166566,
    436.00846354166583, 422.67513020833246, 407.1209716796864, 393.12097167968614,
    378.45430501301934, 361.7876383463522, 347.7876383463522, 333.11362711588333,
    318.4469604492168, 303.78723144531034, 271.7872314453103, 272.4564615885393,
    257.1205647786435, 242.5273234049456, 227.86065673827895, 212.52732340494566,
    199.19399007161223, 183.8606567382789, 167.86065673827886, 153.86065673827892,
    137.0141092936176, 121.68077596028428, 107.01410929361764, 92.34744262695094, 75.45384724934675,
    61.45384724934678, 47.453847249346786
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff030712),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              counter = counter + 1;
              PreferenceUtils.setDouble("tile${counter}Y", _yCoordinates[counter]);
            });
          } ,
          child: Icon(Icons.calculate)),
      body: Center(
        child: Container(
          child: Text('$counter', style: TextStyle(color: Colors.white, fontSize: 28))
        ),
      )
    );
  }
}
