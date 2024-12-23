import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/core/common/error_response_message.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/dialog/flash_message_wrapper.dart';

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
  ErrorResponseMessage? _error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Center(child: BlocConsumer<LessonDataBloc, LessonDataState>(
          listener: (context, state) {
            state.whenOrNull(error: (error) => _onRequestError(error),);
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const SizedBox(),
              loaded: (data) => data.sceneUrl != null?
                  
                  VideoBuilder(
                      url: data.sceneUrl ?? "",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      callbackFinish: () {
                        Navigator.pushReplacement(
                            context,
                            Utils.createRoute(ConversationPage(
                                lessonCode: widget.lessonId ?? "")));
                      },
                    ): const Center(
                      child: Text(
                        "Data not found",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              error: (error) => SizedBox(),
            );
          },
        )));
  }
  
   void _onRequestError(NetworkExceptions e) {
 
    e.maybeWhen(
      orElse: () => FlashMessage.error(context: context, error: e),
      unprocessableEntity: (m) => _error = m,
    );
  }
}
