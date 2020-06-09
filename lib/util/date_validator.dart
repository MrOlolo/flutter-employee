class DateValidator {
  static bool dateExist(String input) {
    final array = input.split('.');
    final date = DateTime.parse('${array[2]}${array[1]}${array[0]}');
    final originalFormatString = _toOriginalFormatString(date);
    print(date);
    return input == originalFormatString;
  }

  static String _toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$d.$m.$y";
  }
}
