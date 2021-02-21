import 'package:access_point/views/tabs/offline_phase_tab.dart';
import 'package:access_point/views/tabs/wifi_scanner_tab.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _options = <Widget>[
    WiFiScannerTab(),
    Text('OnLine Phase', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    OfflinePhaseTab(),
    Text('Settings', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('WiFi FingerPrint'),
          backgroundColor: Colors.teal
      ),
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.wifi),
                label: 'WiFi Scanner',
                backgroundColor: Colors.teal
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'OnLine Phase',
                backgroundColor: Colors.cyan
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'OffLine Phase',
                backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.lightBlue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTap,
          elevation: 5
      ),
    );
  }
}
