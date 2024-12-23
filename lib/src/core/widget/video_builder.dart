import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/local_storage/cache/cache.dart';
import 'package:sysbit/src/core/widget/video_serve.dart';

class VideoBuilder extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double height;
  final double width;
  final VoidCallback? callbackFinish;
  const VideoBuilder(
      {super.key,
      required this.url,
      this.fit,
      this.height = 16,
      this.width = 9,
      this.callbackFinish});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UnicornCache.getFilesCacheManager(url: url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.hexagonDots(
              color: Colors.white, size: 50);
        } else if (snapshot.hasError) {
          // If there's an error, show a default image
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text("Error :${snapshot.error}",style: TextStyle(color: Colors.white),)),
          ); // Fallback asset image
        } else if (!snapshot.hasData) {
          // If the image is loaded, display it
          return SvgPicture.asset(
            Assets.svgs.errorImage,
            height: 40,
            width: 40,
          );
        }
        return VideoServe(
          url: snapshot.data!.path,
          height: height,
          width: width,
          callbackFinish: callbackFinish,
        );
      },
    );
  }
}
