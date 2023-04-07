import 'package:flutter/material.dart';
import 'package:rider/tabPages/earning_tab.dart';
import 'package:rider/tabPages/home_tab.dart';
import 'package:rider/tabPages/ratings_tab.dart';


import '../../tabPages/profile_tab.dart';

class MainScreen extends StatefulWidget
{
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  TabController? tabController;
  int selectedIndex =0;

onItemClicked(int index)
{
  setState(() {
    selectedIndex = index;
    tabController!.index = selectedIndex;
  });
}

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: TabBarView(
       physics: const NeverScrollableScrollPhysics(),
       controller: tabController,
       children: [
         HomeTabPage(),
         EarningTabPage(),
         RaitingsTabPage(),
         ProfileTabPage(),
       ],
     ),
       bottomNavigationBar:
       BottomNavigationBar(
         items: const [


           BottomNavigationBarItem(icon: Icon(Icons.home),
           label: "Home",
          ),
           BottomNavigationBarItem(icon: Icon(Icons.credit_card),
             label: "location",
           ),
           BottomNavigationBarItem(icon: Icon(Icons.star),
             label: "Raitings",
           ),
           BottomNavigationBarItem(icon: Icon(Icons.home),
             label: "Account",
           ),
      ],


         unselectedItemColor: Colors.white54,
         selectedItemColor: Colors.white,
         backgroundColor: Colors.black,
         type: BottomNavigationBarType.fixed,
         selectedLabelStyle: const TextStyle(fontSize: 14),
         showUnselectedLabels: true,
         currentIndex: selectedIndex,
         onTap: onItemClicked,
     ),
    );
  }
}
