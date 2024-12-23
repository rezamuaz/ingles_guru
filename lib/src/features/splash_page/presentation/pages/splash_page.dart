
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/root_page/presentation/pages/root_page.dart';
import 'package:sysbit/src/features/signin_page/presentation/blocs/bloc/auth_bloc.dart';
import 'package:sysbit/src/features/signin_page/presentation/pages/signin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
   late AnimationController _controller;
    late AnimationController _controller2;
  late Animation<double> _rotationAnimation;
  // late Animation<double> _bounceAnimation;
  //    late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
     _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

         _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Duration of the bounce cycle
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInOut,
      ),
    );

    // _controller.forward();
    // _controller.addListener(() {
    //   if(_controller.isCompleted){
    //        BlocProvider.of<AuthBloc>(context).add(const AuthEvent.checking());
    //   }
    // },);// Start the animation

      // Create the AnimationController
    // Create the AnimationController
    // Create the AnimationController
   
    // Set up the rotation animation for a Y-axis flip (180 degrees)
    _rotationAnimation = Tween<double>(begin: pi/2, end: 2* pi) // 180 degrees in radians (pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));



   // Apply the bouncing effect using Curves.easeOutBounce
    // _bounceAnimation = Tween<double>(begin: 0, end: -200) // Bounce distance
    //     .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    // Start the animation once
   _controller.forward();
    _controller.addListener(() {
         if(_controller.isCompleted){
           _controller2.forward();
      }
    },);
    _controller2.addListener(() {
         if(_controller2.isCompleted){
           BlocProvider.of<AuthBloc>(context).add(const AuthEvent.checking());
      }
    },);
  
  }

  
  
   @override
  void dispose() {
      _controller.dispose(); // Clean up the controller
      _controller2.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
       state.whenOrNull(isAuthorized: ()async {
      
         Navigator.pushReplacement(context,Utils.createRoute(const RootPage()));
       },unAuthorized: ()async {
       
         Navigator.pushReplacement(context,Utils.createRoute(const SigninPage()));
       },);
      },
      child: Scaffold(
      
        backgroundColor: Theme.of(context).colorScheme.primary,
        // appBar: AppBar(
        //     automaticallyImplyLeading: false,
        //     systemOverlayStyle:
        //         const SystemUiOverlayStyle(statusBarColor: Colors.transparent)),

      
   body: Center(
     child: Container(
      constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width*0.25 ),
       child: Column(
        mainAxisSize: MainAxisSize.min,
         children: [
           Align(
            alignment: Alignment.centerLeft,
             child: FadeTransition(
             opacity: _opacityAnimation,
             child:ScaleTransition(scale: _scaleAnimation,child: SvgPicture.asset(fit: BoxFit.fitWidth,Assets.svgs.dotlogo2)),
             ),
           ),
           AnimatedBuilder(
           animation: _controller,
           builder: (context, child) {
             return Transform(
              transform: Matrix4.rotationY(_rotationAnimation.value),
              alignment: Alignment.center,
              child: child,
            );
           },
           child: SvgPicture.asset(width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.width*0.25,fit: BoxFit.fitWidth,Assets.svgs.logo2),
           ),
         ],
       ),
     ),
   )
        // FadeTransition(
        //      opacity: _opacityAnimation,
        //       child:ScaleTransition(scale: _scaleAnimation,child: SvgPicture.asset(width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.width*0.25,fit: BoxFit.fitWidth,Assets.svgs.logo),)
        //     )
      ),
    );
  }
   
 

 
}
