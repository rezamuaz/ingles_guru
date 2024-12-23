import 'dart:convert';

import 'package:sysbit/objectbox.g.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/local_storage/entities/progress.dart';
import 'package:sysbit/src/core/local_storage/entities/quiz_answer.dart';

class ProgressRepository {
  ProgressRepository({required this.store});
  final Store store;

  /// Upsert [Progress] in the store.
  void addProgress(String lessonCode,{bool? conversation, bool? tutorial, bool? quiz, bool? flash, bool? lesson}) {
   final box=  store.box<Progress>();
    // Query for the existing lesson by lessonCode
  final existingLesson = box.query(Progress_.lessonCode.equals(lessonCode)).build().findFirst();
  if (existingLesson != null) {
    // Update existing progress
    box.put(existingLesson.copyWith( conversation: conversation,tutorial: tutorial,quiz: quiz,flash: flash,lesson: lesson),mode: PutMode.put); // Save the updated progress
  } else {
    // Create a new progress
    box.put(Progress(id: 0,lessonCode: lessonCode,  conversation: conversation,tutorial: tutorial,quiz: quiz, flash: flash,lesson: lesson),mode: PutMode.insert); // Save the new progress
  }
  
  }

  /// Provides a [Stream] of single word.
  Stream<List<Progress>> getAllProgressStream() {
    final query = store.box<Progress>().query();
    // return query.stream();
    return query.watch(triggerImmediately: true).map<List<Progress>>((query) {
      return query.find();
    });
  }

  /// Provides a [Stream] of single word.
  Stream<Progress?> getProgressStream(String lessonCode) {
    final query = store.box<Progress>().query(Progress_.lessonCode.equals(lessonCode));
    // return query.stream();
    return query.watch(triggerImmediately: true).map((query){
      // await Future.delayed(const Duration(milliseconds: 500));
      final result = query.find();

      return result.isNotEmpty ? result.first : null;
    });
  }
   

   void setQuizProgresss(String lessonCode,int quizLength) {
    final quizBox=  store.box<QuizAnswer>();
     final queryQuiz = quizBox.query(QuizAnswer_.lessonCode.equals(lessonCode)).build();
     final quizes = queryQuiz.find();
     queryQuiz.close();
     if(quizes.isNotEmpty && quizes.length == quizLength){
          final progressBox=  store.box<Progress>();
          final existingLesson = progressBox.query(Progress_.lessonCode.equals(lessonCode)).build().findFirst();
          if (existingLesson != null){
            progressBox.put(existingLesson.copyWith( quiz: true),mode: PutMode.put);
          }
          
     }
  }

  /// Provides a [Stream] of single word.
  Stream<bool> getLessonProgressStream(String lessonCode) {
    final progressBox=  store.box<Progress>();
    final query = progressBox.query(Progress_.lessonCode.equals(lessonCode));
    // return query.stream();
    return query.watch(triggerImmediately: true).map((query){
      // await Future.delayed(const Duration(milliseconds: 500));
      final result = query.find();
      if(result.isNotEmpty){
         var progress = result.first;
         if(progress.lesson != null){
              if(progress.lesson!){
                   return true;
              }else{
               
                if(progress.tutorial!){
                       progressBox.put(progress.copyWith(lesson: true));
                       return true;
                }else{
                  return false;
                }
         
              }
             
         }else{
            if(progress.tutorial!){
                       progressBox.put(progress.copyWith(lesson: true));
                       return true;
                }else{
                  return false;
                }
         
         }
      }
      return false;
    });
  }

}
