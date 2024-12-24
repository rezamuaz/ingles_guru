
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/features/conversation_page/data/model/lesson_data.dart';
import 'package:sysbit/src/features/conversation_page/presentation/cubit/speech_text_cubit.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/character_widget.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/nav_and_record.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/bottom_sheet/recorder_bottom_sheet.dart';

class SceneBuilderWidget extends StatefulWidget {
  const SceneBuilderWidget(
      {super.key,
      required this.currentPage,
      required this.nextPage,
      required this.prevPage,
      required this.steps,
      required this.lastWords,
      required this.pageLength,
      required this.lessonCode,
      required this.pageNumber,
      required this.isBack,
      this.closePage,
      required this.totalPage});

  ///Contains step data
  final List<LessonStep>? steps;
  final String lastWords;
  final Function() nextPage;
  final Function() prevPage;
  final int pageLength;
  final VoidCallback? closePage;
  final int currentPage;
  final String lessonCode;
  final bool isBack;
  final String pageNumber;
  final String totalPage;

  @override
  State<SceneBuilderWidget> createState() => _SceneBuilderWidgetState();
}

class _SceneBuilderWidgetState extends State<SceneBuilderWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool showBottomSheet = false;
  PersistentBottomSheetController? _bottomSheetController;

  // Show BottomSheet Widget for Talking
  _showBottom({required String voiceUrl, required String originText}) {
    if (!showBottomSheet) {
      _bottomSheetController = Scaffold.of(context).showBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: false,
        (context) {
          return RecorderBottomSheet(
            voiceUrl: voiceUrl,
            originText: originText,
          );
        },
      );
    } else {
      _bottomSheetController!.close();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAnimation();
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    if(widget.pageNumber == "8"){
      context.read<ProgressRepository>().addProgress(widget.lessonCode,conversation: true);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final SpeechTextCubit textCubit = BlocProvider.of<SpeechTextCubit>(context);
    textCubit.change(newText: widget.steps?[1].contents?.primaryLang);
    super.didChangeDependencies();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because we were disposed.
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            //First Character
            CharacterWidget(
              switchDialog: () {
                if (_bottomSheetController != null) {
                  _bottomSheetController!.close();
                }
            
                final SpeechTextCubit textCubit =
                    BlocProvider.of<SpeechTextCubit>(context);
                textCubit.change(
                    newText: widget.steps?[0].contents?.primaryLang);
                _showBottom(
                    voiceUrl: widget.steps![0].assets?.voice ?? "",
                    originText: widget.steps?[0].contents?.primaryLang ?? "");
              },
              voiceUrl: widget.steps![0].assets?.voice ?? "",
              image: widget.steps![0].assets?.image ?? "",
              eng: widget.steps![0].contents?.primaryLang ?? "",
              ind: widget.steps![0].contents?.secondaryLang ?? "",
            ),
            const SizedBox(height: 40),
            //Second Character
            CharacterWidget(
              switchDialog: () {
                if (_bottomSheetController != null) {
                  _bottomSheetController!.close();
                }
                final SpeechTextCubit textCubit =
                    BlocProvider.of<SpeechTextCubit>(context);
                textCubit.change(
                    newText: widget.steps?[1].contents?.primaryLang);
                _showBottom(
                    voiceUrl: widget.steps![1].assets?.voice ?? "",
                    originText: widget.steps?[1].contents?.primaryLang ?? "");
              },
              voiceUrl: widget.steps![1].assets?.voice ?? "",
              isLeftAlign: false,
              image: widget.steps![1].assets?.image ?? "",
              eng: widget.steps![1].contents?.primaryLang ?? "",
              ind: widget.steps![1].contents?.secondaryLang ?? "",
              lastWord: widget.lastWords,
            ),
          ],
        ),
        
        Positioned(
              top: 5,
              right: 30,
              child: IconButton.filledTonal(onPressed:widget.closePage, icon: Icon(Icons.close,color: Colors.black87,)),
            ),
        //Show Bottom Sheet Dialog for Record
        Positioned(
            bottom: 0,
            child: NavAndRecord(
              totalPage: widget.totalPage,
              pageNumber: widget.pageNumber,
              record: () {
                final SpeechTextCubit textCubit =
                    BlocProvider.of<SpeechTextCubit>(context);
                textCubit.change(
                    newText: widget.steps?[1].contents?.primaryLang);
                _showBottom(
                    voiceUrl: widget.steps![1].assets?.voice ?? "",
                    originText: widget.steps?[1].contents?.primaryLang ?? "");
              },
              isback: widget.isBack,
              controller: _controller,
              curretPage: widget.currentPage,
              nextPage: widget.nextPage,
              prevPage: widget.prevPage,
            ),
            ),
            
      ],
    );
  }
}
