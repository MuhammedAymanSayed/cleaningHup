import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ClientDeals extends StatelessWidget {
  ClientDeals({Key? key, required this.token, required this.id})
      : super(key: key);
  final String token;
  final String id;
  List _data = [];

  @override
  Widget build(BuildContext context) {
    Uri _url = Uri.parse(
        'https://cleaning.3m-erp.com/khadamaty/api/order-deals?order_id=$id');
    const Color _myColor = Color.fromRGBO(0, 38, 113, 1);

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
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       Uri _url2 = Uri.parse(
        //           'https://cleaning.3m-erp.com/khadamaty/api/cancel-order');
        //       await http.post(
        //         _url2,
        //         body: {'order_id': id.toString(),'reason':'my reasons0'},
        //         headers: {'Authorization': 'Bearer ' + token},
        //       ).then((value) => print(value.body));
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (_) => MainClientHome(token: token),
        //         ),
        //       );
        //     },
        //     icon: const Icon(
        //       Icons.delete,
        //       color: _myColor,
        //     ),
        //   ),
        // ],
      ),
      body: FutureBuilder(
        future: _loading(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: _myColor,
              ),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _data.length,
                itemBuilder: (ctx, n) {
                  return InkWell(
                    onTap: () async {
                      Uri _url = Uri.parse(
                          'https://cleaning.3m-erp.com/khadamaty/api/accept-technical-deal');
                      http.post(_url, headers: {
                        'Authorization': 'Bearer ' + token
                      }, body: {
                        'deal_id': _data[n]['id'].toString(),
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _myColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    _data[n]['technical']['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone_android,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    _data[n]['technical']['phone'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Text(
                            'Offer : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.blueAccent,
                            ),
                            child: Text(
                              _data[n]['total'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
