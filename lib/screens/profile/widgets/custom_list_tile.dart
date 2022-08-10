import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  const CustomListTile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          onTap: onTap,
          title: Text(text),
          leading: Icon(icon),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }
}
