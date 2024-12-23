import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/conversation_page/presentation/blocs/speech_checker_bloc.dart';
import 'package:sysbit/src/features/conversation_page/presentation/cubit/speech_text_cubit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/circular_countdown/circular_countdown_time.dart';

typedef MyBuilder = void Function(
    BuildContext context, void Function() soundWave);

class RecorderChildBottomSheet extends StatefulWidget {
  const RecorderChildBottomSheet({super.key, required this.voiceUrl});
  final String voiceUrl;

  @override
  State<RecorderChildBottomSheet> createState() =>
      _RecorderChildBottomSheetState();
}

class _RecorderChildBottomSheetState extends State<RecorderChildBottomSheet> {
  late AudioPlayer player = AudioPlayer();
  final CountDownController _controller = CountDownController();
  SpeechToText? speech;
  late void Function() soundWave;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastStatus = '';
  final bool _logEvents = true;
  double level = 0.0;
  bool finalResult = false;
  bool _listenLoop = false;
  String lastHeard = '';
  StringBuffer totalHeard = StringBuffer();
  bool runningMic = false;
  int totalOriginWord = 0;
  bool showOriginOnWrong = false;
  String originText = "";

  @override
  void didChangeDependencies() {
    final SpeechTextCubit textCubit = BlocProvider.of<SpeechTextCubit>(context);

    originText = textCubit.state;
    setState(() {
      totalOriginWord = Utils.countWords(originText);
    });
    Future.delayed(
      const Duration(milliseconds: 700),
      () => startingRecord(),
    );

    super.didChangeDependencies();
  }

  startingRecord() async {
    if (context.mounted) {
      setState(() {
        runningMic = false;
      });
    }

    var start = await startListening(
      forced: true,
      // callback: () {
      //   _controller.start();
      // },
    );
    if (start) {
      _controller.start();
    }
    if (_controller.getTime() == '0' || _controller.getTime() == '10') {
      _controller.start();
    }
  }

  Future<void> init() async {
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      // print('A stream error occurred: $e');
    });
  }

  void _onStatus(String status) {
    if ('done' == status) {
      // print('onStatus(): $status ');
      startListening();
    }
  }

  Future<bool> startListening({
    bool forced = false,
  }) async {
    if (forced && context.mounted) {
      setState(() {
        _listenLoop = !_listenLoop;
      });
    }
    if (!_listenLoop) return false;
    // print('startListening()');
    speech = SpeechToText();

    bool available = await speech!.initialize(
      onStatus: _onStatus,
      //onError: (val) => print('onError: $val'),
      onError: (val) => onError(val),
      debugLogging: false,
    );
    if (available) {
      //     if (callback != null) {
      //   callback();
      // }
      // print('startListening() -> _available = true');
      await listen();
      return true;
    } else {
      return false;
      // print('startListening() -> _available = false');
    }
  }

  Future listen() async {
    speech!.listen(
      onResult: (val) => onResult(val),
      localeId: "en_US",
    ); // Doesn't do anything
  }

  void onError(SpeechRecognitionError val) async {
    // print('onError(): ${val.errorMsg}');
  }

  void onResult(SpeechRecognitionResult val) async {
    // print('onResult()');
    // print('val.alternates ${val.alternates}');
    if (val.finalResult && context.mounted) {
      setState(() {
        lastHeard = val.recognizedWords;
        totalHeard.write(lastHeard);
        totalHeard.write(" ");
      });
      var heard = Utils.countWords(totalHeard.toString());
      if (heard >= totalOriginWord && context.mounted) {
        setState(() {
          _listenLoop = false;
          _controller.pause();
          _controller.reset();
        });
      }
    }
  }

  @override
  void dispose() {
    if (mounted) {
      SpeechToText().stop();

      player.dispose();
    }

    super.dispose();
  }

  bool donwloadLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechCheckerBloc, SpeechCheckerState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.fromBorderSide(BorderSide(
                width: 2,
                color: state.when(
                    initial: () => Colors.black54,
                    loading: () => Colors.black54,
                    loaded: (data) => data.textColor!,
                    back: (data) => data.textColor!))),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Positioned(
                top: -10,
                left: -10,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //                 SizedBox(
                        //   height: 80,
                        //   width: 80,
                        //   child: PlayButton(
                        //     pauseIcon: Icon(Icons.pause, color: Colors.black, size: 50),
                        //     playIcon: Icon(Icons.play_arrow, color: Colors.black, size: 50),
                        //     onPressed: () {},
                        //   ),
                        // ),
                        BlocConsumer<SpeechCheckerBloc, SpeechCheckerState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () => false,
                              loaded: (data) {
                                if (data.isCorrect) {
                                  Future.delayed(
                                    const Duration(milliseconds: 2500),
                                    () {
                                      if(context.mounted){
                                        Navigator.pop(context);
                                      }
                                      
                                    },
                                  );
                                }

                                if (!data.isCorrect &&
                                    !data.init &&
                                    context.mounted) {
                                  setState(() {
                                    runningMic = true;
                                  });
                                }
                              },
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              initial: () => const CircularProgressIndicator(),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              loaded: (data) => Center(
                                child: Text(
                                  data.text ?? "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      color: data.textColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              orElse: () => const SizedBox(),
                              back: (data) {
                                return data.isCorrect
                                    ? Text(
                                        "Correct",
                                        style: GoogleFonts.inter(
                                            color: Colors.green, fontSize: 16),
                                      )
                                    : showOriginOnWrong
                                        ? Text(
                                            data.origintext ?? "",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                                color: Colors.black54,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            data.text ?? "",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                                color: data.textColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          );
                              },
                            );
                          },
                        ),
                        totalHeard.toString().isEmpty
                            ? const SizedBox()
                            : Text(totalHeard.toString(),
                                style: GoogleFonts.inter(
                                    fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Ai Mic
                      //=============================================================================
                      // BlocBuilder<SpeechCheckerBloc, SpeechCheckerState>(
                      //   builder: (context, state) {
                      //     return state.maybeWhen(
                      //       orElse: () => const SizedBox(),
                      //       back: (data) {
                      //         return data.isCorrect
                      //             ? const SizedBox()
                      //             : showOriginOnWrong?SizedBox(): Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 children: [
                      //                   ElevatedButton(
                      //                       onPressed: () async {},
                      //                       style: ElevatedButton.styleFrom(
                      //                           padding:
                      //                               const EdgeInsets.all(8),
                      //                           foregroundColor:
                      //                               Colors.black54,
                      //                           backgroundColor: Colors.white,
                      //                           shape: const CircleBorder(
                      //                               side: BorderSide(
                      //                                   color: Colors.black54,
                      //                                   width: 2))),
                      //                       child: Text(
                      //                         "AI",
                      //                         style: GoogleFonts.inter(
                      //                             fontSize: 32),
                      //                       )),
                      //                   SizedBox(
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.3,
                      //                   )
                      //                 ],
                      //               );
                      //       },
                      //     );
                      //   },
                      // ),

                      //  donwloadLoading? LoadingAnimationWidget.staggeredDotsWave(color: Colors.black26, size: 35): ElevatedButton(
                      //             onPressed: () async {
                      //               setState(() {
                      //               donwloadLoading = true;
                      //               });
                      //               var file = await UnicornCache().getFilesCacheManager(url: widget.voiceUrl);
                      //               await player
                      //                   .setFilePath(file!.path);
                      //                setState(() {
                      //               donwloadLoading = false;
                      //               });
                      //               player.play();
                      //             },
                      //             style: ElevatedButton.styleFrom(
                      //                 padding: const EdgeInsets.all(8),
                      //                 foregroundColor: Colors.black54,
                      //                 backgroundColor: Colors.white,
                      //                 shape: const CircleBorder(
                      //                     side: BorderSide(
                      //                         color: Colors.black54,
                      //                         width: 2))),
                      //             child: const Icon(
                      //               Icons.volume_up,
                      //               size: 50,
                      //             )),

                      GestureDetector(
                        onTap: () async {
                          var start = await startListening(
                            forced: true,
                            // callback: () {
                            //   _controller.start();
                            // },
                          );
                          if (start) {
                            _controller.start();
                          }
                          setState(() {
                            showOriginOnWrong = true;
                          });
                          if (_controller.getTime() == '0' ||
                              _controller.getTime() == '10') {
                            _controller.start();
                          }
                        },
                        child: CircularCountDownTimer(
                          duration: 10,
                          initialDuration: 0,
                          controller: _controller,
                          width: 65,
                          height: 65,
                          ringColor: Colors.grey[300]!,
                          ringGradient: null,
                          fillColor: Colors.red[100]!,
                          fillGradient: null,
                          // repeateIcon: runningMic
                          //     ? LoadingAnimationWidget.staggeredDotsWave(
                          //         color: Colors.red, size: 30)
                          //     : const Icon(
                          //         Icons.mic,
                          //         color: Colors.red,
                          //         size: 35,
                          //       ),
                          initialIcon: const Icon(
                            Icons.mic,
                            color: Colors.red,
                            size: 35,
                          ),
                          useIcon: runningMic,
                          backgroundColor: Colors.white,
                          backgroundGradient: null,
                          strokeWidth: 5.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textFormat: CountdownTextFormat.S,
                          isReverse: true,
                          isReverseAnimation: false,
                          isTimerTextShown: true,
                          autoStart: false,
                          //                           timeFormatterFunction: (defaultFormatterFunction, duration) {
                          //     if (duration.inSeconds == 0) {
                          //        return "Start";
                          //     } else {
                          //        return Function.apply(defaultFormatterFunction, [duration]);
                          //     }
                          //  },
                          onComplete: () async {
                            SpeechToText().stop();
                            if (context.mounted) {
                              setState(() {
                                _listenLoop = false;
                              });
                            }

                            await Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                if (context.mounted) {
                                  context.read<SpeechCheckerBloc>().add(
                                      SpeechCheckerEvent.check(
                                          lastword: totalHeard.toString(),
                                          originText: originText));
                                  setState(() {
                                    totalHeard.clear();
                                  });
                                  _controller.reset();
                                  setState(() {
                                    showOriginOnWrong = false;
                                  });
                                }
                              },
                            );
                          },
                          onChange: (String timeStamp) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
