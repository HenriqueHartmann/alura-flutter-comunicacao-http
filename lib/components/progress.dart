import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({this.message = 'Loading', Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message, style: const TextStyle(fontSize: 16.0)),
          )
        ],
      ),
    );
  }
}
