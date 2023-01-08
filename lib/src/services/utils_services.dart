import 'package:intl/intl.dart';

class UtilServices {
  static String priceToCurrency(double price) {
    final numberFormat = NumberFormat.simpleCurrency(locale: 'pt_br');
    return numberFormat.format(price);
  }
}
