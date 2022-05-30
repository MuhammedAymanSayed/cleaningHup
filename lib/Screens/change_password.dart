import 'dart:convert';

import 'package:cleaning_hup/SingleWidgets/my_buttons.dart';
import 'package:cleaning_hup/SingleWidgets/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'main_client_home.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _passConfirmation = TextEditingController();

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    _onPressed() async{
      setState(() {
        _pressed = true;
      });
      var _url = Uri.parse(
          'https://cleaning.3m-erp.com/khadamaty/api/change-password');
      await http.post(_url, body: {
        'old_password': _oldPass.text,
        'new_password': _newPass.text,
        'confirm_new_password': _passConfirmation.text,
      },headers: {'Authorization': 'Bearer ' + widget.token}).then((response) {
        var x = json.decode(response.body);
        if (x['success'] == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MainClientHome(token: widget.token),
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: _myColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PasswordTextField(
                  myColor: _myColor,
                  text: 'Old password',
                  controller: _oldPass,
                ),
                PasswordTextField(
                  myColor: _myColor,
                  text: 'New password',
                  controller: _newPass,
                ),
                PasswordTextField(
                  myColor: _myColor,
                  text: 'Password confirmations',
                  controller: _passConfirmation,
                ),
                MyElevatedIcicatorButton(
                  myColor: _myColor,
                  text: 'Done',
                  onpressed: _onPressed,
                  pressed: _pressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
