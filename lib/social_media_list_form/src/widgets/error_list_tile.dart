import "package:flutter/material.dart";

class ErrorListTile extends StatelessWidget {
  ErrorListTile(this.message,{super.key});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "-",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            "$message",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ),
      ],
    );
  }
}
