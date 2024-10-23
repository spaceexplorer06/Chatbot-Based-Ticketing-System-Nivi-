import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App with Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Map<String, dynamic>>> events = {};

  @override
  void initState() {
    super.initState();
    _listenToFirestoreChanges();
  }

  // Use a Firestore stream listener to get real-time updates
  void _listenToFirestoreChanges() {
    _firestore.collection('reminders').snapshots().listen((snapshot) {
      Map<DateTime, List<Map<String, dynamic>>> newEvents = {};

      for (var doc in snapshot.docs) {
        final data = doc.data();
        DateTime date = DateTime.parse(data['date']);
        String event = data['event'];

        if (newEvents[date] != null) {
          newEvents[date]!.add({'id': doc.id, 'event': event});
        } else {
          newEvents[date] = [{'id': doc.id, 'event': event}];
        }
      }

      // Update the UI
      setState(() {
        events = newEvents;
      });
    });
  }

  Future<void> _addEvent(String event) async {
    if (_selectedDay == null) return;

    try {
      // Save event to Firestore
      await _firestore.collection('reminders').add({
        'date': _selectedDay!.toIso8601String(),
        'event': event,
      });
    } catch (e) {
      print('Error adding event to Firestore: $e');
    }
  }

  Future<void> _deleteEvent(String docId, DateTime date, Map<String, dynamic> event) async {
    // Optimistically remove the event from the UI state first
    setState(() {
      events[date]?.remove(event);
      if (events[date]?.isEmpty ?? true) {
        events.remove(date);
      }
    });

    // Now attempt to delete the event from Firestore
    try {
      await _firestore.collection('reminders').doc(docId).delete();
      print('Event deleted from Firestore');
    } catch (e) {
      // If the delete fails, re-add the event to the UI
      setState(() {
        if (events[date] != null) {
          events[date]!.add(event);
        } else {
          events[date] = [event];
        }
      });
      print('Error deleting event: $e');
    }
  }

  void _showAddEventDialog() {
    String newEvent = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Event'),
        content: TextField(
          onChanged: (value) {
            newEvent = value;
          },
          decoration: const InputDecoration(
            hintText: 'Enter event',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newEvent.isNotEmpty) {
                _addEvent(newEvent);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return Column(
      children: events[_selectedDay]?.map((event) {
        return ListTile(
          title: Text(event['event']),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deleteEvent(event['id'], _selectedDay!, event);
            },
          ),
        );
      }).toList() ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
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
            const SizedBox(height: 20),
            Expanded(
              child: _buildEventList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
