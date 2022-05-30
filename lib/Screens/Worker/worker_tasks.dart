import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WorkerTasksScreen extends StatelessWidget {
  WorkerTasksScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  List _data = [];

  @override
  Widget build(BuildContext context) {
    const Color _myColor = Color.fromRGBO(0, 38, 113, 1);
    Uri _url = Uri.parse(
        'https://cleaning.3m-erp.com/khadamaty/api/show-all-technical-orders');

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
              return InkWell(
                onTap: (){
                  
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                padding:
                                    const EdgeInsets.fromLTRB(5, 2.5, 7.5, 2.5),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // const Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: CircleAvatar(radius: 25),
                                    // ),
                                    Column(
                                      children: [
                                        Text(
                                          _data[n]['client']['name'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        // Text(
                                        //   'address',
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     color: Colors.grey,
                                        //   ),
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              // const Text(
                              //   'data',
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  _data[n]['service']['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.map_rounded,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  _data[n]['address'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 32,
                          ),
                          Text(
                            _data[n]['total'] + ' L.E',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
