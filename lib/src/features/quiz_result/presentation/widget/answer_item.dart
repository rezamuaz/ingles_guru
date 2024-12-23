import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/features/quiz/data/model/quiz_mod.dart';

enum AnswerNum {
  correct,
  incorrect,
  waiting,
}

class AnswerItem extends StatefulWidget {
  const AnswerItem({
    super.key,
    required this.idx,
    required this.userAnswer,
    required this.isCorrect,
    required this.quiz,
  });
  final QuizMod quiz;
  final int? idx;
  final String userAnswer;
  final bool isCorrect;

  @override
  State<AnswerItem> createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> expanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: _borderColor(widget.status), width: 2,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.isCorrect ? Colors.green : Colors.red,
                borderRadius: expanded.value
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))
                    : BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Question #${widget.idx} (${widget.isCorrect ? "Correct" : "Wrong"})",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Material(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            expanded.value = !expanded.value;
                          });
                        },
                        splashColor: Colors.black12,
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.isCorrect ? Colors.green : Colors.red,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: expanded.value
                                ? const Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                : const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                          ),
                        ))),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: expanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            alignment: Alignment.topLeft,
            sizeCurve: Easing.standardDecelerate,
            duration: const Duration(milliseconds: 300),
            firstChild: const SizedBox(),
            secondChild: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  border: Border(
                      left: BorderSide(
                          color: widget.isCorrect ? Colors.green : Colors.red,
                          width: 2),
                      bottom: BorderSide(
                          color: widget.isCorrect ? Colors.green : Colors.red,
                          width: 2),
                      right: BorderSide(
                          color: widget.isCorrect ? Colors.green : Colors.red,
                          width: 2))),
              padding: expanded.value
                  ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
                  : const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HtmlWidget(widget.quiz.context ?? ""),
                  const SizedBox(height: 8),
                  HtmlWidget(
                    widget.quiz.question ?? "",
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: Colors.black54,
                  ),
                  Text(
                    "Jawaban anda",
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: widget.isCorrect
                            ? const Color(0xFF00BC0D)
                            : const Color(0xFFD32C2C),
                        borderRadius: BorderRadius.circular(10)),
                    child: HtmlWidget(
                      widget.userAnswer,
                      textStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Jawaban yang benar",
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFF00BC0D),
                        borderRadius: BorderRadius.circular(10)),
                    child: HtmlWidget(
                      widget.quiz.answer ?? "",
                      textStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    widget.quiz.reason ?? "",
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
