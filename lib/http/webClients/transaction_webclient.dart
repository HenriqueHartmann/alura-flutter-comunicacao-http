import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:bytebank/http/web_client.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(endpoint + api));

    // List<Transaction> transactions = _toTransactions(response);
    //
    // return transactions;

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
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

    await Future.delayed(const Duration(seconds: 10));

    final Response response = await client.post(Uri.parse(endpoint + api),
        headers: {
          'content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode]!;
    }

    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
    409: 'Transaction already exists',
  };

  void _throwHttpError(int statusCode) =>
      throw Exception(_statusCodeResponses[statusCode]);

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

class HttpException implements Exception {
  HttpException(this.message);

  final String message;
}
