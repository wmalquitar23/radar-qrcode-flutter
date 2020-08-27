import 'package:intl/intl.dart';

class StringUtils {
  static String filterMobileNumberAddPrefix(String mobileNumber) {
    return "63" + mobileNumber;
  }

  static DateTime convertDateFromString(String strDate) {
    var _dateFormatter = new DateFormat('MM/dd/yyyy');
    return _dateFormatter.parse(strDate);
  }
}
