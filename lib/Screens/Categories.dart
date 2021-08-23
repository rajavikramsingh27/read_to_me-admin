
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_to_me/Global/Global.dart';
import 'package:read_to_me/Global/Constant.dart';
import 'package:read_to_me/Screens/Categories.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class Categories extends StatefulWidget {
  String strType;

  Categories(this.strType);
  
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  TextEditingController txtTitle = TextEditingController();
  bool isCreate = true;

  List<Map<String, dynamic>> listHomeOptions = [];

  getList() async {
    showLoader(context);

    String endPointAPI = '';

    if (widget.strType.toLowerCase() == 'category'.toLowerCase()) {
      endPointAPI = 'category';
    } else if (widget.strType.toLowerCase() == 'geners'.toLowerCase()) {
      endPointAPI = 'geners';
    } else if (widget.strType.toLowerCase() == 'difficulty'.toLowerCase()) {
      endPointAPI = 'difficulty';
    }

    print(kBaseURL+endPointAPI);
    final url = Uri.parse(kBaseURL+endPointAPI);
    final response = await http.get(url,);
    print(response.body);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      listHomeOptions = List<Map<String, dynamic>>.from(resbody);

      setState(() {

      });
    }
  }

  create() async {
    showLoader(context);

    String endPointAPI = '';

    if (widget.strType.toLowerCase() == 'category'.toLowerCase()) {
      endPointAPI = 'category/create';
    } else if (widget.strType.toLowerCase() == 'geners'.toLowerCase()) {
      endPointAPI = 'geners/create';
    } else if (widget.strType.toLowerCase() == 'difficulty'.toLowerCase()) {
      endPointAPI = 'difficulty/create';
    }

    print(kBaseURL+endPointAPI);
    final url = Uri.parse(kBaseURL+endPointAPI);
    final response = await http.post(url, body: {'title' : txtTitle.text});

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      final mapResponse = Map<String, dynamic>.from(resbody);
      mapResponse['message'].toString().showMessage(context, false);

      getList();
    }
  }

  update(String id) async {
    showLoader(context);

    String endPointAPI = '';

    if (widget.strType.toLowerCase() == 'category'.toLowerCase()) {
      endPointAPI = 'category';
    } else if (widget.strType.toLowerCase() == 'geners'.toLowerCase()) {
      endPointAPI = 'geners';
    } else if (widget.strType.toLowerCase() == 'difficulty'.toLowerCase()) {
      endPointAPI = 'difficulty';
    }

    print(kBaseURL+endPointAPI);
    final param = {'id': id, 'title': txtTitle.text};
    final url = Uri.parse(kBaseURL+endPointAPI);
    final response = await http.put(url, body: param);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      final mapResponse = Map<String, dynamic>.from(resbody);
      mapResponse['message'].toString().showMessage(context, false);

      getList();
    }
  }

  delete(String id) async {
    showLoader(context);

    String endPointAPI = '';

    if (widget.strType.toLowerCase() == 'category'.toLowerCase()) {
      endPointAPI = 'category';
    } else if (widget.strType.toLowerCase() == 'geners'.toLowerCase()) {
      endPointAPI = 'geners';
    } else if (widget.strType.toLowerCase() == 'difficulty'.toLowerCase()) {
      endPointAPI = 'difficulty';
    }

    final url = Uri.parse(kBaseURL+endPointAPI);
    final response = await http.delete(url, body: {'id' :id});

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      final mapResponse = Map<String, dynamic>.from(resbody);
      mapResponse['message'].toString().showMessage(context, false);

      getList();
    }
  }

  categoryPopUp(String id) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
              left: 16, right: 16
          ),
          padding: EdgeInsets.only(
              left: 10, right: 10
          ),
          decoration: BoxDecoration(
            color: HexColor(bg_SecondColor),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextField(
                controller: txtTitle,
                  style: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.white,
                      fontSize: 16
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Title",
                    labelStyle: TextStyle(
                        fontFamily: kFontFamily,
                        color: Colors.white,
                        fontSize: 16
                    ),
                    hintText: "Enter a Title",
                    hintStyle: TextStyle(
                        fontFamily: kFontFamily,
                        color: Colors.white,
                        fontSize: 20
                    ),
                  )
              ),
              SizedBox(height: 40,),
              Container(
                height: 54,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: kFontFamily,
                        color: Colors.black,
                        fontSize: 20
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                    isCreate ? create() : update(id);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.strType);
    Future.delayed(Duration(microseconds: 100), () {
      getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: HexColor(bg_SecondColor),
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
                isCreate = true;
                categoryPopUp('noNeedId');
              },
            ),
          ],
          title: Text(
            widget.strType,
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
            return Container(
              decoration: BoxDecoration(
                  color: HexColor(bg_BlueColor),
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(
                  left: 16,
                  // right: 16,
                  top: 5, bottom: 5
              ),
              margin: EdgeInsets.only(
                  left: 20, right: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listHomeOptions[index]['title'],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: kFontFamily,
                        fontSize: 20
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        splashColor: Colors.red,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          isCreate = false;
                          categoryPopUp(listHomeOptions[index]['id'].toString());
                        },
                      ),
                      IconButton(
                        splashColor: Colors.red,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          delete(listHomeOptions[index]['id'].toString());
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },

          separatorBuilder: (context, index) {
            return Container(height: 10,);
          },
        )
    );
  }
}


