import 'package:cleaning_hup/Screens/Client/client_home.dart';
import 'package:cleaning_hup/Screens/Client/client_orders.dart';
import 'package:cleaning_hup/Screens/Client/client_profile.dart';
import 'package:flutter/material.dart';

class MainClientHome extends StatefulWidget {
  const MainClientHome({Key? key, required this.token, }) : super(key: key);
  final String token;
  //final String type;

  @override
  State<MainClientHome> createState() => _MainClientHomeState();
}

class _MainClientHomeState extends State<MainClientHome> {
  int _counter = 0;
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screen = [
      ClientHome(token: widget.token),
      ClientOrdersScreen(token: widget.token),
      ClientProfile(token: widget.token,),
    ];
    PageController _pagectrl = PageController();
    Future<bool> _onBackPressed() {
      if (_counter == 0) {
        return Future.value(true);
      } else {
        _pagectrl.animateToPage(
          0,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        );
        setState(() {
          _counter = 0;
        });
        return Future.value(false);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 90,
          centerTitle: true,
          elevation: 0,
          title: Image.asset('images/logo2.jpg'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: _myColor,
              ),
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: PageView(
            controller: _pagectrl,
            children: _screen,
            onPageChanged: (x) {
              setState(() {
                _counter = x;
              });
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          currentIndex: _counter,
          unselectedItemColor: Colors.grey,
          selectedItemColor: _myColor,
          onTap: (x) {
            setState(() {
              _counter = x;
            });
            _pagectrl.animateToPage(
              x,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
