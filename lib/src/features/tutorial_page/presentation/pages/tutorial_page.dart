import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/root_page/presentation/cubit/navbar_view_cubit.dart';
import 'package:sysbit/src/features/tutorial_page/presentation/widget/tutorial_player.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key, required this.lessonCode});
  final String lessonCode;
  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final tutorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    initVideo();
    super.initState();
  }

  initVideo() {}

  @override
  void didChangeDependencies() async {
    context.read<NavbarViewCubit>().change(state: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            )
          : null,
      key: tutorKey,
      backgroundColor: Colors.black,
      body: Center(
          child: TutorialPlayer(
        lessonCode: widget.lessonCode,
        localUrl:
            "${Env.baseUrl}/api/m/file/video/T${widget.lessonCode}/video.m3u8",
        aspect: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height,
      )),
    );
  }
}
