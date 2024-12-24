import 'app_localizations.dart';

/// The translations for Indonesian (`id`).
class SId extends S {
  SId([super.locale = 'id']);

  @override
  String get appTitle => 'b24';

  @override
  String get bodyTitle => 'english';

  @override
  String get choiceSchedule => 'pilih jadwal';

  @override
  String get confirm => 'konfirmasi';

  @override
  String get emergencyContact => 'kontak darurat';

  @override
  String errField(String label) {
    return '$label tidak valid!';
  }

  @override
  String get forgotPassword => 'lupa password';

  @override
  String get formAccountHoldersName => 'nama pemilik rekening';

  @override
  String get formAccountNumber => 'nomor rekening';

  @override
  String get formAddress => 'alamat';

  @override
  String get formBankName => 'nama bank';

  @override
  String get formCarBrand => 'Merk Kendaraan';

  @override
  String get formCardModel => 'Model Kendaraan';

  @override
  String get formConfirmPassword => 'Konfirmasi Password';

  @override
  String get formCustomerTitle => 'Pendaftaran Pelanggan';

  @override
  String get formDateofBirth => 'tanggal lahir';

  @override
  String get formEmail => 'email';

  @override
  String get formEmailSended => 'kode verifikasi telah dikirim ke email anda';

  @override
  String get formFullName => 'nama lengkap';

  @override
  String get formIDCard => 'NIK';

  @override
  String get formLicensePlate => 'nopol';

  @override
  String get formPassword => 'password';

  @override
  String get formProfilePhoto => 'Foto Profil';

  @override
  String get formRelationNumber => 'Nomor Relasi';

  @override
  String get formSend => 'kirim';

  @override
  String get formUploadAccountBook => 'upload buku rekening';

  @override
  String get formUploadIDCard => 'Upload KTP, SIM & KK';

  @override
  String get formWhatappsNumber => 'no whatapps';

  @override
  String get formYearOfVehicleManufacture => 'Tahun Kendaraan';

  @override
  String get labelBack => 'kembali';

  @override
  String get labelContinue => 'selanjutnya';

  @override
  String get login => 'masuk';

  @override
  String get loginToYourAccount => 'login to your account';

  @override
  String get register => 'daftar';

  @override
  String get registerTitle => 'pendaftaran driver';

  @override
  String get rememberPassword => 'ingat kata sandi';

  @override
  String get resendCode => 'kirim code kembali';

  @override
  String get save => 'simpan';

  @override
  String get termsCondition1 => 'saya setuju';

  @override
  String get termsCondition2 => 'dengan syarat dan ketentuan dan kebijakan privasi';

  @override
  String valInputNotEmpty(String name) {
    return '$name belum diisi!';
  }
}