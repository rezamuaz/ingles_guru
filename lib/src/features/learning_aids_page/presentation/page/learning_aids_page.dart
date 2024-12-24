import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/features/learning_aids_page/presentation/bloc/learning_aids_bloc.dart';
import 'package:sysbit/src/features/learning_aids_page/presentation/page/learning_aids_view.dart';

class LearningAidsPage extends StatefulWidget {
  const LearningAidsPage(this.lessonCode,{super.key,});
  final String lessonCode;

  @override
  State<LearningAidsPage> createState() => _LearningAidsPageState();
}

class _LearningAidsPageState extends State<LearningAidsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LearningAidsBloc()..add(LearningAidsEvent.started(widget.lessonCode)),child: const LearningAidsView(),);
  }
}