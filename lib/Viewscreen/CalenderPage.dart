import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 57),
          child: Text('Calendar'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          calendarStyle: const CalendarStyle(
            // Customize your calendar appearance here
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
      ),
    );
  }
}
