
import 'dart:convert';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/common/error_widget_return.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';

import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/common/widget/page_wrapper.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/payment_bottom.dart';
import 'package:sysbit/src/features/introduction_page/presentation/pages/introduction_page.dart';
import 'package:sysbit/src/features/lesson_menu_page/presentation/pages/lesson_menu_page.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/lesson_item_intro.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/lesson_item_loading.dart';
import 'package:sysbit/src/features/lessons_starter_page/data/model/lesson_mod.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/blocs/lesson/lesson_bloc.dart';

import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/lesson_item.dart';

class StarterLessonsPage extends StatefulWidget {
  const StarterLessonsPage({
    super.key,
  });

  @override
  State<StarterLessonsPage> createState() => _StarterLessonsPageState();
}

class _StarterLessonsPageState extends State<StarterLessonsPage> {



  LessonItem intro = const LessonItem(
    title: "introduction",
  );
  

  @override
  Widget build(BuildContext context) {
    

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonBloc()..add(const LessonEvent.starterPack()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.amber,
            body: PageWrapper(
              bodyItem:   Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<LessonBloc>()
                                    .add(const LessonEvent.starterPack());
                              },
                              child: BlocConsumer<LessonBloc, LessonState>(
                                listener: (context, state) {
                                  state.whenOrNull(
                                    loaded: (data) {
                                      setState(() {
                                        intro = data.intro;
                                      });
                                    },
                                    
                                  );
                                },
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    // orElse: () => SizedBox(),
                                    loading: () => Skeletonizer(
                                      enabled: true,
                                      child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                         physics: BouncingScrollPhysics(),
                                         shrinkWrap: true,
                                          separatorBuilder: (context, index) =>
                                              const Divider(
                                                color: Colors.black26,
                                              ),
                                          itemCount: 5,
                                          itemBuilder: (context, index) =>
                                              const LessonItemLoading()),
                                    ),
                                    orElse: () => const Center(
                                      child: Text("unknown error"),
                                    ),
                                    error: (error) => Center(
                                        child: errorWidget(error,
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: Colors.black87))),
                                    loaded: (data) => ListView(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(0),
                                      children: [
                                        // LessonItemIntro(
                                        //   buttonTitle: "See More",
                                        //   title:
                                        //       data.intro.title!.toUpperCase(),
                                        //   url: data.intro.image,
                                        //   onTap: () async {
                                        //     Navigator.of(context).push(
                                        //         Utils.createRoute(
                                        //             const IntroductionPage()));
                                        //   },
                                        // ),
                                        // const Divider(
                                        //   color: Colors.black54,
                                        // ),
                                         SharedBuilder(
                          listenKeys: const {"auth"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                            return ListView.separated(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount: data.result.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder: (context, index) =>
                                                const Divider(
                                              color: Colors.black54,
                                            ),
                                            itemBuilder: (context, index) =>
                                                LessonItemWidget(
                                              index: index,
                                              lessonCode: data.result[index].lessonCode??"",
                                              isPremium: Utils.getToken(encryptedSharedPreferences).role.contains("starter"),
                                              buttonTitle: "Lesson ${index + 1}",
                                              description:
                                                  data.result[index].description,
                                              title:
                                                  "${index + 1}.${data.result[index].title!.toUpperCase()}",
                                              url: data.result[index].image,
                                              onTaPForPay: () async {
                                                await showCustomModalBottomSheet(
                                                    context);
                                              },
                                              onTaPContent: () async {
                                                Navigator.of(context,rootNavigator: true).push(Utils.createRoute(
                                                        LessonMenuPage(
                                                      lessonId: data.result[index]
                                                              .lessonCode ??
                                                          "",
                                                      imageUrl: data.result[index]
                                                              .image ??
                                                          '',
                                                      lessonTitle:
                                                          "${index + 1}. ${data.result[index].title!.toUpperCase()}",
                                                    )));
                                               
                                                //   }
                                                // }
                                              },
                                            ),
                                          );
                          },
                        ),
                                       
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
            ));
      }),
    );
  }

  

  Future<bool?> showCustomModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const PaymentBottom();
      },
    );
  }
}
