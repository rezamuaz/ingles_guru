import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/local_storage/cache/cache.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/button.dart';

class AdvanceLessonItemWidget extends StatelessWidget {
  const AdvanceLessonItemWidget(
      {super.key,
      this.onTapConversation,
      this.onTapLearningAds,
      this.onTapQuiz,
      this.url,
      this.title,
      this.isPremium = false,
      this.buttonTitle,
      this.description,
      required this.lessonCode,
      required this.index});
  final VoidCallback? onTapConversation;
  final VoidCallback? onTapQuiz;
  final VoidCallback? onTapLearningAds;
  final String lessonCode;
  final String? url;
  final String? buttonTitle;
  final String? title;
  final bool isPremium;
  final String? description;
  final int index;

  @override
  Widget build(BuildContext context) {
    return title!.isNotEmpty
        ? Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.20),
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                //Image
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.28),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black54, width: 1.5)),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(6, 6)),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: url ?? "",
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
                        // Overlay Locked Lesson
                        isPremium
                            ? const SizedBox()
                            : index > 1
                                ? Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black87.withOpacity(0.6)),
                                    child: SvgPicture.asset(
                                      Assets.svgs.lock,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const SizedBox(),
                        // Lesson Complete Sign
                        StreamBuilder<bool>(
                            stream: context
                                .read<ProgressRepository>()
                                .getLessonProgressStream(lessonCode),
                            builder: (context, snapshot) {
                              // Handle loading state
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              }

                              // Handle error state
                              if (snapshot.hasError) {
                                return const SizedBox();
                              }

                              // Handle no data state
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              }

                              return snapshot.data!
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: Colors.white),
                                                bottom: BorderSide(
                                                    color: Colors.white)),
                                            color: Color(0xFF00CC44),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.elliptical(6, 6))),
                                        child: const Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ))
                                  : const SizedBox();
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Arrow Button
                          Expanded(
                            child: Text(
                              "$title",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.inter(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Button(
                            backgroundColor: Colors.white,
                            widget: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                      Flexible(
                        child: InkWell(
                          child: Text(
                            description ?? "",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: InkWell(
                                onTap: onTapLearningAds,
                                child: Container(
                                    alignment: Alignment.center,
                                    constraints: const BoxConstraints(
                                        maxHeight: 28, minWidth: 88),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(221, 63, 42,
                                                42), // Shadow color with opacity
                                            offset: Offset(-1,
                                                1), // Shadow position (x, y)

                                            spreadRadius:
                                                0.5, // How much the shadow spreads
                                          ),
                                        ],
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        border:
                                            Border.all(color: Colors.black87),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Learning Aids",
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87),
                                        ),
                                        const Icon(
                                          Icons.open_in_new,
                                          size: 18,
                                        )
                                      ],
                                    )),
                              )),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, right: 2),
                                    child: InkWell(
                                      onTap: onTapConversation,
                                      child: Container(
                                          alignment: Alignment.center,
                                          constraints: const BoxConstraints(
                                              maxHeight: 28, minWidth: 88),
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      221,
                                                      63,
                                                      42,
                                                      42), // Shadow color with opacity
                                                  offset: Offset(-1,
                                                      1), // Shadow position (x, y)

                                                  spreadRadius:
                                                      0.5, // How much the shadow spreads
                                                ),
                                              ],
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              border: Border.all(
                                                  color: Colors.black87),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Conversations",
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )),
                                    )),
                              ),
                              Expanded(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, left: 2),
                                    child: InkWell(
                                      onTap: onTapQuiz,
                                      child: Container(
                                          alignment: Alignment.center,
                                          constraints: const BoxConstraints(
                                              maxHeight: 28, minWidth: 88),
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      221,
                                                      63,
                                                      42,
                                                      42), // Shadow color with opacity
                                                  offset: Offset(-1,
                                                      1), // Shadow position (x, y)

                                                  spreadRadius:
                                                      0.5, // How much the shadow spreads
                                                ),
                                              ],
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              border: Border.all(
                                                  color: Colors.black87),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Quiz",
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
