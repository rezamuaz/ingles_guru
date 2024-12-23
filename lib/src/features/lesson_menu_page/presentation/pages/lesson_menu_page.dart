import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/features/conversation_page/presentation/blocs/lesson_data_bloc.dart';
import 'package:sysbit/src/features/lesson_menu_page/presentation/pages/lesson_menu_page_view.dart';

class LessonMenuPage extends StatefulWidget {
  const LessonMenuPage(
      {super.key, this.lessonId, this.imageUrl, this.lessonTitle});
  final String? lessonId;

  final String? lessonTitle;
  final String? imageUrl;
  @override
  State<LessonMenuPage> createState() => _LessonMenuPageState();
}

class _LessonMenuPageState extends State<LessonMenuPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonDataBloc(),
      child: Builder(builder: (context) {
        return LessonMenuPageView(
          lessonCode: widget.lessonId ?? "",
          imageUrl: widget.imageUrl!,
          lessonTitle: widget.lessonTitle ?? "",
        );
      }),
    );
  }
}
