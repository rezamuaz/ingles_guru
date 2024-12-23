import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/core/widget/video_builder.dart';
import 'package:sysbit/src/features/conversation_page/presentation/blocs/lesson_data_bloc.dart';
import 'package:sysbit/src/features/conversation_page/presentation/pages/conversation_page.dart';

class ScenePageView extends StatefulWidget {
  const ScenePageView({super.key, this.lessonId});
  final String? lessonId;
  @override
  State<ScenePageView> createState() => _ScenePageViewState();
}

class _ScenePageViewState extends State<ScenePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Center(child: BlocBuilder<LessonDataBloc, LessonDataState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const SizedBox(),
              loaded: (data) => data.sceneUrl!.isEmpty
                  ? const Center(
                      child: Text(
                        "Data not found",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : VideoBuilder(
                      url: data.sceneUrl ?? "",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      callbackFinish: () {
                        Navigator.pushReplacement(
                            context,
                            Utils.createRoute(ConversationPage(
                                lessonCode: widget.lessonId ?? "")));
                      },
                    ),
              error: (error) => const SizedBox(),
            );
          },
        )));
  }
}
