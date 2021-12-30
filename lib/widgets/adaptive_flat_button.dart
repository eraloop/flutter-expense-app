import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class AdaptiveFlatButton extends StatelessWidget {

  final String text;
  final void Function() handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?  CupertinoButton(
        child: Text(text,
          style:const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: handler,
      )
      :
      // ignore: deprecated_member_use
      FlatButton(
          onPressed: handler,
          textColor: Theme.of(context).primaryColor,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
  }
}