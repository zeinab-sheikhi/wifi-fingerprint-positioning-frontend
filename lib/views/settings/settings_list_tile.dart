import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsListTile extends StatelessWidget {

  String title;
  String subtitle;
  Widget leadingIcon;
  Widget trailingWidget;

  SettingsListTile({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailingWidget,
});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _buildBody(width, height);
  }

  Widget _buildBody(double width, double height) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xff242c42),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: ListTile(
        title: _titleText(),
        subtitle: _subtitleText(),
        leading: leadingIcon,
        trailing: trailingWidget,
        contentPadding: EdgeInsets.symmetric(horizontal: width / 20),
      ),
    );
  }

  Widget _titleText() {
    return Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        )
    );
  }

  Widget _subtitleText() {
    return Text(
      subtitle,
      style: TextStyle(
          color: Colors.grey,
          fontSize: 14
      ),
    );
  }
}
