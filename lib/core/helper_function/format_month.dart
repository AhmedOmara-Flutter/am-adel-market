String formatMonths(int months) {
  if (months < 12) {
    return months == 1 ? "1 شهر" : "$months شهور";
  }

  int years = months ~/ 12;
  int remainingMonths = months % 12;

  String yearText = years == 1 ? "عام" : "أعوام";
  String monthText =
  remainingMonths == 1 ? "شهر" : "شهور";

  if (remainingMonths == 0) {
    return "$years $yearText";
  }

  return "$years $yearText و $remainingMonths $monthText";
}