import 'package:flutter/material.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/bottom_sheet/vocab_text_button.dart';

class VocabBottomSheet extends StatefulWidget {
  const VocabBottomSheet({super.key, this.vocabs =const []});
  final List<String> vocabs;
  @override
  State<VocabBottomSheet> createState() => _VocabBottomSheetState();
}

class _VocabBottomSheetState extends State<VocabBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                
               SingleChildScrollView(
                
                scrollDirection: Axis.vertical,
                
                 child: Wrap(alignment: WrapAlignment.center,children: List.generate(widget.vocabs.length,(index) {
                    return  VocabTextButton(text: widget.vocabs[index],);
                  },),),
               ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        child: const Icon(Icons.arrow_back)),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        child: const Icon(Icons.arrow_forward))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
