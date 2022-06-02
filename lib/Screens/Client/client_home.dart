import 'dart:convert';

import 'package:cleaning_hup/Screens/Client/client_sub_category.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../SingleWidgets/best_tech_widget.dart';
import '../../SingleWidgets/category_widget.dart';
import '../../SingleWidgets/my_offer.dart';

// ignore: must_be_immutable
class ClientHome extends StatelessWidget {
  ClientHome({Key? key, required this.token}) : super(key: key);
  final String token;
  var _sliderData = {};
  var _categoriesData = {};
  var _bestTechData = {};

  final Color _myColor = const Color.fromRGBO(0, 38, 113, 1);

  @override
  Widget build(BuildContext context) {
    Uri _sliderUrl =
        Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/slider');
    Uri _categoriesUrl =
        Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/categories');
        // Uri.parse(
        //     'https://cleaning.3m-erp.com/khadamaty/api/all-sub-categories/2');
    Uri _bestTechUrl =
        Uri.parse('https://cleaning.3m-erp.com/khadamaty/api/best-technicals');

    _loading() async {
      await http
          .get(_sliderUrl, headers: {'Authorization': 'Bearer ' + token}).then(
        (response) {
          _sliderData = json.decode(response.body);
        },
      );
      await http.get(_categoriesUrl,
          headers: {'Authorization': 'Bearer ' + token}).then(
        (response) {
          _categoriesData = json.decode(response.body);
        },
      );
      await http.get(_bestTechUrl,
          headers: {'Authorization': 'Bearer ' + token}).then(
        (response) {
          _bestTechData = json.decode(response.body);
        },
      );
    }

    return FutureBuilder(
        future: _loading(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: _myColor,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (_sliderData['data'].isNotEmpty)
                    MyOffer(myColor: _myColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Five stars Rate',
                        style: TextStyle(
                          color: _myColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  BestTechnicalsWidget(
                    myColor: _myColor,
                    data: _bestTechData['data'],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style: TextStyle(
                          color: _myColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.of(context)
                  //             .push(MaterialPageRoute(builder: (_) {
                  //           return const ClientSubCategory();
                  //         }));
                  //       },
                  //       child: MyCategoryWidget(
                  //         myColor: _myColor,
                  //         child: const Icon(
                  //           Icons.person,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //     MyCategoryWidget(
                  //       myColor: _myColor,
                  //       child: const Icon(
                  //         Icons.account_balance_outlined,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     MyCategoryWidget(
                  //       myColor: _myColor,
                  //       child: const Icon(
                  //         Icons.sentiment_neutral,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // )
                  if (MediaQuery.of(context).orientation ==
                      Orientation.landscape)
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: _categoriesData['data'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, n) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return ClientSubCategory(
                                  token: token,
                                  id: _categoriesData['data'][n]['id'],
                                );
                              }));
                            },
                            child: MyCategoryWidget(
                              myColor: _myColor,
                              child: Text(
                                _categoriesData['data'][n]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  if (MediaQuery.of(context).orientation ==
                      Orientation.portrait)
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                        itemCount: _categoriesData['data'].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (ctx, n) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return ClientSubCategory(
                                  token: token,
                                  id: _categoriesData['data'][n]['id'],
                                );
                              }));
                            },
                            child: MyCategoryWidget(
                              myColor: _myColor,
                              child: Text(
                                _categoriesData['data'][n]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }
        });
  }
}
