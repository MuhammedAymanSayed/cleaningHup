import 'dart:convert';

import 'package:cleaning_hup/Screens/main_client_home.dart';
import 'package:cleaning_hup/Screens/main_worker_home.dart';
import 'package:cleaning_hup/Screens/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../SingleWidgets/my_buttons.dart';
import '../SingleWidgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    _loading() async {
      //var _url = Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/login');
      final _foundData = await SharedPreferences.getInstance();
      if (!_foundData.containsKey('userData')) {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (_) => const LoginScreen(),
        //   ),
        // );
      } else {
        final _extractedData =
            json.decode(_foundData.getString('userData') as String) as Map;
        
        if (_extractedData['type'] == 1) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MainClientHome(token: _extractedData['token']),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MainWorkerHome(token: _extractedData['token']),
            ),
          );
        }
      }
    }

    _shared(x) async {
      final userData = await SharedPreferences.getInstance();
      userData.setString(
        'userData',
        json.encode({
          'token': x['token'],
          'type': x['type'],
        }),
      );
    }

    _onPressed() {
      setState(() {
        _pressed = true;
      });
      var _url = Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/login');
      http.post(_url, body: {
        'phone': _phoneNumber.text,
        'password': _password.text,
      }).then(
        (response) {
          var x = json.decode(response.body);
          if (response.statusCode == 200) {
            _shared(x);

            if (x['type'] == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => MainClientHome(token: x['token']),
                ),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => MainWorkerHome(token: x['token']),
                ),
              );
            }
          } else {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: const Text('Wrong log-in credentials'),
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
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _loading(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(0, 38, 113, 1),
                  ),
                );
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          padding: const EdgeInsets.all(15),
                          child: Image.asset('images/logo.png'),
                        ),
                        NormalTextField(
                          myColor: _myColor,
                          text: 'Phone Number',
                          controller: _phoneNumber,
                          icon: const Icon(Icons.phone_android),
                          keyboardType: TextInputType.number,
                        ),
                        PasswordTextField(
                          myColor: _myColor,
                          text: 'Password',
                          controller: _password,
                        ),
                        MyElevatedIcicatorButton(
                          myColor: _myColor,
                          text: 'Login',
                          onpressed: _onPressed,
                          pressed: _pressed,
                        ),
                        MyOutlinedButton(
                          fontsize: 24,
                          color: _myColor,
                          text: 'Signup',
                          onpressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _myColor,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
