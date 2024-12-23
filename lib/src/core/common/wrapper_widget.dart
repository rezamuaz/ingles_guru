import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

class WrapperWidget extends StatelessWidget {
  const WrapperWidget({super.key,required  this.page,this.providers});
  final Widget page;
  final List<SingleChildWidget>? providers;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: providers??[], child: page);
  }
}