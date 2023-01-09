import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilServices {
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
