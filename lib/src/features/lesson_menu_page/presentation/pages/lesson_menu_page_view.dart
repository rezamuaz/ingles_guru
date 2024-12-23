import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/src/core/local_storage/cache/cache.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/browser_page/presentation/pages/browser_page.dart';
import 'package:sysbit/src/features/flash_menu_page/presentation/page/flash_menu_page.dart';
import 'package:sysbit/src/features/lesson_menu_page/presentation/widget/menu_button.dart';
import 'package:sysbit/src/features/lesson_menu_page/presentation/widget/menu_header.dart';
import 'package:sysbit/src/features/quiz/presentation/page/quiz_page.dart';
import 'package:sysbit/src/features/scene_page/presentation/pages/scene_page.dart';
import 'package:sysbit/src/features/tutorial_page/presentation/pages/tutorial_page.dart';

class LessonMenuPageView extends StatefulWidget {
  const LessonMenuPageView(
      {super.key,
      required this.lessonCode,
      required this.imageUrl,
      required this.lessonTitle});
  final String lessonCode;
  final String lessonTitle;
  final String imageUrl;

  @override
  State<LessonMenuPageView> createState() => _LessonMenuPageViewState();
}

class _LessonMenuPageViewState extends State<LessonMenuPageView> {
  final double space = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Skeletonizer(
              child: Container(
            color: Colors.white,
          )),
          errorWidget: (context, url, error) => const Center(
              child: Icon(
            Icons.error,
            size: 32,
          )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuHeader(url: widget.imageUrl, title: widget.lessonTitle),
                const SizedBox(
                  height: 20,
                ),
                MenuButton(
                  ignore: true,
                  lessonCode: widget.lessonCode,
                  icon: const Icon(
                    Icons.forum_outlined,
                    color: Colors.white,
                  ),
                  iconBgColor: const Color(0xFFDF2121),
                  lable: "Conversation",
                  onPress: () {
                    Navigator.of(context).push(Utils.createRoute(ScenePage(
                      lessonId: widget.lessonCode,
                    )));
                  },
                ),
                SizedBox(height: space),
                MenuButton(
                  ignore: true,
                  lessonCode: widget.lessonCode,
                  icon: const Icon(
                    Icons.import_contacts_outlined,
                    color: Colors.white,
                  ),
                  iconBgColor: const Color(0xFF42CD2C),
                  lable: "Tutorial",
                  onPress: () async {
                    Navigator.of(context).push(Utils.createRoute(TutorialPage(
                      lessonCode: widget.lessonCode,
                    )));
                  },
                ),
                SizedBox(height: space),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MenuButton(
                      ignore: false,
                      lessonCode: widget.lessonCode,
                      icon: const Icon(
                        Icons.help_outline,
                        color: Colors.white,
                      ),
                      iconBgColor: const Color(0xFF3624DB),
                      lable: "Quiz",
                      onPress: () {
                        Navigator.of(context).push(Utils.createRoute(QuizPage(
                          lessonId: widget.lessonCode,
                        )));
                      },
                    ),
                    SizedBox(height: space),
                    MenuButton(
                      ignore: false,
                      lessonCode: widget.lessonCode,
                      icon: const Icon(
                        Icons.amp_stories_outlined,
                        color: Colors.white,
                      ),
                      iconBgColor: const Color(0xFFDB21AC),
                      lable: "Flash Cards",
                      onPress: () {
                        Navigator.of(context)
                            .push(Utils.createRoute(const FlashMenuPage()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: space),
                MenuButton(
                  ignore: true,
                  lessonCode: widget.lessonCode,
                  icon: const Icon(
                    Icons.medical_services_outlined,
                    color: Colors.white,
                  ),
                  iconBgColor: const Color(0xFFFB5812),
                  lable: "Learning Aids",
                  onPress: () async {
                    Navigator.of(context,rootNavigator: true).push(Utils.zoomOutPageRoute(BrowserPage(title: "Learning Aids", url: "https://inglesguru.com/id/l${widget.lessonCode}")));
                    // await Utils.launchInBrowser(Uri.parse(
                    //     "https://inglesguru.com/id/l${widget.lessonCode}"));
                    //  Navigator.of(context).push(Utils.createRoute(QuizPage(
                    //     lessonId: widget.lessonId,
                    //   )));
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 30,
          child: IconButton.filled(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.white.withOpacity(0.5))),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              )),
        )
      ],
    ));
  }
}
