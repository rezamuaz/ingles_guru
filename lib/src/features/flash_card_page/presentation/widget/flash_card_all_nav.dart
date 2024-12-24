import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/local_storage/entities/word.dart';
import 'package:sysbit/src/core/local_storage/object_box/word_repository.dart';

class FlashCardAllNav extends StatefulWidget {
  const FlashCardAllNav(
      {super.key,
      this.enableNext = false,
      this.enablePrev = false,
      this.onNext,
      this.onPrev,
      this.onTick,
      required this.wordId,
      required this.buttonColor});
  final Function()? onNext;
  final bool enableNext;
  final bool enablePrev;
  final Function()? onPrev;
  final Function()? onTick;
  final Color buttonColor;
  final int wordId;

  @override
  State<FlashCardAllNav> createState() => _FlashCardAllNavState();
}

class _FlashCardAllNavState extends State<FlashCardAllNav> {
  bool refresh = false;





  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        widget.enablePrev
            ? IconButton(
                onPressed: widget.onPrev,
                iconSize: 40,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: widget.buttonColor,
                ),
              )
            : const SizedBox(
                height: 40,
                width: 40,
              ),
        StreamBuilder<Word?>(
          stream: context.read<WordRepository>().getWordStream(widget.wordId),
          builder: (context, snapshot) {
            // Handle loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            // Handle error state
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Handle no data state
            if (!snapshot.hasData) {
              return const Center(
                  child: Text('No data found for this word ID.'));
            }

            return IconButton(
              onPressed: widget.onTick,
              icon: snapshot.data!.learned
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.check_circle_outlined,
                      color: widget.buttonColor,
                    ),
              iconSize: 50,
            );
          },
        ),
        widget.enableNext
            ? IconButton(
                onPressed: widget.onNext,
                iconSize: 40,
                icon: Icon(Icons.arrow_forward_ios_rounded,
                    color: widget.buttonColor))
            : const SizedBox(
                height: 40,
                width: 40,
              )
      ],
    );
  }
}
