import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env.prod', useConstantCase: true)
abstract class Env {
  @EnviedField(obfuscate: true)
  static final bool bypassPayment = _Env.bypassPayment;
  @EnviedField(obfuscate: true)
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(obfuscate: true)
  static final String loginEp = _Env.loginEp;
  @EnviedField(obfuscate: true)
  static final String refreshEp = _Env.refreshEp;
  @EnviedField(obfuscate: true)
  static final String starterLessonEp = _Env.starterLessonEp;
  @EnviedField(obfuscate: true)
  static final String advanceLessonEp = _Env.advanceLessonEp;
  @EnviedField(obfuscate: true)
  static final String lessonDetailEp = _Env.lessonDetailEp;
  @EnviedField(obfuscate: true)
  static final String quizEp = _Env.quizEp;
  @EnviedField(obfuscate: true)
  static final String flashCardEp = _Env.flashCardEp;
  @EnviedField(obfuscate: true)
  static final String learningAidsEp = _Env.learningAidsEp;
  @EnviedField(obfuscate: true)
  static final String termConditionsEp = _Env.termConditionsEp;
  @EnviedField(obfuscate: true)
  static final String privacyPolicyEp = _Env.privacyPolicyEp;
  @EnviedField(obfuscate: true)
  static final String paymentHistoryEp = _Env.paymentHistoryEp;
  @EnviedField(obfuscate: true)
  static final String paymentInvoiceEp = _Env.paymentInvoiceEp;
  @EnviedField(obfuscate: true)
  static final String createPaymentEp = _Env.createPaymentEp;
  @EnviedField(obfuscate: true)
  static final String paymentPricesEp = _Env.paymentPricesEp;
  @EnviedField(obfuscate: true)
  static final String updateFcmEp = _Env.updateFcmEp;
  @EnviedField(obfuscate: true)
  static final String userStatusEp = _Env.userStatusEp;
}
