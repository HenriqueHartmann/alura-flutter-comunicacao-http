import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  const TransactionAuthDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: const TextField(
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 32, letterSpacing: 8),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () { print('cancel'); },
          child: const Text('Cancel'),
        ),
        TextButton(
            onPressed: () { print('confirm'); },
            child: const Text('Confirm'),
        ),
      ],
    );
  }
}
