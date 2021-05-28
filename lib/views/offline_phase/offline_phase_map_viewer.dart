import 'package:access_point/utils/data/helper.dart';
import 'package:access_point/utils/views/floor_map.dart';
import 'package:access_point/views/offline_phase/Offline_phase_alert_dialog.dart';
import 'package:flutter/material.dart';

class MapViewer extends StatefulWidget {

  @override
  _MapViewerState createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer> {

  Map<String, double> coordination = {};
  Offset _offset = Offset(100, 100);

  @override
  void initState() {
    Helper.changeScreenToLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _offset  = Offset(height / 2, width / 2);
    return _buildBody();
  }

  Widget _buildBody() {
    return LayoutBuilder(
        builder: (context, constraints){
          return Center(
            child: Stack(
              children: [
                FloorMap(),
                _addLocationMapMarker(constraints)
              ],
            ),
          );
        }
    );
  }

  Widget _addLocationMapMarker(BoxConstraints constraints) {
    return Positioned(
      top: _offset.dx,
      left: _offset.dy,
      child: Draggable(
          child: _markerIcon(),
          childWhenDragging: Container(),
          feedback: _markerIcon(),
          onDragEnd: (details) { _onDragEnd(details, constraints); }
      ),
    );
  }

  Widget _markerIcon() {
    return Icon(
      Icons.add_location_alt,
      color: Color(0xffec3b40),
      size: 50,
    );
  }

  _onDragEnd(DraggableDetails details, BoxConstraints constraints) {
    setState(() {
      final adjustment = MediaQuery.of(context).size.width -
          constraints.maxWidth;
      _offset = Offset(details.offset.dy - adjustment,
          details.offset.dx);
      coordination["x_offset"] = _offset.dx;
      coordination["y_offset"] = _offset.dy;
    });
    _showDialog();
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
}
