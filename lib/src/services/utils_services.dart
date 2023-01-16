import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilServices {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveLocalData({
    required String key,
    required String data,
  }) async {
    await _storage.write(
      key: key,
      value: data,
    );
  }

  static Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',').last;
    return base64.decode(base64String);
  }

  static Future<String?> getLocalData({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> removeLocalData({required String key}) async {
    await _storage.delete(key: key);
  }

  static String priceToCurrency(double price) {
    final numberFormat = NumberFormat.simpleCurrency(locale: 'pt_br');
    return numberFormat.format(price);
  }

  static String dateTimeFormatter(DateTime date) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(date);
  }

  static void showToast({required String title, bool isError = false}) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14.0,
    );
  }
}
