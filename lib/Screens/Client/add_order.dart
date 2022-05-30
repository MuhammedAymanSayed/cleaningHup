import 'package:cleaning_hup/Screens/main_client_home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../SingleWidgets/my_buttons.dart';
import '../../SingleWidgets/my_textfield.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key, required this.token, required this.id})
      : super(key: key);
  final String token;
  final int id;

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);
  final TextEditingController _description = TextEditingController();
  final TextEditingController _location = TextEditingController();

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    String _date = DateTime.now().toString();
    String _time = DateTime.now().hour.toString();
    _onPressed() {
      setState(() {
        _pressed = true;
      });
      var _url =
          Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/request-order');
      http.post(
        _url,
        headers: {'Authorization': 'Bearer ' + widget.token},
        body: {
          'service_id': (1).toString(),
          'sub_category_id': widget.id.toString(),
          'date': _date,
          'time': _time,
          'notes': _description.text,
          'address': _location.text,
          'lat': '29.1931',
          'long': '29.1931',
          'payment_type_id': '1',
        },
      ).then(
        (response) {
          if (response.statusCode == 200) {
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
                    content: const Text('Something Worng'),
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
        body: Center(
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
                  text: 'Description',
                  controller: _description,
                  icon: const Icon(Icons.menu_rounded),
                  keyboardType: TextInputType.name,
                ),
                NormalTextField(
                  myColor: _myColor,
                  text: 'Location',
                  controller: _location,
                  icon: const Icon(Icons.location_on),
                  keyboardType: TextInputType.name,
                ),
                MyElevatedIcicatorButton(
                  myColor: _myColor,
                  text: 'Add Order',
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
