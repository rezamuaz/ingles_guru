import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sysbit/src/core/local_storage/cache/cache.dart';
import 'package:sysbit/src/features/introduction_page/presentation/widget/introduction_player.dart';

import 'package:sysbit/src/features/root_page/presentation/cubit/navbar_view_cubit.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({
    super.key,
  });

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
// late BetterPlayerController _betterPlayerController;
//     final stream = UnicornCache.instance.getFileStream("");

  // Future<void> _initializePlayer() async {
  //   final fileStream = await UnicornCache.instance.getFileStream(url);
  //   final file = (await fileStream.first);

  //   BetterPlayerDataSource dataSource = BetterPlayerDataSource.file(file.originalUrl);

  //   _betterPlayerController = BetterPlayerController(
  //     BetterPlayerConfiguration(
  //       autoPlay: true,
  //       looping: true,
  //     ),
  //   )..setupDataSource(dataSource);
  // }
  @override
  void initState() {
    // _initializePlayer();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    WakelockPlus.toggle(enable: true);
    context.read<NavbarViewCubit>().change(state: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<NavbarViewCubit>().change(state: true);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Center(
            child: Stack(
          children: [
            FutureBuilder<File?>(
              future: UnicornCache.getFilesCacheManager(
                  url: "https://f003.backblazeb2.com/file/igstorage/INT.mp4"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If there's an error, display an error message
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData && snapshot.data != null) {
                  return IntroductionPlayer(
                    localUrl: snapshot.data!.path,
                  );
                }

                return const Center(child: Text("Error loading video"));
              },
            )
          ],
        )),
      ),
    );
  }
}

class DialogWidget extends StatelessWidget {
  final ValueNotifier<double> valueNotifier;

  const DialogWidget({super.key, required this.valueNotifier});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Data Download"),
      content: ValueListenableBuilder<double>(
        valueListenable: valueNotifier,
        builder: (context, progress, child) {
          return LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.amber,
              color: Colors.blue,
              minHeight: 30);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
