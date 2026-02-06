import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../application/attendance/attendance_cubit.dart';
import '../../domain/entities/attendance.dart';
import '../../core/di/injection.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AttendanceCubit>()..loadAttendance(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Attendance History')),
        body: BlocBuilder<AttendanceCubit, List<Attendance>>(
          builder: (context, attendance) {
            if (attendance.isEmpty) {
              return const Center(
                child: Text('No attendance records'),
              );
            }

            final grouped = _groupByDate(attendance);

            return ListView(
              children: grouped.entries.map((entry) {
                final date = entry.key;
                final records = entry.value;

                return _DateSection(
                  date: date,
                  records: records,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  /// Groups attendance records by yyyy-MM-dd
  Map<String, List<Attendance>> _groupByDate(
      List<Attendance> attendance,
      ) {
    final Map<String, List<Attendance>> map = {};

    for (final record in attendance) {
      final dateKey =
      DateFormat('yyyy-MM-dd').format(record.timestamp);

      map.putIfAbsent(dateKey, () => []).add(record);
    }

    return map;
  }
}

class _DateSection extends StatelessWidget {
  final String date;
  final List<Attendance> records;

  const _DateSection({
    required this.date,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, dd MMM yyyy')
        .format(DateTime.parse(date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 📅 Date header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            formattedDate,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        // 📋 Records
        ...records.map((record) {
          final time =
          DateFormat('hh:mm a').format(record.timestamp);

          return ListTile(
            leading: const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            title: Text('User ID: ${record.userId}'),
            subtitle: Text(time),
          );
        }),
      ],
    );
  }
}
