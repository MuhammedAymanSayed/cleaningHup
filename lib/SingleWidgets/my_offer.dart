import 'package:flutter/material.dart';

class MyOffer extends StatefulWidget {
  const MyOffer({
    Key? key,
    required Color myColor,
  })  : _myColor = myColor,
        super(key: key);

  final Color _myColor;

  @override
  State<MyOffer> createState() => _MyOfferState();
}

class _MyOfferState extends State<MyOffer> {
  int y = 0;

  Color myColor(int x) {
    if (x == y) {
      return widget._myColor;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (x) {
              setState(() {
                y = x;
              });
            },
            children: [
              MyOfferContainer(myColor: widget._myColor),
              const MyOfferContainer(myColor: Colors.red),
              const MyOfferContainer(myColor: Colors.blue),
              const MyOfferContainer(myColor: Colors.cyanAccent),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(2.5),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: CircleAvatar(
                      backgroundColor: y == 0 ? widget._myColor : Colors.grey,
                      radius: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: CircleAvatar(
                      backgroundColor: y == 1 ? widget._myColor : Colors.grey,
                      radius: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: CircleAvatar(
                      backgroundColor: y == 2 ? widget._myColor : Colors.grey,
                      radius: 5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: CircleAvatar(
                      backgroundColor: y == 3 ? widget._myColor : Colors.grey,
                      radius: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyOfferContainer extends StatelessWidget {
  const MyOfferContainer({
    Key? key,
    required Color myColor,
  })  : _myColor = myColor,
        super(key: key);

  final Color _myColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 20,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _myColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        color: _myColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'Sorry my back-end developer didnt but any data in the api',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
