import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton(
      {super.key,
      required this.content,
      required this.value,
      required this.onChanged,
      required this.groupValue});
  final String value;
  final Function(String?) onChanged;
  final String groupValue;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RadioListTile<String>(
          contentPadding: const EdgeInsets.only(left: 25, right: 15),
          shape: const StadiumBorder(),
          title: HtmlWidget(content),
          controlAffinity: ListTileControlAffinity.trailing,
          dense: true,
          autofocus: true,
          tileColor: Colors.white,
          toggleable: true,
          value: value,
          activeColor: Colors.black87,
          groupValue: groupValue,
          onChanged: onChanged),
    );

    // Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 3),
    //   child: Material(
    //     borderRadius: BorderRadius.circular(25),
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(25),
    //       onTap: () {},
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         decoration: BoxDecoration(
    //             border: Border.all(width: 1.5, color: Colors.black54),
    //             borderRadius: BorderRadius.circular(25)),
    //         child: Row(
    //           children: [
    //             // Expanded(child: HtmlWidget(content)),

    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
