import 'package:uuid/uuid.dart';

import '../time/day.dart';

const _uuid = Uuid();

String newId() => _uuid.v4();

/// The id of something that happens once per thing per day, so the same
/// row can't be created twice, e.g. a habit's completion on a day.
String dailyId(String prefix, DateTime day) =>
    '$prefix:${day.dateOnly.toIso8601String().substring(0, 10)}';

String isoDay(DateTime day) => day.dateOnly.toIso8601String().substring(0, 10);

DateTime parseDay(String iso) => DateTime.parse('${iso}T00:00:00Z');

/// Weekdays stored as "1,3,5".
String encodeWeekdays(Set<int> days) => (days.toList()..sort()).join(',');

Set<int> decodeWeekdays(String s) =>
    s.isEmpty ? {} : s.split(',').map(int.parse).toSet();
