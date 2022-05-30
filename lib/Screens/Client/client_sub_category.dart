import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ClientSubCategory extends StatelessWidget {
  ClientSubCategory({Key? key, required this.token}) : super(key: key);
  final String token;

  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);
  var _data = [];

  @override
  Widget build(BuildContext context) {
    Uri _url = Uri.parse(
        'https://cleaning.3m-erp.com/khadamaty/api/all-sub-categories/2');

    _loading() async {
      await http.get(_url, headers: {'Authorization': 'Bearer ' + token}).then(
        (response) {
          _data = json.decode(response.body)['data'];
        },
      );
    }

    return Scaffold(
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
              if (data.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: _myColor,
                  ),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Technicals',
                          style: TextStyle(
                            color: _myColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GridView.builder(
                          itemCount: _data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (ctx, n) {
                            return Container(
                              width: 150,
                              height: 150,
                              child: Center(
                                child: Text(
                                  _data[n]['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              margin: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                color: _myColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
            }));
  }
}
