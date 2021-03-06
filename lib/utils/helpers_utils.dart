int getNominalPerDay(int nominal, int periode, String durationType) {
  switch (durationType) {
    case 'Hari':
      return (nominal ~/ (periode * 1)).round();

    case 'Pekan':
      return (nominal ~/ (periode * 7)).round();

    case 'Bulan':
      return (nominal ~/ (periode * 30)).round();

    default:
      return (nominal ~/ (periode * 365)).round();
  }
}

String getPercent(int currentMoney, int nominal) {
  double result = (currentMoney * 100) / nominal;
  if (result >= 1) {
    return result.floor().toString();
  }
  return result.toStringAsFixed(1);
}

double getPercentDouble(int currentMoney, int nominal) {
  return currentMoney / nominal;
}

String generateZeroDigit(String nominal) {
  if (nominal.lastIndexOf('.') != -1) {
    return nominal.substring(0, nominal.lastIndexOf('.')) + ".000 / Hari";
  }
  return nominal + " / Hari";
}

String generateZeroDigitWithoutSuffix(String nominal) {
  if (nominal.lastIndexOf('.') != -1) {
    return nominal.substring(0, nominal.lastIndexOf('.')) + ".000";
  }
  return nominal;
}

String generatePeriodProgress(int startDate, int period, String durationType) {
  switch (durationType) {
    case 'Hari':
      double dayTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          1;
      return "$dayTh Hari / $period Hari";
    case 'Pekan':
      double weekTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          7;
      return "$weekTh Pekan / $period Pekan";
    case 'Bulan':
      double monthTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          30;
      return "$monthTh Bulan / $period Bulan";
    default:
      double yearTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          365;
      return "$yearTh Tahun / $period Tahun";
  }
}
