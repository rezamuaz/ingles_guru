import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/features/conversation_page/presentation/blocs/lesson_data_bloc.dart';

import 'package:sysbit/src/features/scene_page/presentation/pages/scene_page_view.dart';

class ScenePage extends StatefulWidget {
  const ScenePage({super.key, this.lessonId});
  final String? lessonId;
  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonDataBloc()
        ..add(LessonDataEvent.started(lessonId: widget.lessonId ?? "")),
      child: Builder(builder: (context) {
        return ScenePageView(lessonId: widget.lessonId);
      }),
    );
  }
}
