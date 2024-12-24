import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NavAndRecord extends StatefulWidget {
  NavAndRecord(
      {super.key,
      required this.controller,
      required this.record,
      required this.prevPage,
      required this.nextPage,
      required this.pageNumber,
      required this.totalPage,
      this.curretPage,
      this.isback = false})
      : opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.500,
              0.900,
              curve: Curves.ease,
            ),
          ),
        );
  final Function()? record;
  final int? curretPage;
  // final bool hasSpeech;
  // final bool isListening;
  final void Function()? nextPage;
  final void Function()? prevPage;
  // final double level;
  final Animation<double> opacity;
  final Animation<double> controller;
  final bool isback;
  final String pageNumber;
  final String totalPage;

  @override
  State<NavAndRecord> createState() => _NavAndRecordState();
}

class _NavAndRecordState extends State<NavAndRecord> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.18,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeTransition(
            opacity: widget.opacity,
            child: ElevatedButton(
                onPressed: widget.prevPage,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black54,
                    shape: const CircleBorder()),
                child: widget.curretPage == 0
                    ? const Icon(
                        Icons.menu,
                        size: 36,
                      )
                    : const Icon(
                        Icons.arrow_back,
                        size: 36,
                      )),
          ),
          FadeTransition(
              opacity: widget.opacity,
              child: Text(
                "${widget.pageNumber}/${widget.totalPage}",
                style: GoogleFonts.inter(
                  fontSize: 25,
                ),
              )),
          FadeTransition(
            opacity: widget.opacity,
            child: ElevatedButton(
                onPressed: widget.nextPage,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black54,
                    shape: const CircleBorder()),
                child: widget.isback
                    ? const Icon(
                        Icons.menu,
                        size: 36,
                      )
                    : const Icon(
                        Icons.arrow_forward,
                        size: 36,
                      )),
          )
        ],
      ),
    );
  }
}
