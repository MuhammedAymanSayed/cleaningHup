import 'dart:convert';

import 'package:cleaning_hup/Screens/Client/client_deals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ClientOrdersScreen extends StatelessWidget {
  ClientOrdersScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  final List _data = [];
  int x = 1;

  @override
  Widget build(BuildContext context) {
    const Color _myColor = Color.fromRGBO(0, 38, 113, 1);
    const Color _myColor2 = Color.fromRGBO(235, 235, 235, 1);
    Uri _url = Uri.parse(
        'https://cleaning.3m-erp.com/khadamaty/api/show-all-client-orders?page=$x');

    // _loading() async {
    //   await http.get(_url, headers: {'Authorization': 'Bearer ' + token}).then(
    //     (response) {
    //       _data = json.decode(response.body)['data'];
    //     },
    //   );
    // }

    _loading() async {
      await http.get(_url, headers: {'Authorization': 'Bearer ' + token}).then(
        (response) {
          for (var i = 0; i < json.decode(response.body)['total']; i++) {
            _data.add(json.decode(response.body)['data'][i]);
            x++;
          }
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
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _data.length,
              itemBuilder: (ctx, n) {
                if (n % 3 == 0) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => ClientDeals(
                                token: token,
                                id: _data[n]['id'].toString(),
                              )),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: _myColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.settings,
                                    color: _myColor2,
                                  ),
                                  Text(
                                    'Service',
                                    style: TextStyle(color: _myColor2),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: _myColor2,
                                  ),
                                  Text(
                                    _data[n]['date'],
                                    style: const TextStyle(color: _myColor2),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: _myColor2,
                                  ),
                                  Text(
                                    _data[n]['service']['name'],
                                    style: const TextStyle(color: _myColor2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.notifications,color: Colors.white,)
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.greenAccent,
                              ),
                              Text(
                                _data[n]['order_type']['type'] + ' service',
                                style:
                                    const TextStyle(color: Colors.greenAccent),
                              ),
                              Text(
                                _data[n]['total'] + ' L.E',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _myColor2,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => ClientDeals(
                                token: token,
                                id: _data[n]['id'].toString(),
                              )),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: _myColor2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.settings,
                                    color: _myColor,
                                  ),
                                  Text(
                                    'Services',
                                    style: TextStyle(color: _myColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: _myColor,
                                  ),
                                  Text(
                                    _data[n]['date'],
                                    style: const TextStyle(color: _myColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    color: _myColor,
                                  ),
                                  Text(
                                    _data[n]['service']['name'],
                                    style: const TextStyle(color: _myColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.notifications,color: Colors.white,)
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                _data[n]['order_type']['type'] + ' service',
                                style:
                                    const TextStyle(color: Colors.blueAccent),
                              ),
                              Text(
                                _data[n]['total'] + ' L.E',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _myColor,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        });
  }
}
