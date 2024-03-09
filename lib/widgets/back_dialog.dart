import 'package:flutter/material.dart';

class BackDialog extends StatefulWidget {
  final String confirmation;
  const BackDialog({super.key, required this.confirmation});

  @override
  State<BackDialog> createState() => _BackDialogState();
}

class _BackDialogState extends State<BackDialog> {
  @override
  Widget build(BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content:  Text(
            widget.confirmation,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
}
