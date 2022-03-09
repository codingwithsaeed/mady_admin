import 'package:flutter/material.dart';

class XDetailsCard extends StatelessWidget {
  const XDetailsCard({Key? key, required this.name, required this.value})
      : super(key: key);

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.0),
      child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20.0, color: Colors.black54),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          horizontalTitleGap: 10.0,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3, horizontal: 15)),
    );
  }
}
