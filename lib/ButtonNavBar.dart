import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_project/Text.dart';

import 'Object.dart';
import 'NavIcon.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageindex = 0;
  final TextRecognition _home = const TextRecognition();
  final ObjectRecognition _search = const ObjectRecognition();

  Widget _showpage = const TextRecognition();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        {
          return _home;
        }

      case 1:
        {
          return _search;
        }

      default:
        {
          return const Center(child: Text('this page isnt here'));
        }
    }
  }

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: pageindex,
        items: <Widget>[
          NavIcon(
            image: 'icons/1.svg',
            label: 'Text Recognition Button',
          ),
          NavIcon(
            image: 'icons/2.svg',
            label: 'Object Labeling Button',
          ),
        ],
        color: const Color(0xFF03045E),
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 339),
        onTap: (int tapedindex) {
          pageindex = tapedindex;
          setState(() {
            _showpage = _pageChooser(tapedindex);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _showpage,
    );
  }
}

bool chooser(var token) {
  if (token == null) {
    return false;
  } else {
    return true;
  }
}
