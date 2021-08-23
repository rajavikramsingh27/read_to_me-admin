

import 'package:flutter/material.dart';
import 'package:read_to_me/Global/Global.dart';
import 'package:read_to_me/Global/Constant.dart';
import 'package:read_to_me/Screens/Categories.dart';
import 'package:read_to_me/Screens/BooksList.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> listHomeOptions = [
    'Courses',
    'Books',
    'Category',
    'Geners', 
    'Difficulty'
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor(bg_SecondColor),
        title: Text(
          'HOME',
          style: TextStyle(
            fontFamily: kFontFamily
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(
              top: 16, bottom: 16
        ),
        itemCount: listHomeOptions.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.transparent,
            ),
            child: Container(
            decoration: BoxDecoration(
              color: HexColor(bg_BlueColor),
              borderRadius: BorderRadius.circular(4)
            ),
            padding: EdgeInsets.all(12),
            // margin: EdgeInsets.only(
            //   left: 20, right: 20
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listHomeOptions[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kFontFamily,
                    fontSize: 22
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  )
              ],
            ),
          ),
            onPressed: () {
              if (index == 0) {

              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BooksList()),
                );
              } else if (index == 2 || index == 3 || index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Categories(listHomeOptions[index])),
                  );
              }
            },
          );
       }, 

        separatorBuilder: (context, index) {
          return Container(height: 10,);
        } ,
        )
    );
  }
}
