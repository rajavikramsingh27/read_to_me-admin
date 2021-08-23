

import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:read_to_me/Global/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';



class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}



showLoader(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor:Colors.transparent,
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: LoadingBouncingLine.circle(
            size: 80.0,
            borderSize: 0,
            borderColor: Colors.transparent,
            backgroundColor: HexColor(bg_BlueColor),
            duration: Duration(seconds:1),
          ),
        );
      }
    );
}

Widget showLoader_1(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (ctx, snapshot) {
        return CircularProgressIndicator(
              semanticsLabel: 'Linear progress indicator',
              color: Colors.red,
              backgroundColor: Colors.blue,
            );
      }
    );
  }

extension MessageSnackBar on String {

  showMessage(context, bool isError) {
    Fluttertoast.showToast(
        msg: this,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  showImage() {
    return this.isNotEmpty
        ? Image(
      image: NetworkImage(this, ),
      fit: BoxFit.fill,
    ) : Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor(bg_BlueColor).withOpacity(0.2)
      ),
    ) ;
  }

  isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

}

