import 'package:flutter/material.dart';

class PinDialog extends StatefulWidget {
  final void Function(String pin) onSubmit;

  const PinDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Admin PIN'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: '****',
          counterText: '',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSubmit(_controller.text);
            Navigator.pop(context);
          },
          child: const Text('Unlock'),
        ),
      ],
    );
  }
}
