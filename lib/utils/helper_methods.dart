bool isDateExpired(String date) {
  DateTime givenDate = DateTime.parse(date
      .split('-')
      .reversed
      .join('-')); // Convert "dd-MM-yyyy" to "yyyy-MM-dd"
  DateTime currentDate = DateTime.now();

  return givenDate
      .isBefore(currentDate); // Returns true if the date has expired
}
