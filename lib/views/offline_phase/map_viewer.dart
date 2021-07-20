import 'package:access_point/utils/helper.dart' as helper;
import 'package:access_point/utils/color_utils.dart' as colors;
import 'package:access_point/views/widgets/floor_map.dart';
import 'package:access_point/views/widgets/map_marker.dart';
import 'package:access_point/views/offline_phase/alert_dialog.dart';

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
    helper.changeScreenToLandscape();
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
            color: colors.primaryColor,
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
        return MyAlertDialog(color: colors.accentDarkColor);
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
