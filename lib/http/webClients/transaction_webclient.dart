import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:bytebank/http/web_client.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(endpoint + api))
        .timeout(const Duration(seconds: 5));

    // List<Transaction> transactions = _toTransactions(response);
    //
    // return transactions;

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((dynamic json) =>
        Transaction.fromJson(json)).toList();
  }

  // List<Transaction> _toTransactions(Response response) {
  //    final List<dynamic> decodedJson = jsonDecode(response.body);
  //
  //   final List<Transaction> transactions = [];
  //
  //   for (Map<String, dynamic> transactionJson in decodedJson) {
  //     final Transaction transaction = Transaction.fromJson(transactionJson);
  //     transactions.add(transaction);
  //   }
  //
  //    return transactions;
  // }

  Future<Transaction> save(Transaction transaction, String password) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);

    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(Uri.parse(endpoint + api),
        headers: {
          'content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      }
    };
    return transactionMap;
  }
}