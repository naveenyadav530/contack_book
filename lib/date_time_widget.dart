import 'package:contack_book/api.dart';
import 'package:contack_book/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;

    return Text(api.dateAndTime ?? "Tap on  screeen to fetch date and time");
  }
}
