// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cleaning_hup/Screens/Worker/worker_deals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WorkerOrderScreen extends StatelessWidget {
  WorkerOrderScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  List _data = [];

  @override
  Widget build(BuildContext context) {
    const Color _myColor = Color.fromRGBO(0, 38, 113, 1);
    const Color _myColor2 = Color.fromRGBO(235, 235, 235, 1);
    Uri _url = Uri.parse(
        'https://cleaning.3m-erp.com/khadamaty/api/pending-orders?page=1');

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
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _data.length,
              itemBuilder: (ctx, n) {
                if (n % 3 == 0) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WorkerDeals(
                            token: token,
                            id: _data[n]['id'],
                          ),
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
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: _myColor2,
                                  ),
                                  Text(
                                    _data[n]['client']['name'],
                                    style: const TextStyle(color: _myColor2),
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
                                    Icons.star,
                                    color: _myColor2,
                                  ),
                                  Text(
                                    "Rating : " +
                                        _data[n]['client']['rate'].toString(),
                                    style: const TextStyle(color: _myColor2),
                                  ),
                                ],
                              ),
                            ],
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
                          builder: (_) => WorkerDeals(
                            token: token,
                            id: _data[n]['id'],
                          ),
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
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: _myColor,
                                  ),
                                  Text(
                                    _data[n]['client']['name'],
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
                                  Icon(
                                    Icons.star,
                                    color: _myColor,
                                  ),
                                  Text(
                                    "Rating : " +
                                        _data[n]['client']['rate'].toString(),
                                    style: TextStyle(color: _myColor),
                                  ),
                                ],
                              ),
                            ],
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
