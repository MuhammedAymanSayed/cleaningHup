import 'package:cleaning_hup/Screens/Worker/worker_orders.dart';
import 'package:cleaning_hup/Screens/Worker/worker_profile.dart';
import 'package:cleaning_hup/Screens/Worker/worker_tasks.dart';
import 'package:flutter/material.dart';

class MainWorkerHome extends StatefulWidget {
  const MainWorkerHome({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<MainWorkerHome> createState() => _MainWorkerHomeState();
}

class _MainWorkerHomeState extends State<MainWorkerHome> {
  int _counter = 0;
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screen = [
      WorkerOrderScreen(token: widget.token),
      WorkerTasksScreen(token: widget.token),
      WorkerProfile(token: widget.token),
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
              icon: Icon(Icons.folder),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'My Tasks',
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
