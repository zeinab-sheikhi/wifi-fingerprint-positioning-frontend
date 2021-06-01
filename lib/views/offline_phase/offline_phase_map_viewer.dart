import 'package:access_point/utils/data/helper.dart';
import 'package:access_point/utils/views/floor_map.dart';
import 'package:access_point/utils/views/map_marker.dart';
import 'package:access_point/views/offline_phase/Offline_phase_alert_dialog.dart';

import 'package:flutter/material.dart';

class OfflinePhaseMap extends StatefulWidget {

  @override
  _OfflinePhaseMapState createState() => _OfflinePhaseMapState();
}

class _OfflinePhaseMapState extends State<OfflinePhaseMap> {

  Map<String, double> coordination = {};
  Offset _offset = Offset(100, 100);
  int counter = 0;

  @override
  void initState() {
    Helper.changeScreenToLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
        builder: (context, constraints){
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                FloorMap(),
                locationMapMarker(constraints)
              ],
            ),
          );
        }
    );
  }

  Widget locationMapMarker(BoxConstraints constraints) {
    return Positioned(
      top: _offset.dx,
      left: _offset.dy,
      child: Draggable(
          child: MapMarker(),
          childWhenDragging: Container(),
          feedback: MapMarker(),
          onDragEnd: (details) { _showDialog(); }
          // onDragEnd: (details) { _onDragEnd(details, constraints); }
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MyAlertDialog(color: Color(0xff43adb7));
      },
    );
  }

  // _onDragEnd(DraggableDetails details, BoxConstraints constraints) {
  //   setState(() {
  //     final adjustment = MediaQuery.of(context).size.width -
  //         constraints.maxWidth;
  //     _offset = Offset(details.offset.dy - adjustment,
  //         details.offset.dx);
  //     counter = counter + 1;
  //     PreferenceUtils.setDouble("tile${counter}X", _offset.dx);
  //     PreferenceUtils.setDouble("tile${counter}Y", _offset.dy);
  //   });
  //
  //   // _showDialog();
  // }


}
