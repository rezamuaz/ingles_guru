
import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:river_player/river_player.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/local_storage/entities/progress.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';

class TutorialPlayer extends StatefulWidget {
  const TutorialPlayer(
      {super.key,
      required this.localUrl,
      required this.aspect,
      required this.lessonCode});
  final String localUrl;
  final double aspect;
  final String lessonCode;

  @override
  State<TutorialPlayer> createState() => _TutorialPlayerState();
}

class _TutorialPlayerState extends State<TutorialPlayer> {
  late BetterPlayerController _betterPlayerController;
  double aspectRatio = 9 / 16;
  // bool _showNext = false;
  bool reach = false;
  bool _checkIfCanProcessPlayerEvent(BetterPlayerEvent event) {
    return event.betterPlayerEventType == BetterPlayerEventType.progress &&
        event.parameters != null &&
        event.parameters!['progress'] != null &&
        event.parameters!['duration'] != null;
  }

  @override
  void initState() {
    var config = BetterPlayerConfiguration(
      autoPlay: true,
      looping: false,
      autoDispose: true,
      allowedScreenSleep: false,
      fit:BoxFit.fill,
      aspectRatio: 9/16,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControls: true,
        enableQualities: true,
        enableFullscreen: true,
      ),
    );
    var dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.localUrl,
      cacheConfiguration:
          const BetterPlayerCacheConfiguration(useCache: true,),
      useAsmsTracks: true,
    );
    _betterPlayerController =
        BetterPlayerController(config, betterPlayerDataSource: dataSource);
  
    _betterPlayerController.addEventsListener((event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
          // Update the aspect ratio
          setState(() {
            _betterPlayerController.setOverriddenAspectRatio(_betterPlayerController.videoPlayerController!.value.aspectRatio);
           
          });
        }
   
      if (_checkIfCanProcessPlayerEvent(event)) {
        Duration progress = event.parameters!['progress'];
        Duration duration = event.parameters!['duration'];
        if (progress.inSeconds >= (duration.inSeconds - 5)) {
          if (!reach) {
            //make sure only once trigger
            setState(() {
              reach = true;
            });
          
             context.read<ProgressRepository>().addProgress(widget.lessonCode,tutorial: true);
            ElegantNotification.success(
              icon: Image.asset(Assets.webp.success.path,width: 90,height: 90,),
              width: 360,
              iconSize: 60,
              toastDuration: const Duration(seconds: 4),
              isDismissable: false,
              stackedOptions: StackedOptions(
                key: 'top',
                type: StackedType.same,
                itemOffset: const Offset(-5, -5),
              ),
              title: const Text('Tutorial Selesai'),
              description:
                  AutoSizeText("Anda telah dapat mengakses kuis dan flash card",style: GoogleFonts.inter(fontSize: 14),),
              onDismiss: () {
                //Message when the notification is dismissed
              },
              onNotificationPressed: () {
                //Message when the notification is pressed
              },
              border: const Border(
                bottom: BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ).show(context);
          }
        }
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        context.read<ProgressRepository>().addProgress( widget.lessonCode);
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 9/16,child: BetterPlayer(controller: _betterPlayerController));
  }
}
