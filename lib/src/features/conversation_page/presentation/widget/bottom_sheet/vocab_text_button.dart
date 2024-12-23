import 'package:flutter/material.dart';

class VocabTextButton extends StatelessWidget {
  const VocabTextButton({super.key, this.text = ""});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
      child: Material(
         
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () {
            
          },
          splashColor: Colors.white,
          child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                decoration: BoxDecoration(
          
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}