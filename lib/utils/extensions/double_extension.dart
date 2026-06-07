extension DoubleExtension on double {
  String toAccuracyDescription() {
    if (this <= 0) {
      return "No Signal";
    } else if (this <= 5) {
      return "Excellent";
    } else if (this <= 15) {
      return "Good";
    } else if (this <= 50) {
      return "Fair";
    } else if (this <= 100) {
      return "Poor";
    } else {
      return "Very Poor (Unreliable Signal: >100m)";
    }
  }
}
