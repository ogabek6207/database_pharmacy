import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:database_pharmacy/ui/save_product/save_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const SaveProductScreen(),
    ];
    final items = [
      SvgPicture.asset("assets/icons/basket.svg"),
      SvgPicture.asset("assets/icons/korzinka.svg",),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      backgroundColor: Colors.blue,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        height: 60,
        items: items,
        index: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
