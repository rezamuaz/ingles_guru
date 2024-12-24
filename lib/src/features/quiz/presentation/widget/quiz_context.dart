import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sysbit/src/core/local_storage/entities/quiz_answer.dart';
import 'package:sysbit/src/core/local_storage/object_box/quiz_answer_repository.dart';
import 'package:sysbit/src/features/quiz/data/model/quiz_mod.dart';
import 'package:sysbit/src/features/quiz/presentation/widget/quiz_answer_item.dart';

import 'choice_button.dart';

class QuizContext extends StatefulWidget {
  const QuizContext({
    super.key,
    required this.quiz,
    required this.nextPage,
    required this.prevPage,
    required this.currentPage,
  });
  final Function() nextPage;
  final Function() prevPage;
  final QuizMod quiz;

  final int currentPage;

  @override
  State<QuizContext> createState() => _QuizContextState();
}

class _QuizContextState extends State<QuizContext> {
  String? _selectedOption = '';

  @override
  void didChangeDependencies() async{
   var initSelection = await  context
                  .read<QuizAnswerRepository>()
                  .getAnswerStream(widget.quiz.quizId ?? 0).first;
    setState(() {
      _selectedOption = initSelection?.answer;
    });
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: Colors.black54)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: double.infinity,
                    child: HtmlWidget(widget.quiz.context ?? "")),
                const SizedBox(
                  height: 5,
                ),
                HtmlWidget(widget.quiz.question ?? "s"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.quiz.selections.length,
              (index) {
                return ChoiceButton(
                  content: widget.quiz.selections[index].description ?? "",
                  value: widget.quiz.selections[index].choice ?? "",
                  groupValue: _selectedOption ?? "",
                  onChanged: (p0) {
                    setState(() {
                      _selectedOption = p0;
                    });

                    context.read<QuizAnswerRepository>().addAnswer(QuizAnswer(
                        answer: p0 ?? "",
                        isCorrect: widget.quiz.answer == p0 ? true : false,
                        number: widget.quiz.num ?? 0,
                        id: widget.quiz.quizId ?? 0,
                        lessonCode: widget.quiz.lessonCode ?? ""));

                    // SqfliteService().insertQuizAnswer(QuizAnswer(
                    //     lessondId: widget.lessonId,
                    //     quizId: widget.quizId,
                    //     number: widget.num,
                    //     answer: p0 ?? "",
                    //     isCorrect: widget.answer == p0 ? 1 : 0));
                  },
                );
              },
            ),
          ),
          StreamBuilder(
              stream: context
                  .read<QuizAnswerRepository>()
                  .getAnswerStream(widget.quiz.quizId ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                // Handle error state
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // Handle no data state
                if (!snapshot.hasData) {
                  return Container(
                      constraints: const BoxConstraints(
                          maxWidth: double.infinity, maxHeight: 45),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black87, width: 1)),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.blue,
                            size: 35,
                          ),
                          Text('Please, submit your answer'),
                        ],
                      ));
                }

                return QuizAnswerItem(
                    isCorrect: snapshot.data!.isCorrect,
                    reason: widget.quiz.reason ?? "",
                    userAnswer: widget.quiz.selections
                            .firstWhere(
                                (val) => val.choice == snapshot.data!.answer)
                            .description ??
                        "",
                    answer: widget.quiz.selections
                            .firstWhere(
                                (val) => val.choice == widget.quiz.answer)
                            .description ??
                        "");
              }),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: widget.prevPage,
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.black87)),
              ),
              IconButton(
                onPressed: widget.nextPage,
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.black87)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
