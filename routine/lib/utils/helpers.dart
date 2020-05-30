import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String message,
  Function handler,
}) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      if (handler != null) handler();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [okButton],
  );

  showDialog(context: context, builder: (BuildContext context) => alert);
}
