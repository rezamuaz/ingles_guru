import 'package:flutter/material.dart';
import 'package:river_player/river_player.dart';

class IntroductionPlayer extends StatefulWidget {
  const IntroductionPlayer({super.key,this.localUrl,this.callback});
  final String? localUrl;
  final VoidCallback?  callback;
  @override
  State<IntroductionPlayer> createState() => _IntroductionPlayerState();
}

class _IntroductionPlayerState extends State<IntroductionPlayer> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    var  config =
        const BetterPlayerConfiguration(
      autoPlay: true,
      looping: false,
      autoDispose: true,
      allowedScreenSleep: false,
      
    );
    var dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        widget.localUrl!,
        cacheConfiguration:
            const BetterPlayerCacheConfiguration(useCache: true, key: "INT0101"),
        useAsmsTracks: true);
    _betterPlayerController = BetterPlayerController(config,betterPlayerDataSource: dataSource);
    _betterPlayerController.addEventsListener((event) {
     
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        _betterPlayerController.setOverriddenAspectRatio(
            _betterPlayerController.videoPlayerController!.value.aspectRatio);
        setState(() {});
      }
     
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BetterPlayer(controller: _betterPlayerController),
      
      ],
    );
  }
}
