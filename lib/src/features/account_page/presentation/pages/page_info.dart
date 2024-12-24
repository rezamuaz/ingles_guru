import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class PageInfo extends StatelessWidget {
  const PageInfo({super.key, required this.title,required this.htmlContent});
  final String title;
  final String htmlContent; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        automaticallyImplyLeading: false,
      
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(alignment: Alignment.centerLeft,child: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios_rounded))),
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  )),
            ),
           
          ],
        ),
       
      ),body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 15),
        child: HtmlWidget(htmlContent),
      )));
  }
}