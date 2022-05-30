// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cleaning_hup/Screens/main_worker_home.dart';
import 'package:cleaning_hup/SingleWidgets/my_buttons.dart';
import 'package:cleaning_hup/SingleWidgets/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'main_client_home.dart';

enum accountType {
  worker,
  client,
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _country = TextEditingController();

  String _jop = 'Jop';
  String _area = 'City';
  String _userType = 'client';
  bool _pressed = false;
  accountType _accountType = accountType.client;
  List _areaData = [];
  List _catData = [];
  var _areaId;
  var _catId;

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      setState(() {
        _pressed = true;
      });
      if (_userType == 'client') {
        var _url = Uri.parse(
            'https://cleaning.3m-erp.com/khadamaty/api/client-register');
        http.post(_url, body: {
          'name': _name.text,
          'phone': _phoneNumber.text,
          'password': _password.text,
          'password_confirmation': _passwordConfirmation.text,
          'email': _email.text,
        }).then((response) {
          var x = json.decode(response.body);
          if (x['success'] == true) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MainClientHome(token: x['data']['token']),
              ),
            );
          } else {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: const Text('Wrong credentials'),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                });
            setState(() {
              _pressed = false;
            });
          }
        });
      } else {
        // worker register code
        var _url = Uri.parse(
            'https://cleaning.3m-erp.com/khadamaty/api/technical-register');
        http.post(_url, body: {
          'name': _name.text,
          'phone': _phoneNumber.text,
          'password': _password.text,
          'password_confirmation': _passwordConfirmation.text,
          'email': _email.text,
          'type': '2',
          'area_id': _areaId.toString(),
          'sub_category_id': _catId.toString(),
          'description':_jop,
        }).then((response) {
          var x = json.decode(response.body);
          if (x['success'] == true) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MainWorkerHome(token: x['data']['token']),
              ),
            );
          } else {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: const Text('Wrong credentials'),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                });
            setState(() {
              _pressed = false;
            });
          }
        });
      }
      // var _url2 = Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/login');
      // http.post(_url2, body: {
      //   'phone': _phoneNumber.text,
      //   'password': _password.text,
      // }).then(
      //   (response) {
      //     var x = json.decode(response.body);
      //     if (response.statusCode == 200) {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (_) => MainWorkerHome(token: x['token']),
      //         ),
      //       );
      //     } else {
      //       showDialog(
      //           context: context,
      //           builder: (_) {
      //             return AlertDialog(
      //               content: const Text('Something wrong'),
      //               actions: [
      //                 ElevatedButton(
      //                   onPressed: () => Navigator.of(context).pop(),
      //                   child: const Text('Ok'),
      //                 ),
      //               ],
      //             );
      //           });
      //     }
      //   },
      // );
    }

    _loading() async {
      var _url3 =
          Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/all-areas/1');
      var _url4 = Uri.parse(
          'https://cleaning.3m-erp.com/khadamaty/api/all-sub-categories/2');

      await http.get(_url3).then((value) {
        _areaData = json.decode(value.body)['data'];
      });
      await http.get(_url4).then((value) {
        _catData = json.decode(value.body)['data'];
      });
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
        ),
        body: FutureBuilder(
            future: _loading(),
            builder: (context, data) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: _myColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: CircleAvatar(
                      //     radius: 75,
                      //     child: Icon(
                      //       Icons.person,
                      //       size: 75,
                      //     ),
                      //   ),
                      // ),
                      // MyOutlinedButton(
                      //   fontsize: 14,
                      //   text: 'Add photo',
                      //   color: _myColor,
                      //   onpressed: () {},
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _myColor,
                        ),
                        child: DropdownButton<String>(
                            hint: Text(
                              _userType,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  'client',
                                  style: TextStyle(
                                    color: _myColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                value: 'client',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'worker',
                                  style: TextStyle(
                                    color: _myColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                value: 'worker',
                              ),
                            ],
                            onChanged: (value) {
                              if (value == 'worker') {
                                setState(() {
                                  _accountType = accountType.worker;
                                  _userType = 'worker';
                                });
                              } else {
                                setState(() {
                                  _accountType = accountType.client;
                                  _userType = 'client';
                                });
                              }
                            }),
                      ),
                      NormalTextField(
                        myColor: _myColor,
                        text: 'Name',
                        controller: _name,
                        keyboardType: TextInputType.name,
                        icon: const Icon(Icons.person),
                      ),
                      NormalTextField(
                        myColor: _myColor,
                        text: 'Phone Number',
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        icon: const Icon(Icons.phone_android),
                      ),
                      PasswordTextField(
                        myColor: _myColor,
                        text: 'Password',
                        controller: _password,
                      ),
                      PasswordTextField(
                        myColor: _myColor,
                        text: 'Password Confirmation',
                        controller: _passwordConfirmation,
                      ),
                      NormalTextField(
                        myColor: _myColor,
                        text: 'E-Mail',
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        icon: const Icon(
                          Icons.email,
                        ),
                      ),
                      if (_accountType == accountType.worker)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Location',
                              style: TextStyle(
                                color: _myColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (_accountType == accountType.worker)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: NormalTextField(
                                myColor: _myColor,
                                text: 'Country',
                                controller: _country,
                                keyboardType: TextInputType.emailAddress,
                                icon: const Icon(
                                  Icons.map_rounded,
                                ),
                              ),
                            ),
                            // Flexible(
                            //   child: NormalTextField(
                            //     myColor: _myColor,
                            //     text: 'City',
                            //     controller: _city,
                            //     keyboardType: TextInputType.name,
                            //     icon: const Icon(
                            //       Icons.map_rounded,
                            //     ),
                            //   ),
                            // ),
                            Flexible(
                              child: DropdownButton<Object>(
                                  hint: Text(
                                    _area,
                                    style: TextStyle(
                                      color: _myColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  items: _areaData
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Text(
                                            e['name'],
                                            style: TextStyle(
                                              color: _myColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: e['id'],
                                        ),
                                      )
                                      .toList(),
                                  // items: [
                                  //   DropdownMenuItem(
                                  //     child: Text(
                                  //       'client',
                                  //       style: TextStyle(
                                  //         color: _myColor,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     value: 'client',
                                  //   ),
                                  //   DropdownMenuItem(
                                  //     child: Text(
                                  //       'worker',
                                  //       style: TextStyle(
                                  //         color: _myColor,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     value: 'worker',
                                  //   ),
                                  // ],
                                  onChanged: (value) {
                                    // if (value == 'worker') {
                                    //   setState(() {
                                    //     _accountType = accountType.worker;
                                    //     _userType = 'worker';
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     _accountType = accountType.client;
                                    //     _userType = 'client';
                                    //   });
                                    // }
                                    setState(() {
                                      _area=_areaData.firstWhere((element) => value == element['id'])['name'];
                                      _areaId = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      if (_accountType == accountType.worker)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your Jop',
                              style: TextStyle(
                                color: _myColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (_accountType == accountType.worker)
                        // NormalTextField(
                        //   myColor: _myColor,
                        //   text: 'Jop',
                        //   controller: _jop,
                        //   keyboardType: TextInputType.name,
                        //   icon: const Icon(
                        //     Icons.work,
                        //   ),
                        // ),
                        DropdownButton<Object>(
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _jop,
                                style: TextStyle(
                                  color: _myColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            items: _catData
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(
                                      e['name_ar'],
                                      style: TextStyle(
                                        color: _myColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: e['id'],
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _jop=_catData.firstWhere((element) => value == element['id'])['name_ar'];
                                _catId = value;
                              });
                            }),
                      MyElevatedIcicatorButton(
                        myColor: _myColor,
                        text: 'Signup',
                        onpressed: _onPressed,
                        pressed: _pressed,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
