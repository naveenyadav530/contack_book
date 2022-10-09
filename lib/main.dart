import 'package:contack_book/api.dart';
import 'package:contack_book/api_provider.dart';
import 'package:contack_book/date_time_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inherited Model',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContactsList(),
    );
  }
}

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Inherited Model"),
      ),
      body: Container(),
    );
  }
}
