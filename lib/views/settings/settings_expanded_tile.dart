import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingExpandedTile extends StatefulWidget {

  String title;
  String subtitle;
  Widget leadingIcon;
  Color accentColor;
  List<Widget> childrenWidgets;

  SettingExpandedTile({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.accentColor,
    required this.childrenWidgets,
  });

  @override
  _SettingExpandedTileState createState() => _SettingExpandedTileState();
}

class _SettingExpandedTileState extends State<SettingExpandedTile> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _buildBody(context, width, height);
  }

  Widget _buildBody(BuildContext context, double width, double height) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xff242c42),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            accentColor: widget.accentColor,
            unselectedWidgetColor: Colors.white,
            dividerColor: Colors.transparent
        ),
        child: ExpansionTile(
          title: _titleText(),
          subtitle: _subtitleText(),
          leading: widget.leadingIcon,
          initiallyExpanded: false,
          children: widget.childrenWidgets,
          childrenPadding: EdgeInsets.symmetric(vertical: height / 100),
          expandedAlignment: Alignment.center,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  Widget _titleText() {
    return Text(
        widget.title,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        )
    );
  }

  Widget _subtitleText() {
    return Text(
        widget.subtitle,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 14
        )
    );
  }
}
