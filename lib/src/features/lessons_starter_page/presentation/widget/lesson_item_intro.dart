import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/src/core/local_storage/cache/cache.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/button.dart';

class LessonItemIntro extends StatefulWidget {
  const LessonItemIntro(
      {super.key,
      this.onTap,
      this.url,
      this.title,
      this.buttonTitle,
      this.number});
  final VoidCallback? onTap;
  final String? url;
  final String? buttonTitle;
  final String? title;
  final String? number;

  @override
  State<LessonItemIntro> createState() => _LessonItemWidgetState();
}

class _LessonItemWidgetState extends State<LessonItemIntro> {
  TextStyle styleReading = GoogleFonts.inter(
      fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black45);
  @override
  Widget build(BuildContext context) {
    return widget.title!.isNotEmpty
        ? Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.18),
            margin: const EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: widget.onTap,
              child: Row(
                children: [
                  //Image
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.26),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black54, width: 1.5)),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(6, 6)),
                      child: CachedNetworkImage(
                        imageUrl: widget.url ?? "",
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
                                "${widget.title}",
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
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Completed 100%",
                            //     style: GoogleFonts.inter(
                            //         fontSize: 12, fontWeight: FontWeight.w600)),
                            // Flexible(
                            //     child: Text(
                            //   "Lorem ipsum odor amet, consectetuer adipiscing elit. Elementum dolor accumsan sodales duis nam ut ridiculus senectus. Sapien platea ipsum nunc scelerisque fusce class aliquet. Proin torquent aenean auctor diam feugiat vehicula. Potenti malesuada laoreet lorem aliquam odio.",
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: GoogleFonts.inter(
                            //     fontSize: 12,
                            //   ),
                            // )),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Expanded(
                            //   flex: 2,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //Chart Button
                            // Button(
                            //   widget: const Icon(
                            //     Icons.leaderboard_sharp,
                            //     color: Colors.white,
                            //     size: 18,
                            //   ),
                            //   radius: BorderRadius.circular(20),
                            //   backgroundColor: Colors.black87,
                            //   callback: () {},
                            // ),
                            // //Video Button
                            // Button(
                            //   widget: const Icon(
                            //     Icons.videocam_rounded,
                            //     color: Colors.white,
                            //     size: 18,
                            //   ),
                            //   radius: BorderRadius.circular(20),
                            //   backgroundColor: Colors.black87,
                            //   callback: widget.callback,
                            // ),
                            //Quiz Button
                            // Material(
                            //     child: InkWell(
                            //         onTap: () {},
                            //         child: Container(
                            //             clipBehavior: Clip.antiAlias,
                            //             decoration: const BoxDecoration(
                            //               shape: BoxShape.circle,
                            //               color: Colors.black87,
                            //             ),
                            //             child: Padding(
                            //               padding: const EdgeInsets.symmetric(horizontal: 0,vertical:6),
                            //               child: Text(
                            //                 "QUIZ",
                            //                 style: GoogleFonts.inter(
                            //                     fontSize: 9,
                            //                     fontWeight: FontWeight.bold,
                            //                     color: Colors.white),
                            //               ),
                            //             ))))
                            //     ],
                            //   ),
                            // ),
                            //Play Buttton
                            Flexible(
                              child: Button(
                                callback: widget.onTap,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                radius: BorderRadius.circular(10),
                                widget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.buttonTitle ?? "",
                                      style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                    const Icon(
                                      Icons.play_arrow,
                                      size: 20,
                                    )
                                  ],
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
