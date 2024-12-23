import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeDialogOverlay extends StatefulWidget {
  const CustomeDialogOverlay(
      {super.key,
      this.onCancel,
      this.onSubmit,
      this.title,
      this.description,
      this.cancelBtnText,
      required this.singleButton,
      required this.cancelButtonColor,
      required this.okButtonColor,
      this.customDesc,
      this.okBtnText});
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  final String? okBtnText;
  final String? cancelBtnText;
  final String? title;
  final String? description;
  final Widget? customDesc;
  final bool singleButton;
  final Color okButtonColor;
  final Color cancelButtonColor;

  @override
  State<StatefulWidget> createState() => CustomeDialogOverlayState();
}

class CustomeDialogOverlayState extends State<CustomeDialogOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.only(bottom: 15),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: Text(
                      widget.title ?? "Are you sure, you want to logout?",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  )),
                 widget.customDesc != null? widget.customDesc! :  widget.description != null
                      ? Flexible(
                          child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0),
                          child: Text(
                            widget.description ??
                                "lorem inpum dileo apkpmk sdns",
                            style: GoogleFonts.inter(
                                fontSize: 14, color: Colors.black87),
                            textAlign: TextAlign.center,

                          ),
                        ))
                      : const SizedBox.shrink(),
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Cancel Button
                     widget.singleButton? const SizedBox.shrink() :  Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap:() {
                               Navigator.pop(context);
                               widget.onCancel!();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                constraints:
                                    const BoxConstraints(maxHeight: 40, minWidth: 88),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.cancelButtonColor, // Shadow color with opacity
                                        offset: const Offset(
                                            -2, 2), // Shadow position (x, y)
                            
                                        spreadRadius:
                                            0.5, // How much the shadow spreads
                                      ),
                                    ],
                                    color: Colors.white,
                                    border: Border.all(color: widget.cancelButtonColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  widget.cancelBtnText ?? "",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: widget.cancelButtonColor),
                                )),
                          )) ,
                      //Confirm Button
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              
                              Navigator.pop(context);
                              widget.onSubmit!();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                constraints:
                                    const BoxConstraints(maxHeight: 40, minWidth: 88),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.okButtonColor, // Shadow color with opacity
                                        offset: const Offset(
                                            -2, 2), // Shadow position (x, y)
                            
                                        spreadRadius:
                                            0.5, // How much the shadow spreads
                                      ),
                                    ],
                                    color: Colors.white,
                                    border: Border.all(color: widget.okButtonColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  widget.okBtnText ?? "",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: widget.okButtonColor),
                                )),
                          )),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
