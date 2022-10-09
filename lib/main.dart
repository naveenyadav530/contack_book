import 'dart:math';

import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';

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
  var color1 = Colors.blue;
  var color2 = Colors.pink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inherited Model"),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      color1 = colors.getRandomColor();
                    });
                  },
                  child: Text("Change Color 1"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      color2 = colors.getRandomColor();
                    });
                  },
                  child: const Text("Change Color 2"),
                ),
              ],
            ),
            const ColorWidget(color: AvailableColors.one),
            const ColorWidget(color: AvailableColors.two),
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.color});
  final AvailableColors color;

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        devtools.log("Color 1");
        break;
      case AvailableColors.two:
        devtools.log("Color 2");
        break;
    }
    final provider = AvailableColorsWidget.of(context, color);

    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;

  const AvailableColorsWidget(
      {Key? key,
      required this.color1,
      required this.color2,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    devtools.log("update should notify");
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(covariant AvailableColorsWidget oldWidget,
      Set<AvailableColors> dependencies) {
    devtools.log("updateShouldNotifyDependent");

    ///check which value is changed
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }

  ///allow to fetch data  to the children widgets
  static AvailableColorsWidget of(
      BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(context,
        aspect: aspect)!;
  }
}

final colors = [
  Colors.red,
  Colors.black,
  Colors.pink,
  Colors.amber,
  Colors.blueAccent
];

enum AvailableColors { one, two }

extension RandomElement<T> on Iterable<T> {
  ///when any list, set , queue is accessed with this
  ///then it will return the element which is present in the list randomly
  ///nextInt will generate int value between 0 to length of passed collection
  getRandomColor() => elementAt(Random().nextInt(length));
}
