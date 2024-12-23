import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AnswerNum {
  correct,
  incorrect,
  waiting,
}

class QuizAnswerItem extends StatefulWidget {
  const QuizAnswerItem(
      {super.key,
      required this.answer,
      required this.reason,
      required this.userAnswer,
      required this.isCorrect});
  final String answer;

  final String reason;

  final String userAnswer;
  final bool isCorrect;

  @override
  State<QuizAnswerItem> createState() => _AnswerItemState();
}

class _AnswerItemState extends State<QuizAnswerItem>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> expanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.black87,
                width: 1,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: widget.isCorrect ? Colors.green : Colors.red),
                    constraints:
                        const BoxConstraints(maxWidth: 35, maxHeight: 35),
                    alignment: Alignment.center,
                    child: widget.isCorrect
                        ? const Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.isCorrect
                        ? "Jawaban anda benar"
                        : "Jawaban anda salah",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              widget.isCorrect
                  ? const Divider(
                      color: Colors.black54,
                    )
                  : const SizedBox(),
              widget.isCorrect ? const SizedBox.shrink() : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              widget.isCorrect
                  ? Text(
                      widget.reason,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
