import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/local_storage/entities/progress.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/flash_card_page/presentation/page/flash_card_all_page.dart';
import 'package:sysbit/src/features/flash_card_page/presentation/page/flash_card_page.dart';
import 'package:sysbit/src/features/flash_menu_page/presentation/bloc/flash_menu_bloc.dart';
import 'package:sysbit/src/features/flash_menu_page/presentation/widget/lesson_open_status.dart';
import 'package:sysbit/src/features/lessons_starter_page/data/model/lesson_mod.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/blocs/lesson/lesson_bloc.dart';


class FlashMenuPage extends StatefulWidget {
  const FlashMenuPage({super.key});

  @override
  State<FlashMenuPage> createState() => _FlashMenuPageState();
}

class _FlashMenuPageState extends State<FlashMenuPage> {
  bool loading = true;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlashMenuBloc(progressRepository: context.read<ProgressRepository>())..add(const FlashMenuEvent.started()),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: const Color(0xFFFFC700),
            appBar: AppBar(
              backgroundColor: const Color(0xFFFFC700),
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "FLASH CARD",
                            style: GoogleFonts.inter(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ))),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined))
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async => context.read<FlashMenuBloc >()
                ..add(const FlashMenuEvent.started()),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<FlashMenuBloc, FlashMenuState>(
                      builder: (context, state) {
                        return Skeletonizer(
                          enabled: state.status == FlashStatus.success? false : true,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      Utils.createRoute(
                                          const FlashCardAllPage()));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 30,
                                      right: 10,
                                      top: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black87, width: 1)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "All Lesson Learned",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<FlashMenuBloc, FlashMenuState>(
                        builder: (context, state) {
                      return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return LessonOpenStatus(
                                 unlocked: state.status == FlashStatus.success?  state.lessons[index].unlocked ?? false : false,
                                loading: state.status == FlashStatus.success? false : true,
                                title: state.status == FlashStatus.success? state.lessons[index].title ?? "" :"",
                                currentLessonCode:state.status == FlashStatus.success?  state.lessons[index].lessonCode ?? "":"",
                                currentIndex: index);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(
                                height: 10,
                              ),
                          itemCount: state.lessons.isEmpty? 20: state.lessons.length);
                    })
                  ],
                ),
              ),
            )
         
            );
      }),
    );
  }

  Future<bool> checkCardAlready(List<LessonItem> lessons) async {
    // for (var lesson in lessons) {
    //   var exist = await const HiveService().read<LessonWordOpen>(
    //       boxName: "lessonOpen", key: lesson.lessonCode ?? "");

    //   if (exist == null) {
    //     return false;
    //   } else if (!exist.opened) {
    //     return false;
    //   }
    // }
    return true;
  }

  // Future<bool> allow(String lessonCode) async {
  //   var result = await const HiveService().read<ProgressPage>(
  //       boxName: Keys.progressPageBox,
  //       key: "${Keys.completedTutor}_$lessonCode");
    
  //   if (result != null) {
  //     if (result.opened!) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> allowCardAccess(List<LessonItem> lessons) async {
  //   var ready = await checkCardAlready(lessons);
  //   var completed = await SqfliteService().getUnTickWord();
  //   if (!ready || !completed) {
  //     return false;
  //   }
  //   return true;
  // }
}
