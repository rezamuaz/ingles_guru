import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/local_storage/entities/progress.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';

class MenuButton extends StatefulWidget {
  const MenuButton(
      {super.key,
      required this.icon,
      this.iconBgColor = Colors.red,
      this.lable = "",
      this.onPress,
      required this.lessonCode,
      required this.ignore});
  final Widget icon;
  final Color iconBgColor;
  final String lable;
  final VoidCallback? onPress;
  final String lessonCode;
  final bool ignore;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
 

  @override
  Widget build(BuildContext context) {
   

    return Material(
      borderRadius: BorderRadius.circular(8),
      child: widget.ignore
          ? InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: widget.onPress,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            color: widget.iconBgColor,
                            border: const Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                                left: BorderSide(color: Colors.black, width: 1),
                                top:
                                    BorderSide(color: Colors.black, width: 1))),
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width * 0.14,
                        child: widget.icon),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            color: Colors.white,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                                right:
                                    BorderSide(color: Colors.black, width: 1),
                                top:
                                    BorderSide(color: Colors.black, width: 1))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.lable,
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : StreamBuilder<Progress?>(
            
           stream: context.read<ProgressRepository>().getProgressStream(widget.lessonCode),
              builder:(context, snapshot) {
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  onTap: check(snapshot)? widget.onPress: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                                color: widget.iconBgColor,
                                border: const Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1),
                                    left: BorderSide(
                                        color: Colors.black, width: 1),
                                    top: BorderSide(
                                        color: Colors.black, width: 1))),
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width * 0.14,
                            child: widget.icon),
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 1),
                                    right: BorderSide(
                                        color: Colors.black, width: 1),
                                    top: BorderSide(
                                        color: Colors.black, width: 1))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.lable,
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  check(snapshot)
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: SvgPicture.asset(
                                            width: 22,
                                            height: 22,
                                            Assets.svgs.blackLock,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
    ));
  }

  bool check(AsyncSnapshot<Progress?>  snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
      return false;
    }else if(snapshot.hasError){
      return false;
    }else if (snapshot.hasData){
      
      var data = snapshot.data;
      if (data?.tutorial != null && data!.tutorial!){
        return true;
      }else{
        return false;
      }
      
    }else{
      return false;
      
    }
  }
}
