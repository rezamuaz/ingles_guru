import 'package:bloc/bloc.dart';


class SpeechTextCubit extends Cubit<String> {
  SpeechTextCubit() : super("");


   void change({
    String? newText,
   
  }){
    emit(newText ??"");
  }
}
