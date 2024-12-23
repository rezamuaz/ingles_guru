import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/features/conversation_page/data/model/lesson_data.dart';
import 'package:sysbit/src/features/conversation_page/presentation/cubit/speech_text_cubit.dart';

import 'package:sysbit/src/features/conversation_page/presentation/widget/scene_builder.dart';
import 'package:sysbit/src/features/root_page/presentation/cubit/navbar_view_cubit.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ConversationView extends StatefulWidget {
  const ConversationView(
      {super.key, required this.lessonCode, required this.data});

  ///LessonID [lessonCode]
  final String lessonCode;
  final LessonData data;
  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  late PageController _pageController;
  // late LessonData data = LessonData();
  int _currentPage = 0;
  bool show = false;
  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentPage,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    WakelockPlus.toggle(enable: true);
    setState(() {
      show = true;
    });

    context.read<NavbarViewCubit>().change(state: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    //Next Button Push User to Tutorial Page when on last page
    if (_currentPage == widget.data.pages.length - 1) {
      Navigator.of(context).pop();
      return;
    }
    if (_currentPage < (widget.data.pages.length - 1)) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
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
      Navigator.of(context).pop();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SpeechTextCubit(),
        ),
      ],
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            context.read<NavbarViewCubit>().change(state: false);
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: SafeArea(
              child: Column(
                children: [
                  // SizedBox(
                  //     height: 60,
                  //     child: AnimatedOpacity(
                  //       duration: const Duration(seconds: 1),
                  //       opacity: show ? 1 : 0,
                  //       curve: Curves.decelerate,
                  //       child: ProgressScene(
                  //         pages: data.pages,
                  //       ),
                  //     )),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        //Generate Conversation Page
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            padEnds: false,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            controller: _pageController,
                            itemCount: widget.data.pages.length,
                            itemBuilder: (context, index) => SceneBuilderWidget(
                                  closePage: () {
                                    Navigator.of(context).pop();
                                  },
                                  totalPage:
                                      widget.data.pages.length.toString(),
                                  pageNumber:
                                      widget.data.pages[index].page.toString(),
                                  isBack: _currentPage ==
                                          widget.data.pages.length - 1
                                      ? true
                                      : false,
                                  lessonCode: widget.lessonCode,
                                  pageLength: widget.data.pages.length,
                                  currentPage: _currentPage,
                                  nextPage: _nextPage,
                                  prevPage: _prevPage,
                                  lastWords: "",
                                  steps: widget.data.pages[index].steps,
                                ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> check(String correct, {String input = ""}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    String text1 = correct.toLowerCase().replaceAll(",", "");
    String text2 = input.toLowerCase().replaceAll(",", "");
    if (text1 != text2) {
      return false;
    } else {
      return true;
    }
  }
}
