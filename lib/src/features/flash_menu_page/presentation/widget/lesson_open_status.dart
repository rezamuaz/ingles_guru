import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';

import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/flash_card_page/presentation/page/flash_card_page.dart';
import 'package:sysbit/src/features/flash_menu_page/presentation/page/flash_menu_page.dart';
import 'package:sysbit/src/features/lessons_starter_page/data/model/lesson_mod.dart';

class LessonOpenStatus extends StatelessWidget {
  const LessonOpenStatus(
      {super.key,
      required this.title,
      required this.currentLessonCode,
      required this.currentIndex,
      required this.loading,
      required this.unlocked});

  final String title;
  final String currentLessonCode;
  final int currentIndex;
  final bool loading;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
          enabled: loading,
          child: InkWell(
            onTap: () async {
              if(!unlocked) {
                return;
              }
           
              Navigator.of(context)
                  .push(Utils.createRoute(FlashCardPage(
                title: "${currentIndex + 1}.$title",
                lessonCode: currentLessonCode,
              )))
                  .then(
                (value) {
                  bool closed = value;
                  if (closed) {
                    if (context.mounted) {
                      // context.read<LessonBloc>().add(const LessonEvent.started());
                    }
                  }
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 10, left: 30, right: 10, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black87, width: 1)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(        
                        "${currentIndex + 1}.${title}",
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // data.result[index].unlocked !=
                    //         null
                    //     ? lessons.value[index]
                    //             .unlocked!
                    //         ? const SizedBox()
                    //         : SvgPicture.asset(
                    //             Assets.svgs.lock)
                    //     : SvgPicture.asset(
                    //         Assets.svgs.lock),
                    unlocked
                        ? const SizedBox() :SvgPicture.asset(Assets.svgs.lock)
                       
                  ],
                )
            ),
          ),
        );
  }
}
