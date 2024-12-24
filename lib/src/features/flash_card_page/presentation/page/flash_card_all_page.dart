import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/src/core/local_storage/entities/word.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';

import 'package:sysbit/src/core/local_storage/object_box/word_repository.dart';
import 'package:sysbit/src/features/flash_card_page/presentation/bloc/words_bloc.dart';
import 'package:sysbit/src/features/flash_card_page/presentation/widget/flash_card_all_nav.dart';

class FlashCardAllPage extends StatefulWidget {
  const FlashCardAllPage({super.key});

  @override
  State<FlashCardAllPage> createState() => _FlashCardAllPageState();
}

class _FlashCardAllPageState extends State<FlashCardAllPage> {
  final con = FlipCardController();

  int cardIndex = 0;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pop(true);
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WordsBloc(wordRepository: context.read<WordRepository>(),progressRepository: context.read<ProgressRepository>())
            ..add(const WordsEvent.learned()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFC700),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFFFC700),
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "All Lesson Learned",
                          style: GoogleFonts.inter(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ))),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: BlocBuilder<WordsBloc, WordsState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Skeletonizer(
                      enabled:
                          state.status == WordsStateStatus.success ? false : true,
                      child: FlipCard(
                        rotateSide: RotateSide.right,
                        disableSplashEffect: false,
                        splashColor: Colors.orange,
                        onTapFlipping: false,
                        axis: FlipAxis.vertical,
                        controller: con,
                        frontWidget: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black87)),
                              constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.width),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "EN",
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton.filledTonal(
                                          onPressed: () {
                                            context.read<WordsBloc>().add(
                                                const WordsEvent.shuffleLearned());
                                          },
                                          icon: const Icon(Icons.shuffle))
                                    ],
                                  ),
                                  state.words.isNotEmpty
                                      ? Expanded(
                                          child: GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () => con.flipcard(),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      Builder(builder: (context) {
                                                    final Map<String, dynamic>
                                                        word = jsonDecode(state
                                                                .words[cardIndex]
                                                                .word ??
                                                            "");
                                                    return Text(
                                                      word["en"] ?? "",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 22,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    );
                                                  }))))
                                      : const Expanded(
                                          child: Center(
                                              child: Text("No Learning Word"))),
                                  state.words.isNotEmpty
                                      ? FlashCardAllNav(
                                          wordId: state.words[cardIndex].id,
                                          enableNext:
                                              cardIndex < state.words.length - 1
                                                  ? true
                                                  : false,
                                          enablePrev: cardIndex > 0 ? true : false,
                                          buttonColor: Colors.black87,
                                          onNext: () {
                                            if (cardIndex < state.words.length) {
                                              setState(() {
                                                cardIndex = cardIndex + 1;
                                              });
                                            }
                                          },
                                          onPrev: () {
                                            if (cardIndex > 0) {
                                              setState(() {
                                                cardIndex = cardIndex - 1;
                                              });
                                            }
                                          },
                                          onTick: () async {
                                            update(
                                                    state.words[cardIndex]);
                                          },
                                        )
                                      : const SizedBox()
                                ],
                              )),
                        ),
                        backWidget: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black87,
                                  border: Border.all(color: Colors.black87)),
                              constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.width),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "ID",
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      IconButton.filledTonal(
                                          onPressed: () {
                                            context.read<WordsBloc>().add(
                                                const WordsEvent.shuffleLearned());
                                          },
                                          icon: const Icon(Icons.shuffle))
                                    ],
                                  ),
                                  state.words.isNotEmpty
                                      ? Expanded(
                                          child: GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () => con.flipcard(),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      Builder(builder: (context) {
                                                    Map<String, dynamic> word =
                                                        jsonDecode(state
                                                                .words[cardIndex]
                                                                .word ??
                                                            "");
                                                    return Text(
                                                      word["id"] ?? "",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 22,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.white),
                                                    );
                                                  }))))
                                      : const Expanded(
                                          child: Center(
                                              child: Text("No Learning Word"))),
                                  state.words.isNotEmpty
                                      ? FlashCardAllNav(
                                          wordId: state.words[cardIndex].id,
                                          buttonColor: Colors.white,
                                          enableNext:
                                              cardIndex < state.words.length - 1
                                                  ? true
                                                  : false,
                                          enablePrev: cardIndex > 0 ? true : false,
                                          onNext: () {
                                            if (cardIndex <
                                                state.words.length - 1) {
                                              setState(() {
                                                cardIndex = cardIndex + 1;
                                              });
                                            }
                                          },
                                          onPrev: () {
                                            if (cardIndex > 0) {
                                              setState(() {
                                                cardIndex = cardIndex - 1;
                                              });
                                            }
                                          },
                                          onTick: () async {
                                            update(
                                                    state.words[cardIndex]);
                                          },
                                        )
                                      : const SizedBox()
                                ],
                              )),
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),child: Text("Ketuk untuk melihat terjemahan",style: GoogleFonts.inter(fontSize: 14,fontStyle: FontStyle.italic),)),
                    )
                  ],
                );
              },
            )),
          ),
        );
      }),
    );
  }

   void update(Word word) async {
    context.read<WordRepository>().updateWord(word.copyWith(learned: !word.learned));
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
}
