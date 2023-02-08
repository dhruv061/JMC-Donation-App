import 'language_model.dart';

class AppConstants {
  /*
  localization Data
  */
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: "logo1.png",
        languageName: 'English',
        languageCode: 'english_app',
        countryCode: 'US'),
    LanguageModel(
        imageUrl: 'logo2.png',
        languageName: 'ગુજરાતી',
        languageCode: 'gujrati_app',
        countryCode: 'IN')
  ];
}
