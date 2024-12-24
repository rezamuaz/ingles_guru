import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sysbit/src/core/local_storage/object_box/quiz_answer_repository.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/quiz/presentation/blocs/quiz/quiz_bloc.dart';
import 'package:sysbit/src/features/quiz/presentation/page/quiz_page.dart';
import 'package:sysbit/src/features/quiz_result/presentation/widget/answer_empty.dart';
import 'package:sysbit/src/features/quiz_result/presentation/widget/answer_item.dart';

class QuizResultPage extends StatefulWidget {
  const QuizResultPage({super.key, required this.lessonId});
  final String lessonId;
  @override
  State<QuizResultPage> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResultPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuizBloc()..add(QuizEvent.started(lessonId: widget.lessonId)),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "QUIZ RESULT",
                            style: GoogleFonts.inter(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ))),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined))
              ],
            ),
            body: Column(
              children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<QuizBloc, QuizState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => Center(
                            child: LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.blue, size: 50)),
                        loaded: (data) {
                          return ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return StreamBuilder(
                                    stream: context
                                        .read<QuizAnswerRepository>()
                                        .getAnswerStream(
                                            data[index].quizId ?? 0),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox();
                                      }

                                      // Handle error state
                                      if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      }

                                      // Handle no data state
                                      if (!snapshot.hasData) {
                                        return AnswerEmpty(
                                          idx: data[index].num,
                                          question: data[index].question ?? "",
                                          context: data[index].context ?? "",
                                        );
                                      }

                                      return AnswerItem(
                                        isCorrect: snapshot.data!.isCorrect,
                                        quiz: data[index].copyWith(
                                            answer: data[index]
                                                    .selections
                                                    .firstWhere((val) =>
                                                        val.choice ==
                                                        data[index].answer)
                                                    .description ??
                                                ""),
                                        idx: data[index].num,
                                        userAnswer: data[index]
                                                .selections
                                                .firstWhere((val) =>
                                                    val.choice ==
                                                    snapshot.data!.answer)
                                                .description ??
                                            "",
                                      );
                                    });
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: data.length);
                        },
                        error: (error) => const SizedBox.shrink(),
                      );
                    },
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                Utils.createRoute(
                                    QuizPage(lessonId: widget.lessonId)));
                          },
                          icon: const Icon(
                            Icons.replay_outlined,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor:
                                  const WidgetStatePropertyAll(Colors.black87)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                    Colors.black87),
                                shape: WidgetStatePropertyAll(
                                    ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            )
                            // Text(
                            //   "Selanjutnya".toUpperCase(),
                            //   style: GoogleFonts.inter(
                            //       fontSize: 17,
                            //       fontWeight: FontWeight.w600,
                            //       color: Colors.white),
                            // ),
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
