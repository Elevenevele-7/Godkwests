import 'package:intl/intl.dart';

final _whole = NumberFormat('#,##0');

/// "KSh 18,200".
String money(num amount, [String currency = 'KSh']) =>
    '$currency ${_whole.format(amount)}';

String number(num n) => _whole.format(n);

/// "Mon 2 Nov".
String shortDate(DateTime d) => DateFormat('EEE d MMM').format(d);

/// "2 Nov 2026".
String longDate(DateTime d) => DateFormat('d MMM y').format(d);

String greeting(DateTime now) => now.hour < 12
    ? 'Good morning'
    : now.hour < 17
    ? 'Good afternoon'
    : 'Good evening';

const weekdayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
