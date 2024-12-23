import 'app_localizations.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([super.locale = 'en']);

  @override
  String get appTitle => 'b24';

  @override
  String get bodyTitle => 'english';

  @override
  String get choiceSchedule => 'choice schedule';

  @override
  String get confirm => 'confirm';

  @override
  String get emergencyContact => 'emergency contact';

  @override
  String errField(String label) {
    return 'invalid $label!';
  }

  @override
  String get forgotPassword => 'forgot password';

  @override
  String get formAccountHoldersName => 'account holder\'s name';

  @override
  String get formAccountNumber => 'account number';

  @override
  String get formAddress => 'address';

  @override
  String get formBankName => 'bank name';

  @override
  String get formCarBrand => 'Car Brand';

  @override
  String get formCardModel => 'Car Model';

  @override
  String get formConfirmPassword => 'Confirm Password';

  @override
  String get formCustomerTitle => 'Register Customer';

  @override
  String get formDateofBirth => 'date of birth';

  @override
  String get formEmail => 'email';

  @override
  String get formEmailSended => 'We have sent a verification code to the email address';

  @override
  String get formFullName => 'fullname';

  @override
  String get formIDCard => 'ID Card';

  @override
  String get formLicensePlate => 'license plate';

  @override
  String get formPassword => 'password';

  @override
  String get formProfilePhoto => 'Profile Photo';

  @override
  String get formRelationNumber => 'relation number';

  @override
  String get formSend => 'send';

  @override
  String get formUploadAccountBook => 'upload account book';

  @override
  String get formUploadIDCard => 'Upload KTP, SIM & KK';

  @override
  String get formWhatappsNumber => 'whatapps number';

  @override
  String get formYearOfVehicleManufacture => 'year of vehicle manufacture';

  @override
  String get labelBack => 'back';

  @override
  String get labelContinue => 'continue';

  @override
  String get login => 'login';

  @override
  String get loginToYourAccount => 'login to your account';

  @override
  String get register => 'register';

  @override
  String get registerTitle => 'driver registration';

  @override
  String get rememberPassword => 'remember password';

  @override
  String get resendCode => 'resend code';

  @override
  String get save => 'save';

  @override
  String get termsCondition1 => 'I agree to the';

  @override
  String get termsCondition2 => 'term and conditions  and Privacy Policy';

  @override
  String valInputNotEmpty(String name) {
    return '$name is required!';
  }
}