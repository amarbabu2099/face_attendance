import 'dart:convert';
import 'package:drift/drift.dart';

class DoubleListConverter extends TypeConverter<List<double>, String> {
  const DoubleListConverter();

  @override
  List<double> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb) as List;
    return decoded.map((e) => (e as num).toDouble()).toList();
  }

  @override
  String toSql(List<double> value) {
    return jsonEncode(value);
  }
}
