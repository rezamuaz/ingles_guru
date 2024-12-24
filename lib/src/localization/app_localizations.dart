import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    CountryLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('id')
  ];

  /// Before 24 Hours Guarantee
  ///
  /// In en, this message translates to:
  /// **'b24'**
  String get appTitle;

  /// No description provided for @bodyTitle.
  ///
  /// In en, this message translates to:
  /// **'english'**
  String get bodyTitle;

  /// No description provided for @choiceSchedule.
  ///
  /// In en, this message translates to:
  /// **'choice schedule'**
  String get choiceSchedule;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirm;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'emergency contact'**
  String get emergencyContact;

  /// errField
  ///
  /// In en, this message translates to:
  /// **'invalid {label}!'**
  String errField(String label);

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'forgot password'**
  String get forgotPassword;

  /// No description provided for @formAccountHoldersName.
  ///
  /// In en, this message translates to:
  /// **'account holder\'s name'**
  String get formAccountHoldersName;

  /// No description provided for @formAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'account number'**
  String get formAccountNumber;

  /// No description provided for @formAddress.
  ///
  /// In en, this message translates to:
  /// **'address'**
  String get formAddress;

  /// No description provided for @formBankName.
  ///
  /// In en, this message translates to:
  /// **'bank name'**
  String get formBankName;

  /// No description provided for @formCarBrand.
  ///
  /// In en, this message translates to:
  /// **'Car Brand'**
  String get formCarBrand;

  /// No description provided for @formCardModel.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get formCardModel;

  /// No description provided for @formConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get formConfirmPassword;

  /// No description provided for @formCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register Customer'**
  String get formCustomerTitle;

  /// No description provided for @formDateofBirth.
  ///
  /// In en, this message translates to:
  /// **'date of birth'**
  String get formDateofBirth;

  /// No description provided for @formEmail.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get formEmail;

  /// No description provided for @formEmailSended.
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification code to the email address'**
  String get formEmailSended;

  /// No description provided for @formFullName.
  ///
  /// In en, this message translates to:
  /// **'fullname'**
  String get formFullName;

  /// No description provided for @formIDCard.
  ///
  /// In en, this message translates to:
  /// **'ID Card'**
  String get formIDCard;

  /// No description provided for @formLicensePlate.
  ///
  /// In en, this message translates to:
  /// **'license plate'**
  String get formLicensePlate;

  /// No description provided for @formPassword.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get formPassword;

  /// No description provided for @formProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get formProfilePhoto;

  /// No description provided for @formRelationNumber.
  ///
  /// In en, this message translates to:
  /// **'relation number'**
  String get formRelationNumber;

  /// No description provided for @formSend.
  ///
  /// In en, this message translates to:
  /// **'send'**
  String get formSend;

  /// No description provided for @formUploadAccountBook.
  ///
  /// In en, this message translates to:
  /// **'upload account book'**
  String get formUploadAccountBook;

  /// No description provided for @formUploadIDCard.
  ///
  /// In en, this message translates to:
  /// **'Upload KTP, SIM & KK'**
  String get formUploadIDCard;

  /// No description provided for @formWhatappsNumber.
  ///
  /// In en, this message translates to:
  /// **'whatapps number'**
  String get formWhatappsNumber;

  /// No description provided for @formYearOfVehicleManufacture.
  ///
  /// In en, this message translates to:
  /// **'year of vehicle manufacture'**
  String get formYearOfVehicleManufacture;

  /// No description provided for @labelBack.
  ///
  /// In en, this message translates to:
  /// **'back'**
  String get labelBack;

  /// No description provided for @labelContinue.
  ///
  /// In en, this message translates to:
  /// **'continue'**
  String get labelContinue;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'login'**
  String get login;

  /// No description provided for @loginToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'login to your account'**
  String get loginToYourAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'register'**
  String get register;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'driver registration'**
  String get registerTitle;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'remember password'**
  String get rememberPassword;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'resend code'**
  String get resendCode;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'save'**
  String get save;

  /// No description provided for @termsCondition1.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get termsCondition1;

  /// No description provided for @termsCondition2.
  ///
  /// In en, this message translates to:
  /// **'term and conditions  and Privacy Policy'**
  String get termsCondition2;

  /// validation input not allow to empty
  ///
  /// In en, this message translates to:
  /// **'{name} is required!'**
  String valInputNotEmpty(String name);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SEn();
    case 'id': return SId();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}