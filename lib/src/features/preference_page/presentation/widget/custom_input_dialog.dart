import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeInputDialog extends StatefulWidget {
  const CustomeInputDialog(
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
  State<StatefulWidget> createState() => CustomeInputDialogState();
}

class CustomeInputDialogState extends State<CustomeInputDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<double>? scaleAnimation;
  // Text Editing Controller to manage the input text
  final TextEditingController _controller = TextEditingController();
  // Create a form key to validate the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Variable to hold the entered text
  String _enteredText = '';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Error handling variables
  String? _nameError;

  // Function to validate the form
  void _validateForm() {
    setState(() {
      // Validate all fields in the form
      if (_formKey.currentState!.validate()) {
        Navigator.pop(context);
        widget.onSubmit!();
      } else {
        // Form is not valid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fix the errors')),
        );
      }
    });
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
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Text(
                      widget.title ?? "Are you sure, you want to logout?",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  //Input Text
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _controller, // Connect the controller
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata tidak boleh kosong';
                          } else if (value != "DELETE") {
                            return 'Kata harus sama';
                          }
                          return null; // No error
                        },
                        onChanged: (value) {
                          // Reset error when user types in the field
                          setState(() {
                            _nameError = null;
                          });
                        },
                        decoration: InputDecoration(
                          errorText: _nameError, // Display error message here,
                          hintText: "DELETE",
                          hintStyle:
                              TextStyle().copyWith(color: Colors.black26),

                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  //Confimation text
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Semantics(
                      excludeSemantics: true,
                      label: "Setuju dengan",
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "ketik",
                            style: GoogleFonts.inter(
                                fontSize: 14, color: Colors.black54),
                            children: <TextSpan>[
                              const TextSpan(text: ' '),
                              TextSpan(
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  text: "DELETE"),
                              TextSpan(
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  text: " "),
                              TextSpan(
                                  style: GoogleFonts.inter(
                                      fontSize: 14, color: Colors.black54),
                                  text: "diatas")
                            ]),
                      ),
                    ),
                  )),

                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Cancel Button
                      widget.singleButton
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  widget.onCancel!();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    constraints: const BoxConstraints(
                                        maxHeight: 40, minWidth: 88),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget
                                                .cancelButtonColor, // Shadow color with opacity
                                            offset: const Offset(-2,
                                                2), // Shadow position (x, y)

                                            spreadRadius:
                                                0.5, // How much the shadow spreads
                                          ),
                                        ],
                                        color: Colors.white,
                                        border: Border.all(
                                            color: widget.cancelButtonColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      widget.cancelBtnText ?? "",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: widget.cancelButtonColor),
                                    )),
                              )),
                      //Confirm Button
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: _validateForm,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    maxHeight: 40, minWidth: 88),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget
                                            .okButtonColor, // Shadow color with opacity
                                        offset: const Offset(
                                            -2, 2), // Shadow position (x, y)

                                        spreadRadius:
                                            0.5, // How much the shadow spreads
                                      ),
                                    ],
                                    color: Colors.white,
                                    border:
                                        Border.all(color: widget.okButtonColor),
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
