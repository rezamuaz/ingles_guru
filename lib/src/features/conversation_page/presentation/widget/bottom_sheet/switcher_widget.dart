import 'dart:async';

import 'package:flutter/material.dart';

class SwitcherWidget extends StatefulWidget {
  const SwitcherWidget(
      {super.key,
      required this.lastWord,
      required this.isCorrect,
      required this.originText});
  final String lastWord;
  final bool isCorrect;
  final String originText;

  @override
  State<SwitcherWidget> createState() => _SwitcherWidgetState();
}

class _SwitcherWidgetState extends State<SwitcherWidget> {
  bool show = false;

  @override
  void initState() {
    // Start a timer to switch widgets after 2 seconds
    Timer(const Duration(seconds: 1), () {
      setState(() {
        show = true;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return show
        ? Text(widget.originText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54))
        : Text(widget.lastWord,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: widget.isCorrect ? Colors.green : Colors.red));
  }
}
