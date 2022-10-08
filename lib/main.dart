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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/new-contact': ((context) => NewContactView()),
        },
        home: ContactsList());
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
        title: const Text("Contact book"),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (contact, value, child) {
          final contacts = value as List<Contact>;
          return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                // final contact = contactBook.contact(atIndex: index)!;
                final contact = contacts[index];

                return Dismissible(
                    onDismissed: (direction) {
                      // contacts.remove(contact);
                      ContactBook().remove(contact: contact);
                    },
                    key: ValueKey(contact.id),
                    child: Material(
                      color: Colors.white,
                      elevation: 6,
                      child: ListTile(
                        title: Text(contact.name),
                      ),
                    ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() async =>
            await Navigator.of(context).pushNamed('/new-contact')),
      ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: _controller,
          decoration:
              const InputDecoration(hintText: "Enter a new contact here..."),
        ),
        TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().add(contact: contact);
              Navigator.of(context).pop();
            },
            child: const Text("Add Contact"))
      ]),
    );
  }
}

class Contact {
  final String id;
  final String name;
  Contact({required this.name}) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() {
    return _shared;
  }

  // final List<Contact> _contacts = [];

  // int get length => _contacts.length;
  int get length => value.length;

  void add({required Contact contact}) {
    ValueNotifier notifier;
    //  _contacts.add(contact);
    // value.add(contact);
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    //_contacts.remove(contact);
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({required int atIndex}) {
    //_contacts.length > atIndex ? _contacts[atIndex] : null;
    value.length > atIndex ? value[atIndex] : null;
  }
}
