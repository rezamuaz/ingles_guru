import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';

class ChapterItem extends StatefulWidget {
  final String image;
  final String title;
  final double progress;
  final VoidCallback? onTap;
  final bool locked;
  final int? index;
  const ChapterItem(
      {super.key,
      required this.progress,
      required this.image,
      required this.index,
      required this.title,
      this.onTap,
      required this.locked});

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height * 0.17,
        width: double.infinity,
        decoration: BoxDecoration(
          border: widget.locked
              ? Border.all(width: 0)
              : Border.all(color: Colors.black54, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                          alignment: const FractionalOffset(.03, .05),
                          child: Text(
                            "Chapter ${widget.index! + 1}",
                            style: GoogleFonts.patrickHand(fontSize: 20),
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8)),
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: CachedNetworkImageProvider(
                                    widget.image,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.patrickHand(
                          fontSize: 14,
                        ),
                      ),
                      Text("${widget.progress} %",
                          style: GoogleFonts.patrickHand(
                            fontSize: 14,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            widget.locked
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.7)))
                : const SizedBox(),
            widget.locked? Align( alignment: Alignment.center,child: SvgPicture.asset(Assets.svgs.lock)) : const SizedBox()
          ],
        ),
      ),
    );
  }
}
