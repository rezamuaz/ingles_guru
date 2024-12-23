import 'package:bloc/bloc.dart';



class NavbarViewCubit extends Cubit<bool> {
  NavbarViewCubit() : super(true);
void change({
    bool? state,
   
  }){
    emit(state ??true);
  }

}
