import 'package:flutter/material.dart';
import 'package:home_body/Home/home_mainview.dart';
import 'package:home_body/color.dart';

import 'Party/party_mainview.dart';
import 'Rental/rental_mainview.dart';

class tabBarMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '홈',
      home: BottomNavigator(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}

class BottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavigatorState();
  }
}

class _BottomNavigatorState extends State<BottomNavigator> with SingleTickerProviderStateMixin {

  int _seletedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {
      _seletedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _widgetOptions = [
    HomeMainPage(),
    PartyMainPage(),
    RentalMainPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: SizedBox(
          height: 80.0,
          child: TabBar(

            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: _seletedIndex == 0 ? Icon(Icons.home_outlined, color: Color(mainColor)) : Icon(Icons.home_outlined, color: Color(graytextcolor)),
                child: Text(
                  '홈',
                  style: TextStyle(color: Color(graytextcolor), fontSize: 11),
                ),
              ),
              Tab(
                icon: _seletedIndex == 1 ? Icon(Icons.search_outlined, color: Color(mainColor)) : Icon(Icons.search_outlined, color: Color(graytextcolor)),
                child: Text(
                  '파티 모집',
                  style: TextStyle(color: Color(graytextcolor), fontSize: 11),
                ),
              ),
              Tab(
                icon: _seletedIndex == 2? Icon(Icons.share, color: Color(mainColor)) : Icon(Icons.share, color: Color(graytextcolor)),
                child: Text(
                  '대여하기',
                  style: TextStyle(color: Color(graytextcolor), fontSize: 11),
                ),
              ),
            ],
            indicatorColor: Colors.transparent,
          ),
        ),
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: _widgetOptions,
          ),
        )


    );
  }
}
