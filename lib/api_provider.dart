import 'package:contack_book/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ApiProvider extends InheritedWidget {
  final Api api;
  final Widget child;
  final String uuid;

  //assign the uuid value, key and child value initialy, key and child will be provided
  ApiProvider({Key? key, required this.api, required this.child})
      : uuid = const Uuid().v4(),
        super(key: key, child: child);

  ///Compare value of ApiProvider with old ones
  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid != oldWidget.uuid;
  }

  ///create of funtion to move arround the widget tree
  // It can be nullable
  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}
