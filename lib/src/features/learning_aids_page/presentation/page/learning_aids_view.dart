import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/features/learning_aids_page/presentation/bloc/learning_aids_bloc.dart';

class LearningAidsView extends StatefulWidget {
  const LearningAidsView({super.key});

  @override
  State<LearningAidsView> createState() => _LearningAidsViewState();
}

class _LearningAidsViewState extends State<LearningAidsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<LearningAidsBloc, LearningAidsState>(
          builder: (context, state) {
            return state.maybeWhen(
              error: (error) => Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [Image.asset(width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.width*0.4,Assets.webp.noInternet.path),Text("Tidak ada internet",style: GoogleFonts.inter(fontSize: 14),),],)),
              orElse: () => SizedBox(),
              loaded: (data) => SingleChildScrollView(
scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Center(
                  child:  CachedNetworkImage(
               

                    imageUrl: data.first.url,
                    
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [Image.asset(width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.width*0.4,Assets.webp.noData.path),Text("Data tidak ditemukan",style: GoogleFonts.inter(fontSize: 14),),],)),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
