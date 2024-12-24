import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/widget/button.dart';

class LessonItemLoading extends StatelessWidget {
  const LessonItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.height * 0.18 ),
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.26),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(6, 6)),
                  child:   Container(width: double.infinity,height: double.infinity,color: Colors.white,)
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Arrow Button
                        Flexible(
                            child: Text(
                          "dolor sdbnb ksdk sdsd",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        const Button(
                          backgroundColor: Colors.white,
                          widget: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                    Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text("Completed 100%",
                        style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w600)),
                                       
                    Text(
                                            "Lorem ipsum odor amet, consectetuer adipiscing elit. Elementum dolor accumsan sodales duis nam ut ridiculus senectus. Sapien platea ipsum nunc scelerisque fusce class aliquet. Proin torquent aenean auctor diam feugiat vehicula. Potenti malesuada laoreet lorem aliquam odio.",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                    fontSize: 12,
                                            ),
                                          ),
                    ],),
                    
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       
                        //Play Buttton
                        Skeleton.leaf(
                           enabled: true,
                          child: Button(
                            callback: () {
                              
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            radius: BorderRadius.circular(10),
                           
                            shape: BoxShape.rectangle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}