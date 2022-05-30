// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cleaning_hup/Screens/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../login_screen.dart';

// ignore: must_be_immutable
class WorkerProfile extends StatelessWidget {
  WorkerProfile({Key? key, required this.token}) : super(key: key);
  final String token;
  var _data = {};

  @override
  Widget build(BuildContext context) {
    Uri _url = Uri.parse(
        'https://cleaning.3m-erp.com/khadamaty/api/technical-profile');
    const Color _myColor = Color.fromRGBO(0, 38, 113, 1);

    _loading() async {
      await http.get(_url, headers: {'Authorization': 'Bearer ' + token}).then(
        (response) {
          _data = json.decode(response.body)['data'];
        },
      );
    }

    return FutureBuilder(
        future: _loading(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: _myColor,
              ),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                // const CircleAvatar(
                //   radius: 100,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: _myColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    _data['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _myColor,
                      fontSize: 22,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.mail),
                  title: Text(
                    _data['email'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _myColor,
                      fontSize: 22,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: Text(
                    _data['phone'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _myColor,
                      fontSize: 22,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Change password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _myColor,
                      fontSize: 22,
                    ),
                  ),
                  trailing: Icon(Icons.lock),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ChangePassword(
                            token: token,
                          ))),
                ),
                ListTile(
                  title: Text(
                    'Signout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _myColor,
                      fontSize: 22,
                    ),
                  ),
                  trailing: Icon(Icons.logout),
                  onTap: () {
                    var _logoutUrl = Uri.parse(
                        'https://cleaning.3m-erp.com/khadamaty/api/logout');
                    http.get(_logoutUrl,
                        headers: {'Authorization': 'Bearer ' + token});
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                        _logout();
                  },
                ),
              ],
            );
          }
        });
  }
  _logout() async{
     var _data =await SharedPreferences.getInstance();
     _data.clear();
  }
}
