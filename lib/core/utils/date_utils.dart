class DateUtils {

  static const int FREE_TRIAL_DAYS = 14;

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static int remainingDaysFreeTrial(DateTime createdAt) {
    DateTime currentDate = DateTime.now();
    int remainingDays = currentDate.difference(createdAt).inDays;

    return FREE_TRIAL_DAYS - remainingDays;
  }

  static int remainingDaysOfSubscription(
    DateTime expiryDate,
    DateTime createdAt,
  ) {
    if (expiryDate == null) {
      return remainingDaysFreeTrial(createdAt);
    }
    DateTime currentDate = DateTime.now();
    int remainingDays = expiryDate.difference(currentDate).inDays;

    return remainingDays;
  }

  static bool hasSubscribed(DateTime expiryDate, DateTime createdAt) {
    int remainingDays = remainingDaysOfSubscription(expiryDate, createdAt);

    if (remainingDays < 0) {
      return false;
    }

    return true;
  }

  static bool isSubscribing(
      DateTime expiryDate, bool isVerified, DateTime createdAt) {
    if (hasSubscribed(expiryDate, createdAt)
        // && isVerified
        ) {
      return true;
    }

    return false;
  }
}
