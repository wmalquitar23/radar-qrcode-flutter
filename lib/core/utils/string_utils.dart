import 'package:intl/intl.dart';

class StringUtils {
  
  static bool isValidEmail(String email) {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+"
            r"(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*"
            r"@(?:[A-z0-9](?:[A-z0-9-]*[A-z0-9])?\.)+"
            r"[A-z0-9]"
            r"(?:[A-z0-9-]*[A-z0-9])?",
            caseSensitive: false)
        .hasMatch(email);
  }
  
  static String filterMobileNumberAddPrefix(String mobileNumber) {
    return "63" + mobileNumber;
  }

  static DateTime convertDateFromString(String strDate) {
    var _dateFormatter = new DateFormat('MM/dd/yyyy');
    return _dateFormatter.parse(strDate);
  }
}
