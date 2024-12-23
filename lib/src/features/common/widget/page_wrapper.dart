
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
import 'package:sysbit/src/features/home_page/presentation/widget/payment_bottom.dart';
import 'package:sysbit/src/features/introduction_page/presentation/pages/introduction_page.dart';
import 'package:sysbit/src/features/lesson_menu_page/presentation/pages/lesson_menu_page.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/lesson_item_intro.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/lesson_item_loading.dart';
import 'package:sysbit/src/features/lessons_starter_page/data/model/lesson_mod.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/blocs/lesson/lesson_bloc.dart';

import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/lesson_item.dart';

class PageWrapper extends StatelessWidget {
  final List<Widget>? headersItem;
  final Widget? bodyItem;
 
  final String title;
  const PageWrapper({
    super.key,
    this.title = "ingles guru",
    this.headersItem,
    this.bodyItem,
  
  });
  
  @override
  Widget build(BuildContext context) {
    

    return Builder(builder: (context) {
      return Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  padding:
                      const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: headersItem?? [  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.svgs.logo,
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.6),
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                title.toUpperCase(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  letterSpacing: 1.2,
                                  wordSpacing: 1.2,
                                  fontSize: 30,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),],
                  )),
              
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 10, top: 10, right: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(15, 15),
                            topRight: Radius.elliptical(15, 15)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                        constraints: BoxConstraints(maxHeight: 40),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [TextButton.icon(onPressed: () {
                                          Navigator.pop(context);
                                        }, label: Text(
                                    "Back",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),icon: Icon(Icons.arrow_back_ios,color: Colors.black87,))],),
                      ),
                        bodyItem?? SizedBox.shrink()
                      ],
                    )),
              )
            ],
          );
    });
  }
}
