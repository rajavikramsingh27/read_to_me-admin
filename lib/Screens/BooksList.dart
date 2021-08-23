
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:read_to_me/Global/Global.dart';
import 'package:read_to_me/Global/Constant.dart';
import 'package:read_to_me/Screens/BookDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BooksList extends StatefulWidget {
  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {

  List<Map<String, dynamic>> arrBooks = [];

  books() async {
    showLoader(context);
    var url = Uri.parse(kBaseURL+'books');
    final response = await http.get(
      url,
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      arrBooks = List<Map<String, dynamic>>.from(resbody);

      setState(() {

      });
    }
  }

  delete(String id) async {
    showLoader(context);

    final url = Uri.parse(kBaseURL+'books');
    final response = await http.delete(url, body: {'id' :id});

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      final mapResponse = Map<String, dynamic>.from(resbody);
      mapResponse['message'].toString().showMessage(context, false);

      books();
    } else {
      'Something Went Wrong With API'.showMessage(context, false);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 100), () {
      books();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor(bg_SecondColor),
        title: Text(
          'BOOKS LIST',
          style: TextStyle(
              fontFamily: kFontFamily
          ),
        ),
        actions: [
          IconButton(
            splashColor: Colors.red,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.add_box,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookDetails({})),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: arrBooks.length,
        padding: EdgeInsets.only(
          top: 16, bottom: 16,
            left: 16,right: 16
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 0,
          childAspectRatio: 0.52,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          height: 230,
                          child:
                          arrBooks[index]['thumbnail'].toString().showImage(),
                      )
                  ),
                  Positioned(
                    top: 5, right: 10,
                    child: Column(
                      children: [
                        IconButton(
                          splashColor: Colors.red,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookDetails(arrBooks[index])),
                            );
                          },
                        ),
                        IconButton(
                          splashColor: Colors.red,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            delete(arrBooks[index]['id']);
                          },
                        ),
                      ],
                    )
                  )
                ],
              ),
              SizedBox(
                height:16,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 10, right: 10
                ),
                child: Text(
                  arrBooks[index]['author'].toString(),
                  textAlign: TextAlign.left,
                  style:TextStyle(
                    color: HexColor(bg_BlueColor),
                    fontFamily: 'Times new roman',
                    fontSize: 23,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 10, right: 10
                ),
                child: Text(
                  arrBooks[index]['title'].toString(),
                  textAlign: TextAlign.left,
                  style:TextStyle(
                      fontSize: 20,
                      color: HexColor(bg_BlueColor),
                      fontFamily: 'Times new roman',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


