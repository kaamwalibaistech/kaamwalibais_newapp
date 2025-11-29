import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<CreateOrderResponse?> createOrderApi(String amount) async {
  Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/createorder");
  final headers = {'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998'};
  final body = {
    // 'amount': "1",
    'amount': amount,
  };
  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data!['status'] == "200") {
        return CreateOrderResponse.fromJson(data);
      }
    }
  } catch (e) {
    EasyLoading.dismiss();
    // throw Exception(e);
  }
  return null;
}

class CreateOrderResponse {
  String? status;
  String? msg;
  String? orderId;
  int? amount;
  String? currency;

  CreateOrderResponse({
    this.status,
    this.msg,
    this.orderId,
    this.amount,
    this.currency,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      status: json['status'],
      msg: json['msg'],
      orderId: json['order_id'], // IMPORTANT
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}
