import 'package:flutter/material.dart';

class OrDividerForm extends StatelessWidget {
  const OrDividerForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            thickness: 2,
            endIndent: 10,
            indent: 2,
          ),
        ),
        Text('or'),
        Expanded(
          child: Divider(thickness: 2, endIndent: 2, indent: 10),
        ),
      ],
    );
  }
}
