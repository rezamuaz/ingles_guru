import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerEmpty extends StatefulWidget {
  const AnswerEmpty(
      {super.key,
     
      required this.idx,
      required this.question,
      required this.context,
});
  final String question;
  final String context;
  final int? idx;


  @override
  State<AnswerEmpty> createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerEmpty>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> expanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black54, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Question #${widget.idx}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
             
             
            ],
          ),
           const SizedBox(height: 10,),
          Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color:  Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Please, Submit your answer!",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                     
                      color: Colors.white,
                     ),
                  ),
                ), 
        ],
      ),
    );
  }
}
