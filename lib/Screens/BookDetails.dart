

import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:read_to_me/Global/Global.dart';
import 'package:read_to_me/Global/Constant.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:firebase_storage/firebase_storage.dart';



class BookDetails extends StatefulWidget {
  Map<String, dynamic> mapBooksDetails;
  BookDetails(this.mapBooksDetails);


  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAuthor = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  String downloadUrl = '';

  List<Map<String, dynamic>> arrDifficulty = [];
  String strDifficulty = '';

  List<Map<String, dynamic>> arrCategory = [];
  String strCategory = '';

  List<Map<String, dynamic>> arrGeners = [];
  String strGeners = '';

  List<String> arrCollections = ['Collect 1', 'Collect 2'];
  String strCollections = '';

  List<String> arrShortStory = ['True', 'False'];
  String strShortStory = '';


  File? _image;
  final picker = ImagePicker();

  openCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
      uploadFile();
    });
  }

  openGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      uploadFile();
    });
  }

  Future<void> uploadFile() async {
    // showLoader(context);
    // final ref = FirebaseStorage.instance.ref().child('books/').child('books');
    // final uploadTask = ref.putFile(_image!);
    // final storageTaskSnapshot = await uploadTask.whenComplete(() => print('completing ... '))
    //     .catchError((error) {
    //       Navigator.pop(context);
    //       error.message.toString().showMessage(context, true);
    // });
    // Navigator.pop(context);
    // downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  }

  selectImage(context,) {
    showModalBottomSheet(
        backgroundColor:Colors.transparent,
        context: context,
        builder:(BuildContext bc) {
          return Container(
              height:280,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                    topRight:Radius.circular(20),
                    topLeft:Radius.circular(20)
                ),
              ),
              child:Center(
                child:Column(
                  children:<Widget>[
                    SizedBox(height:30),
                    Text(
                      'Please select an option',
                      style:TextStyle(
                          fontSize:18,
                          fontFamily:kFontFamily,
                          color:Colors.black,
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    SizedBox(height:10),
                    FlatButton(
                      child:Text(
                        'Camera',
                        style:TextStyle(
                            fontSize:20,
                            fontFamily:kFontFamily,
                            color:Colors.black,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openCamera();
                      },
                    ),
                    FlatButton(
                      child:Text(
                        'Gallery',
                        style:TextStyle(
                            fontSize:20,
                            fontFamily:kFontFamily,
                            color:Colors.black,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openGallery();
                      },
                    ),
                    SizedBox(height:30,),
                    FlatButton(
                      child:Text(
                        'Cancel',
                        style:TextStyle(
                            fontSize:20,
                            fontFamily:kFontFamily,
                            color:Colors.red,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  create() async {
    showLoader(context);
    final url = Uri.parse(kBaseURL+'books/create');
    final response = await http.post(url, body: {
      'thumbnail':downloadUrl,
      'title' : txtTitle.text,
      'author' : txtAuthor.text,
      'difficulty' : strDifficulty,
      'category' : strCategory,
      'geners' : strGeners,
      'collection' : strCollections,
      'short_story' : strShortStory,
      'description' : txtDescription.text,
    });

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      final mapResponse = Map<String, dynamic>.from(resbody);
      mapResponse['message'].toString().showMessage(context, false);
      Navigator.pop(context);
    } else {
      'Something Went Wrong With API'.showMessage(context, false);
    }
  }

  update(String id) async {
    showLoader(context);
    final url = Uri.parse(kBaseURL+'books');
    final response = await http.put(url, body: {
      'id' :id,
      'thumbnail':downloadUrl,
      'title' : txtTitle.text,
      'author' : txtAuthor.text,
      'difficulty' : strDifficulty,
      'category' : strCategory,
      'geners' : strGeners,
      'collection' : strCollections,
      'short_story' : strShortStory,
      'description' : txtDescription.text,
    });

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      final mapResponse = Map<String, dynamic>.from(resbody);
      mapResponse['message'].toString().showMessage(context, false);

      Navigator.pop(context);
    } else {
      'Something Went Wrong With API'.showMessage(context, false);
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

      Navigator.pop(context);
    } else {
      'Something Went Wrong With API'.showMessage(context, false);
    }
  }

  category() async {
    showLoader(context);
    final url = Uri.parse(kBaseURL+'category');
    final response = await http.get(url,);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      arrCategory = List<Map<String, dynamic>>.from(resbody);

      setState(() {

      });
    }
  }


  geners() async {
    showLoader(context);

    final url = Uri.parse(kBaseURL+'geners');
    final response = await http.get(url,);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      arrGeners = List<Map<String, dynamic>>.from(resbody);

      setState(() {

      });
    }
  }

  difficulty() async {
    showLoader(context);
    final url = Uri.parse(kBaseURL+'difficulty');
    final response = await http.get(url,);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final resbody = jsonDecode(response.body);
      arrDifficulty = List<Map<String, dynamic>>.from(resbody);

      setState(() {

      });
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 100), () {
      difficulty();
      category();
      geners();
    });

    if (widget.mapBooksDetails.isNotEmpty) {
      txtTitle.text = widget.mapBooksDetails['title'];
      txtAuthor.text = widget.mapBooksDetails['author'];
      strDifficulty = widget.mapBooksDetails['difficulty'];
      strCategory = widget.mapBooksDetails['category'];
      strGeners = widget.mapBooksDetails['geners'];
      strCollections = widget.mapBooksDetails['collection'];
      strShortStory = widget.mapBooksDetails['short_story'].toString();
      txtDescription.text = widget.mapBooksDetails['description'];
      downloadUrl = widget.mapBooksDetails['thumbnail'].toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor(bg_SecondColor),
        title: Text(
          'BOOKS DETAILS',
          style: TextStyle(
              fontFamily: kFontFamily
          ),
        ),
        actions: [
          widget.mapBooksDetails.isEmpty ? Container() : IconButton(
            splashColor: Colors.red,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              delete(widget.mapBooksDetails['id']);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20, right: 20,
          bottom: 40
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child:FlatButton(
                textColor:Colors.white,
                child:ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child:_image == null
                        ? Container(
                      height: 200,
                      width: double.infinity,
                      child: downloadUrl.showImage()
                    ) : Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.file(
                        _image!,
                        fit: BoxFit.fill,
                      ),
                    )
                ),
                onPressed:() {
                  selectImage(context);
                },
              ),
            ),
            SizedBox(height: 20,),
            TextField(
                controller: txtTitle,
                style: TextStyle(
                    fontFamily: kFontFamily,
                    color: Colors.black,
                    fontSize: 16
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: "Title",
                  labelStyle: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.black,
                      fontSize: 16
                  ),
                  hintText: "Enter a Title",
                  hintStyle: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.grey,
                      fontSize: 20
                  ),
                )
            ),
            SizedBox(height: 10,),
            TextField(
              controller: txtAuthor,
                style: TextStyle(
                    fontFamily: kFontFamily,
                    color: Colors.black,
                    fontSize: 16
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Author',
                  labelStyle: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.black,
                      fontSize: 16
                  ),
                  hintText: "Enter a Author",
                  hintStyle: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.grey,
                      fontSize: 20
                  ),
                )
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
                padding: EdgeInsets.only(
                    bottom: 6
                ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Difficulty',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: kFontFamily,
                            color: Colors.black,
                            fontSize: 12
                        ),
                      ),
                      DropdownButton(
                        dropdownColor: HexColor(bg_SecondColor),
                        isExpanded: false,
                        underline: Container(),
                        icon: Container(),
                        hint: strDifficulty.isEmpty ? Text(
                          '',
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 16
                          ),
                        ) : Text(
                          strDifficulty,
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 16
                          ),
                        ),
                        iconSize: 30.0,
                        style: TextStyle(
                            fontFamily: kFontFamily,
                            color: Colors.black,
                            fontSize: 16
                        ),
                        items: arrDifficulty.map((val) {
                          return DropdownMenuItem<String>(
                            value: val['title'],
                            child: Text(val['title'],
                              style: TextStyle(
                                  fontFamily: kFontFamily,
                                  color: Colors.white,
                                  fontSize: 16
                              ),
                            ),
                          );
                        },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                                () {
                              strDifficulty = val.toString();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 36,
                  )
                ],
              )
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    bottom: 6
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Geners',
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 13
                          ),
                        ),
                        DropdownButton(
                          dropdownColor: HexColor(bg_SecondColor),
                          isExpanded: false,
                          underline: Container(),
                          icon: Container(),
                          hint: strCategory.isEmpty ? Text(
                            '',
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ) : Text(
                            strCategory,
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ),
                          iconSize: 30.0,
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 16
                          ),
                          items: arrCategory.map((val) {
                            return DropdownMenuItem<String>(
                              value: val['title'],
                              child: Text(val['title'],
                                style: TextStyle(
                                    fontFamily: kFontFamily,
                                    color: Colors.white,
                                    fontSize: 16
                                ),
                              ),
                            );
                          },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                strCategory = val.toString();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                    )
                  ],
                )
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    bottom: 6
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Geners',
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 13
                          ),
                        ),
                        DropdownButton(
                          dropdownColor: HexColor(bg_SecondColor),
                          isExpanded: false,
                          underline: Container(),
                          icon: Container(),
                          hint: strGeners.isEmpty ? Text(
                            '',
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ) : Text(
                            strGeners,
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ),
                          iconSize: 30.0,
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 16
                          ),
                          items: arrGeners.map((val) {
                            return DropdownMenuItem<String>(
                              value: val['title'],
                              child: Text(val['title'],
                                style: TextStyle(
                                    fontFamily: kFontFamily,
                                    color: Colors.white,
                                    fontSize: 16
                                ),
                              ),
                            );
                          },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                strGeners = val.toString();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                    )
                  ],
                )
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    bottom: 6
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Collections',
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 13
                          ),
                        ),
                        DropdownButton(
                          dropdownColor: HexColor(bg_SecondColor),
                          isExpanded: false,
                          underline: Container(),
                          icon: Container(),
                          hint: strCollections.isEmpty ? Text(
                            '',
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ) : Text(
                            strCollections,
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ),
                          iconSize: 30.0,
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 16
                          ),
                          items: arrCollections.map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val,
                                style: TextStyle(
                                    fontFamily: kFontFamily,
                                    color: Colors.white,
                                    fontSize: 16
                                ),
                              ),
                            );
                          },
                          ).toList(),
                          onChanged: (val) {
                            setState(() {
                              strCollections = val.toString();
                            },
                            );
                          },
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                    )
                  ],
                )
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: 6
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Short Story',
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 13
                          ),
                        ),
                        DropdownButton(
                          dropdownColor: HexColor(bg_SecondColor),
                          isExpanded: false,
                          underline: Container(),
                          icon: Container(),
                          hint: strShortStory.isEmpty ? Text(
                            '',
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16
                            ),
                          ) : Text(
                            strShortStory,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.black,
                                fontSize: 16,

                            ),
                          ),
                          iconSize: 30.0,
                          style: TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.black,
                              fontSize: 16
                          ),
                          items: arrShortStory.map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val,
                                style: TextStyle(
                                    fontFamily: kFontFamily,
                                    color: Colors.white,
                                    fontSize: 16
                                ),
                              ),
                            );
                          },
                          ).toList(),
                          onChanged: (val) {
                            setState(() {
                              strShortStory = val.toString();
                            },
                            );
                          },
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                    )
                  ],
                )
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                )
              ),
              child: TextFormField(
                  controller: txtDescription,
                  maxLines: 10,
                  style: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.black,
                      fontSize: 16
                  ),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    labelText: "Description",
                    labelStyle: TextStyle(
                        fontFamily: kFontFamily,
                        color: Colors.black,
                        fontSize: 16
                    ),
                    hintText: "Enter a Description",
                    hintStyle: TextStyle(
                        fontFamily: kFontFamily,
                        color: Colors.grey,
                        fontSize: 20
                    ),
                  )
              ),
            ),
            SizedBox(height: 40,),
            Container(
              height: 54,
              width: 200,
              decoration: BoxDecoration(
                  color: HexColor(bg_SecondColor),
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
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  if (_image == null) {
                    'Select a picture'.showMessage(context, true);
                  } else if (txtTitle.text.isEmpty) {
                    'Select a title'.showMessage(context, true);
                  } else if (txtAuthor.text.isEmpty) {
                    'Select a author'.showMessage(context, true);
                  } else if (strDifficulty.toLowerCase() == 'difficulty') {
                    'Select a difficulty'.showMessage(context, true);
                  } else if (strCategory.toLowerCase() == 'category') {
                    'Select a category'.showMessage(context, true);
                  } else if (strGeners.toLowerCase() == 'geners') {
                    'Select a geners'.showMessage(context, true);
                  } else if (strCollections.toLowerCase() == 'collections') {
                    'Select a collections'.showMessage(context, true);
                  } else if (strShortStory.toLowerCase() == 'short story') {
                    'Select a short story'.showMessage(context, true);
                  } else if (txtDescription.text.isEmpty) {
                    'Write some description'.showMessage(context, true);
                  } else {
                    widget.mapBooksDetails.isEmpty ? create() : update(
                        widget.mapBooksDetails['id']
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}








/*
import 'dart:ui';

import 'package:alfa/utils/Constents.dart';
import 'package:flutter/material.dart';

import '../res.dart';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';



class ProfileScreenEdit extends StatefulWidget {
  @override
  _ProfileScreenEditState createState() => _ProfileScreenEditState();
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  var isMale = false;
  var isFemale = false;

  var dateOfBirth = 'Date of birth';
  File _image;
  final picker = ImagePicker();

  final textFirstName = TextEditingController();
  final textSecondName = TextEditingController();
  // final textLocation = TextEditingController();
  DateTime picked = null;

  Map<String,dynamic> dictUserDetails = {

  };

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _date = DateTime.now();
    picked = await showDatePicker(
      context: context,
      initialDate:_date,
      firstDate:DateTime(1970),
      lastDate:DateTime(2021),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data:ThemeData.light().copyWith(
//            primaryColor: const Color(0xFF8CE7F1),
//            accentColor: const Color(0xFF8CE7F1),
            colorScheme:ColorScheme.light(primary:HexColor('54C9AF')),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      print(picked);

      dateOfBirth = DateFormat('yyyy MMM dd').format(picked);
      setState(() {

      });
    } else {
      dateOfBirth = 'Date of birth';
    }

  }

  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
      _uploadFile();
    });
  }

  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      _uploadFile();
    });
  }

  Future<void> _uploadFile() async {
    showLoading(context);
    FirebaseAuth.instance.currentUser().then((value) async {
      var ref = FirebaseStorage.instance.ref().child('userProfilePicture/').child(value.email+kFireBaseConnect+value.uid);
      var uploadTask = ref.putFile(_image);
      var storageTaskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      Firestore.instance.collection(tblUserDetails).document(value.email+kFireBaseConnect+value.uid).updateData({
        kProfilePicture:downloadUrl
      }).then((value) {
        dismissLoading(context);
        Toast.show(
            'Profile picture updated', context,
            backgroundColor: HexColor(greenColor)
        );
      }).catchError((error) {
        Toast.show(
            error.message.toString(), context,
            backgroundColor: HexColor(redColor));
      });
    }).catchError((error) {
      Toast.show(
          error.message.toString(), context,
          backgroundColor: HexColor(redColor));
    });
  }

  _settingModalBottomSheet(context,) {
    showModalBottomSheet(
        backgroundColor:Colors.transparent,
        context: context,
        builder:(BuildContext bc) {
          return Container(
              height:280,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                    topRight:Radius.circular(20),
                    topLeft:Radius.circular(20)
                ),
//              border: Border.all(width:3,color: Colors.green,style: BorderStyle.solid)
              ),
              child:Center(
                child:Column(
                  children:<Widget>[
                    SizedBox(height:30),
                    Text(
                      'Please select an option',
                      style:TextStyle(
                          fontSize:18,
                          fontFamily:AppConstant.kPoppins,
                          color:AppConstant.color_blue_dark,
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    SizedBox(height:10),
                    FlatButton(
                      child:Text(
                        'Camera',
                        style:TextStyle(
                            fontSize:16,
                            fontFamily:AppConstant.kPoppins,
                            color:AppConstant.color_blue_dark,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openCamera();
                      },
                    ),
                    FlatButton(
                      child:Text(
                        'gallery',
                        style:TextStyle(
                            fontSize:16,
                            fontFamily:AppConstant.kPoppins,
                            color:AppConstant.color_blue_dark,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openGallery();
                      },
                    ),
                    SizedBox(height:30,),
                    FlatButton(
                      child:Text(
                        'Cancel',
                        style:TextStyle(
                            fontSize:18,
                            fontFamily:AppConstant.kPoppins,
                            color:Colors.red,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds:1),() {
      showLoading(context);
      FirebaseAuth.instance.currentUser().then((value) {
        Firestore.instance.collection(tblUserDetails).document(
            value.email + kFireBaseConnect + value.uid).get().then((value) {
          dismissLoading(context);
          dictUserDetails = value.data;
          setState(() {
            textFirstName.text = dictUserDetails[kFirstName];
            textSecondName.text = dictUserDetails[kLastName];
            // textLocation.text = dictUserDetails[kLocation];
            dateOfBirth = dictUserDetails[kDateOfBirth];

            isMale = (dictUserDetails[kGender] == 'Male') ? true : false;
            isFemale = (dictUserDetails[kGender] == 'Female') ? true : false;

            Future.delayed(Duration(milliseconds:5),() {
              // _image = File(dictUserDetails[kProfilePicture]);
            });
          });
        }).catchError((error) {
          dismissLoading(context);
          Toast.show(
              error.message.toString(),
              context,
              backgroundColor: HexColor(redColor)
          );
        }).catchError((error) {
          dismissLoading(context);
          Toast.show(
              error.message.toString(),
              context,
              backgroundColor: HexColor(redColor)
          );
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,
        appBar:AppBar(
            title:Text(
              'Edit Profile',
              style:TextStyle(
                  fontSize:18,
                  fontFamily:AppConstant.kPoppins,
                  color:AppConstant.color_blue_dark,
                  fontWeight:FontWeight.bold
              ),
            ),
            textTheme:TextTheme(
                title: TextStyle(
                    color: Colors.black
                )
            ),
            centerTitle:false,
            backgroundColor:Colors.white,
            brightness:Brightness.light,
            elevation:0.5,
            leading:IconButton(
                icon:Icon(
                  Icons.arrow_back,
                  color:Colors.black,
                  size:30,
                ),
                onPressed:() {
                  Navigator.pop(context);
                })
        ),
        body:Container(
          margin:EdgeInsets.only(left:30,right:30),
          child:SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child:Column(
              children: <Widget>[
                SizedBox(height:30,),
                Center(
                  child:FlatButton(
                    textColor:Colors.white,
                    child:ClipRRect(
                        borderRadius:BorderRadius.circular(83),
                        child:_image == null ? FadeInImage(
                          fit:BoxFit.fill,
                          height:90,
                          width:90,
                          image:NetworkImage(
                              dictUserDetails[kProfilePicture].toString()
                          ),
                          placeholder:AssetImage(Res.ic_profile),
                        ) : CircleAvatar(
                          radius:45,
                          backgroundImage:FileImage(_image),
                        )
                    ),
                    onPressed:() {
                      _settingModalBottomSheet(context);
                    },
                  ),
                ),
                SizedBox(height:40,),
                TextField(
                  controller:textFirstName,
                  cursorColor:Color(0xff84828F),
                  decoration:InputDecoration(
                    //labelText: title ,  // you can change this with the top text  like you want
                      labelText: "First name",
                      hintStyle:TextStyle(
                          fontFamily:AppConstant.kPoppins,
                          fontWeight:FontWeight.normal,
                          fontSize:15
                      ),
                      /*border: InputBorder.none,*/
                      fillColor: Color(0xff84828F)
                  ),
                ),
                SizedBox(height:16),
                TextField(
                  controller:textSecondName,
                  cursorColor:Color(0xff84828F),
                  decoration:InputDecoration(
                    //labelText: title ,  // you can change this with the top text  like you want
                      labelText: "Last name",
                      hintStyle:TextStyle(
                          fontFamily:AppConstant.kPoppins,
                          fontWeight:FontWeight.normal,
                          fontSize:15
                      ),
                      /*border: InputBorder.none,*/
                      fillColor: Color(0xff84828F)
                  ),
                ),
                SizedBox(height:16),
                // TextField(
                //   controller:textLocation,
                //   cursorColor:Color(0xff84828F),
                //   decoration:InputDecoration(
                //     //labelText: title ,  // you can change this with the top text  like you want
                //       labelText: "Location",
                //       hintStyle:TextStyle(
                //           fontFamily:AppConstant.kPoppins,
                //           fontWeight:FontWeight.normal,
                //           fontSize:15
                //       ),
                //       /*border: InputBorder.none,*/
                //       fillColor: Color(0xff84828F)
                //   ),
                // ),
                // SizedBox(height:16),
                Container(
                    alignment:Alignment.centerLeft,
                    width:MediaQuery.of(context).size.width,
//                color:Colors.red,
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          padding:EdgeInsets.all(0),
                          child:Text(
                            dateOfBirth,
                            style:TextStyle(
                                color:Colors.black,
                                fontFamily:AppConstant.kPoppins,
                                fontWeight:FontWeight.normal,
                                fontSize:15
                            ),
                          ),
                          onPressed:() {
                            _selectDate(context);
                          },
                        ),
                        Container(
                          height:1,
                          color:HexColor('84828F'),
                        )
                      ],
                    )
                ),
                SizedBox(height:30),
                Container(
                  width:MediaQuery.of(context).size.width,
                  alignment:Alignment.centerLeft,
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Gender',
                        style:TextStyle(
                            fontFamily:AppConstant.kPoppins,
                            fontWeight:FontWeight.normal,
                            fontSize:15
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            padding:EdgeInsets.only(left: 0),
                            textColor:Colors.white,
                            child:Row(
                              children: <Widget>[
                                Image.asset(
                                  isMale ? Res.ic_male : Res.maleUnselectet,
                                  height:40,
                                ),
                                SizedBox(width:16),
                                Text(
                                  'Male',
                                  style:TextStyle(
                                      color:HexColor('#000000'),
                                      fontFamily:AppConstant.kPoppins,
                                      fontWeight:FontWeight.normal,
                                      fontSize:16
                                  ),
                                )
                              ],
                            ),
                            onPressed:(){
                              setState(() {
                                isMale = true;
                                isFemale = false;
                              });
                            },
                          ),
                          FlatButton(
                            textColor:Colors.white,
                            child:Row(
                              children: <Widget>[
                                Image.asset(
                                  isFemale ? Res.ic_female : Res.femaleUnselected,
//                                Res.femaleUnselected,
                                  height:40,
                                ),
                                SizedBox(width:16),
                                Text(
                                  'Female',
                                  style:TextStyle(
                                      color:HexColor('#000000'),
                                      fontFamily:AppConstant.kPoppins,
                                      fontWeight:FontWeight.normal,
                                      fontSize:16
                                  ),
                                )
                              ],
                            ),
                            onPressed:(){
                              setState(() {
                                isMale = false;
                                isFemale = true;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height:60),
                Container(
                  height:56,
                  width:MediaQuery.of(context).size.width,
                  decoration:kButtonThemeGradientColor(),
                  child:FlatButton(
                    padding:EdgeInsets.all(0),
                    child:Text(
                      'Update',
                      style:TextStyle(
                          color:Colors.white,
                          fontFamily:AppConstant.kPoppins,
                          fontWeight:FontWeight.normal,
                          fontSize:18
                      ),
                    ),
                    onPressed:() {
                      if (_image == null) {
                        Toast.show('Select profile picture', context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            backgroundColor: HexColor(redColor));
                      } else if (textFirstName.text.isEmpty) {
                        Toast.show('Enter first name', context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            backgroundColor: HexColor(redColor));
                      } else if (textSecondName.text.isEmpty) {
                        Toast.show('Enter second name', context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            backgroundColor: HexColor(redColor));
                      }

                      // else if (textLocation.text.isEmpty) {
                      //   Toast.show('Select your location', context,
                      //       duration: 2,
                      //       gravity: Toast.BOTTOM,
                      //       backgroundColor: HexColor(redColor));
                      // }

                      else if (dateOfBirth == 'Date of birth') {
                        Toast.show('Select date of birth', context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            backgroundColor: HexColor(redColor));
                      } else if (!isMale && !isFemale) {
                        Toast.show('Select your gender', context,
                            duration: 2,
                            gravity: Toast.BOTTOM,
                            backgroundColor: HexColor(redColor));
                      } else {
                        showLoading(context);
                        FirebaseAuth.instance.currentUser().then((value) {
                          Firestore.instance.collection(tblUserDetails).document(value.email+kFireBaseConnect+value.uid).updateData({
                            kFirstName:textFirstName.text,
                            kLastName:textSecondName.text,
                            kLocation:'',
                            // textLocation.text,
                            kDateOfBirth:dateOfBirth,
                            kGender:isMale ? 'Male' : 'Female'
                          }).then((value) {
                            dismissLoading(context);
                            Toast.show(
                                'Updated!',
                                context,
                                duration:2,
                                gravity:Toast.BOTTOM,
                                backgroundColor:HexColor(greenColor));
                          }).catchError((error) {
                            dismissLoading(context);
                            Toast.show(
                                error.message.toString(),
                                context,
                                duration:2,
                                gravity:Toast.BOTTOM,
                                backgroundColor:HexColor(redColor));
                          });
                        }).catchError((error) {
                          dismissLoading(context);
                          Toast.show(
                              error.message.toString(),
                              context,
                              duration:2,
                              gravity:Toast.BOTTOM,
                              backgroundColor:HexColor(redColor));
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height:30),
              ],
            ),
          ),
        )
    );
  }

}

/*
child:Container(
                                    margin:EdgeInsets.only(top:30),
                                    height:166,
                                    width:166,
                                    decoration:BoxDecoration(
                                      color:Colors.white,
                                      borderRadius:BorderRadius.circular(83),
                                      boxShadow:[
                                        BoxShadow(
                                          color:Colors.grey.withOpacity(0.5),
                                          spreadRadius:2,
                                          blurRadius:10,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    child:
                                    _image == null
                                        ? Image.asset(userPerson, height:90, width:90,)
                                        : CircleAvatar(backgroundImage:FileImage(_image), radius:45.0),
                                  ),
 */


 */