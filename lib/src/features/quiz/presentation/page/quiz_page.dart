import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/core/widget/dialog/dialog.dart';
import 'package:sysbit/src/features/quiz/data/model/quiz_mod.dart';
import 'package:sysbit/src/features/quiz/presentation/blocs/quiz/quiz_bloc.dart';
import 'package:sysbit/src/features/quiz/presentation/widget/quiz_context.dart';
import 'package:sysbit/src/features/quiz_result/presentation/pages/quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.lessonId});
  final String lessonId;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late PageController _pageController;
  int _currentPage = 0;
  List<QuizMod> quiz = [];
  int value = 0;
  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentPage,
    );
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  _nextPage(BuildContext context) async {
    if (_currentPage < (quiz.length - 1)) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == quiz.length - 1) {
      XDialog.confim(context,
          title: "Confirm Action",
          cancelButton: () {},
          cancelBtnText: "NO",
          okBtnText: "YES", okButton: () {
            context.read<ProgressRepository>().setQuizProgresss(widget.lessonId, quiz.length);
        Navigator.of(context).pushReplacement(
            Utils.createRoute(QuizResultPage(lessonId: widget.lessonId)));
      }, description: "Are you sure want to see result?");
    }
  }

  _prevPage(BuildContext context) {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == 0) {
      context.read<ProgressRepository>().setQuizProgresss(widget.lessonId, quiz.length);
      Navigator.pop(context);
    }
  }

  Future<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info)async {
      if(context.mounted){
         XDialog.confim(context,
                              title: "Konfirmasi",
                              cancelButton: () {
                                
                              },
                              okButton: () {
                                Navigator.of(context).pop();
                                context.read<ProgressRepository>().setQuizProgresss(widget.lessonId, quiz.length);
                              },
                              description:
                                  "anda yakin ingin menutup quiz?");
      }
      return Future.value(true);
  }

  @override
  void dispose() {
    _pageController.dispose();
   BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext maincontext) {
    return BlocProvider(
      create: (context) =>
          QuizBloc()..add(QuizEvent.started(lessonId: widget.lessonId)),
      child: Builder(builder: (maincontext) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: const Color(0xFFFFC700),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFC700),
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.read<ProgressRepository>().setQuizProgresss(widget.lessonId, quiz.length);
                      Navigator.of(maincontext).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${_currentPage + 1}/${quiz.length}",
                          style: GoogleFonts.inter(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ))),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocListener<QuizBloc, QuizState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (data) {
                    setState(() {
                      quiz = data;
                    });
                  },
                );
              },
              child: BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                          color: Colors.blue, size: 50),
                    ),
                    loaded: (data) {
                      return PageView.builder(
                          scrollDirection: Axis.horizontal,
                          padEnds: false,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          controller: _pageController,
                          itemCount: data.length,
                          itemBuilder: (context, index) => data.isEmpty
                              ? const SizedBox()
                              : QuizContext(
                                  quiz: data[index],
                                  currentPage: _currentPage,
                                  nextPage: () {
                                    _nextPage(maincontext);
                                  },
                                  prevPage: () {
                                    _prevPage(maincontext);
                                  },
                                ));
                    },
                    error: (error) => ErrorWidget(error),
                  );
                },
              ),
            ),
          ),
        ));
      }),
    );
  }
}
