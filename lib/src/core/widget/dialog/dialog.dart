import 'package:flutter/material.dart';
import 'package:sysbit/src/core/widget/dialog/custom_dialog.dart';

class XDialog {
  static XDialog _instance = new XDialog.internal();

  XDialog.internal();

  factory XDialog() => _instance;

  static void success(BuildContext context,
      {required String title,
      String? okBtnText = "YA",
      String? cancelBtnText = "BATAL",
      String? description,
       VoidCallback? okButton,
      VoidCallback? cancelButton,
       Color okButtonColor = Colors.green,
  Color cancelButtonColor = Colors.black}) {
    showDialog(
      context: context,
      builder: (_) => CustomeDialogOverlay(
        okButtonColor: okButtonColor,
        cancelButtonColor: cancelButtonColor,
        singleButton: true,
        onCancel: cancelButton,
        onSubmit: okButton,
        title: title,
        description: description,
        okBtnText: okBtnText,
        cancelBtnText: cancelBtnText,
      ),
    );
  }

  static void confim(BuildContext context,
      {required String title,
      String? okBtnText = "YA",
      String? cancelBtnText = "TIDAK",
      String? description,
      Widget? customDesc,
      required VoidCallback okButton,
      required VoidCallback cancelButton,
       Color okButtonColor = Colors.green,
  Color cancelButtonColor = Colors.red}) {
    showDialog(
      context: context,
      builder: (_) => CustomeDialogOverlay(
        okButtonColor: okButtonColor,
        cancelButtonColor: cancelButtonColor,
        singleButton: false,
        onCancel: cancelButton,
        onSubmit: okButton,
        customDesc: customDesc,
        title: title,
        description: description,
        okBtnText: okBtnText,
        cancelBtnText: cancelBtnText,
      ),
    );
  }

  static void confimCustom(BuildContext context,
      {required String title,
      String? okBtnText = "YA",
      String? cancelBtnText = "TIDAK",
      String? description,
      required VoidCallback okButton,
      required VoidCallback cancelButton,
       Color okButtonColor = Colors.green,
  Color cancelButtonColor = Colors.red}) {
    showDialog(
      context: context,
      builder: (_) => CustomeDialogOverlay(
        okButtonColor: okButtonColor,
        cancelButtonColor: cancelButtonColor,
        singleButton: false,
        onCancel: cancelButton,
        onSubmit: okButton,
        title: title,
        description: description,
        okBtnText: okBtnText,
        cancelBtnText: cancelBtnText,
      ),
    );
  }
}
