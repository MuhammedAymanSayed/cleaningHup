import 'package:flutter/material.dart';


class BestTechnicalsWidget extends StatelessWidget {
  const BestTechnicalsWidget({
    Key? key,
    required Color myColor,
    required var data,
  })  : _myColor = myColor,
        _data = data,
        super(key: key);

  final Color _myColor;
  final List _data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: _data.length,
        itemBuilder: (ctx, n) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 125,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: _myColor,
                ),
                child:const  Icon(Icons.person,size: 28,color: Colors.white,),
              ),
              Text(
                _data[n]['name'],
                style: TextStyle(fontWeight: FontWeight.bold, color: _myColor),
              ),
              // Text(
              //   _data[n]['user_service']['sub_category']['name_ar'],
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.blueAccent,
              //   ),
              // ),
              // MyOutlinedButton(
              //   text: 'Order Now',
              //   color: _myColor,
              //   onpressed: () {},
              //   fontsize: 14,
              // ),
            ],
          );
        },
      ),
    );
  }
}
