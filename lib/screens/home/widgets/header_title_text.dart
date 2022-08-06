import 'package:flutter/material.dart';

class HeaderTitleText extends StatelessWidget {
  final String title, buttonText;
  final Function() onButtonClicked;
  const HeaderTitleText({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.onButtonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              //color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          InkWell(
            onTap: onButtonClicked,
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
