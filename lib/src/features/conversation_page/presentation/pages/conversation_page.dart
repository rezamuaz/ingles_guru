import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/features/conversation_page/presentation/blocs/lesson_data_bloc.dart';
import 'package:sysbit/src/features/conversation_page/presentation/pages/conversation_view.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key, required this.lessonCode});
  final String lessonCode;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LessonDataBloc()..add(LessonDataEvent.started(lessonId: lessonCode)),
      child: Builder(builder: (context) {
        return BlocBuilder<LessonDataBloc, LessonDataState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const SizedBox(),
              loaded: (data) => ConversationView(
                lessonCode: lessonCode,
                data: data,
              ),
              error: (error) => ErrorWidget(error),
            );
          },
        );
      }),
    );
  }
}
