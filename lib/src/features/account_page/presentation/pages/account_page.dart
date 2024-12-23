import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/features/account_page/presentation/widget/account_info.dart';
import 'package:sysbit/src/features/account_page/presentation/widget/account_menu.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Account",
                      style: GoogleFonts.inter(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ))),
          ],
        ),
       
      ),
      body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
        
          child: Column(
            children: [Padding(
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: AccountInfo(),
            ),Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AccountMenu(color: Colors.black87,),
            )],
          )),
    );
  }
}
