
import 'package:proyecto_integrado_3/pages/profilePage.dart';
import 'package:proyecto_integrado_3/pages/uploadFilePage.dart';
import 'package:proyecto_integrado_3/widgets/listFilesWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

int _currentIndex = 0;
final List<Widget> _children = [ListFilesWidget(), UploadFilePage(), ProfilePage()];

class _BottomNavPageState extends State<BottomNavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      backgroundColor: const Color.fromARGB(255, 57, 60, 76),
      color: const Color.fromARGB(255, 20, 146, 230),
      animationDuration: Duration(milliseconds: 300),
      items: [
        Icon(
          Icons.home,
          color: const Color.fromARGB(255, 57, 60, 76),
        ),
        Icon(
          Icons.add,
          color: const Color.fromARGB(255, 57, 60, 76),
        ),
        Icon(
          Icons.person,
          color: const Color.fromARGB(255, 57, 60, 76),
        ),
      ],
      index: _currentIndex,
      onTap: _cambiaPagina,
    );
  }

  void _cambiaPagina(int index){

    setState(() {
      _currentIndex = index;
    });
  }


}

