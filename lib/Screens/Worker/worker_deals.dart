import 'package:cleaning_hup/Screens/main_worker_home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../SingleWidgets/my_buttons.dart';
import '../../SingleWidgets/my_textfield.dart';

class WorkerDeals extends StatefulWidget {
  const WorkerDeals({Key? key, required this.token, required this.id})
      : super(key: key);
  final String token;
  final int id;

  @override
  State<WorkerDeals> createState() => _WorkerDealsState();
}

class _WorkerDealsState extends State<WorkerDeals> {
  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);
  final TextEditingController _money = TextEditingController();

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      setState(() {
        _pressed = true;
      });
      var _url =
          Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/offer-deal');
      http.post(
        _url,
        headers: {'Authorization': 'Bearer ' + widget.token},
        body: {
          'order_id': widget.id.toString(),
          'total': _money.text,
        },
      ).then(
        (response) {
          if (response.statusCode == 200) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MainWorkerHome(token: widget.token),
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
                  text: 'Your offer',
                  controller: _money,
                  icon: const Icon(Icons.menu_rounded),
                  keyboardType: TextInputType.name,
                ),
                MyElevatedIcicatorButton(
                  myColor: _myColor,
                  text: 'Add Offer',
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
