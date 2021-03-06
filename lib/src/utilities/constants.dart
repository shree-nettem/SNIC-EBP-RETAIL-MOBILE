import 'package:ebpv2/src/models/language_model.dart';
import 'package:ebpv2/src/views/ui/startup/country_code_model.dart';

import 'images.dart';

class Constants {
  static const String APP_NAME = 'SNIC EBP';
  static const String BASE_URL = "http://20.203.8.34";
  static const String BASE_FILE_URL = "http://20.86.100.62/Files/Photos/";
  static const String FONT_PROXIMA_NOVA = 'PROXIMA_NOVA';
  static const String FONT_SF_UI_DISPLAY = 'SF_UI_DISPLAY';
  static const String FONT_SF_UI_TEXT_REGULAR = 'SF_UI_TEXT_REGULAR';
  static const String FONT_SF_UI_TEXT_MEDIUM = 'SF_UI_TEXT_MEDIUM';
  static const String benefitIGEFields = "IGAFields";

  static List<CountryCodeResult> baseCountryCodesFromApi = [];
  static List<String> baseCountries = [
    'Select',
    'Afghan',
    'Albanian',
    'Algerian',
    'American',
    'Andorran',
    'Angolan',
    'Antiguans',
    'Argentinean',
    'Armenian',
    'Australian',
    'Austrian',
    'Azerbaijani',
    'Bahamian',
    'Bahraini',
    'Bangladeshi',
    'Barbadian',
    'Barbudans',
    'Batswana',
    'Belarusian',
    'Belgian',
    'Belizean',
    'Beninese',
    'Bhutanese',
    'Bolivian',
    'Bosnian',
    'Brazilian',
    'British',
    'Bruneian',
    'Bulgarian',
    'Burkinabe',
    'Burmese',
    'Burundian',
    'Cambodian',
    'Cameroonian',
    'Canadian',
    'Cape Verdean',
    'Central African',
    'Chadian',
    'Chilean',
    'Chinese',
    'Colombian',
    'Comoran',
    'Congolese',
    'Costa Rican',
    'Croatian',
    'Cuban',
    'Cypriot',
    'Czech',
    'Danish',
    'Djibouti',
    'Dominican',
    'Dutch',
    'East Timorese',
    'Ecuadorean',
    'Egyptian',
    'Emirian',
    'Equatorial Guinean',
    'Eritrean',
    'Estonian',
    'Ethiopian',
    'Fijian',
    'Filipino',
    'Finnish',
    'French',
    'Gabonese',
    'Gambian',
    'Georgian',
    'German',
    'Ghanaian',
    'Greek',
    'Grenadian',
    'Guatemalan',
    'Guinea-Bissauan',
    'Guinean',
    'Guyanese',
    'Haitian',
    'Herzegovinian',
    'Honduran',
    'Hungarian',
    'I-Kiribati',
    'Icelander',
    'Indian',
    'Indonesian',
    'Iranian',
    'Iraqi',
    'Irish',
    'Israeli',
    'Italian',
    'Ivorian',
    'Jamaican',
    'Japanese',
    'Jordanian',
    'Kazakhstani',
    'Kenyan',
    'Kittian and Nevisian',
    'Kuwaiti',
    'Kyrgyz',
    'Laotian',
    'Latvian',
    'Lebanese',
    'Liberian',
    'Libyan',
    'Liechtensteiner',
    'Lithuanian',
    'Luxembourger',
    'Macedonian',
    'Malagasy',
    'Malawian',
    'Malaysian',
    'Maldivian',
    'Malian',
    'Maltese',
    'Marshallese',
    'Mauritanian',
    'Mauritian',
    'Mexican',
    'Micronesian',
    'Moldovan',
    'Monacan',
    'Mongolian',
    'Moroccan',
    'Mosotho',
    'Motswana',
    'Mozambican',
    'Namibian',
    'Nauruan',
    'Nepalese',
    'New Zealander',
    'Ni-Vanuatu',
    'Nicaraguan',
    'Nigerian',
    'Nigerien',
    'North Korean',
    'Northern Irish',
    'Norwegian',
    'Omani',
    'Pakistani',
    'Palauan',
    'Palestinian',
    'Panamanian',
    'Papua New Guinean',
    'Paraguayan',
    'Peruvian',
    'Polish',
    'Portuguese',
    'Qatari',
    'Romanian',
    'Russian',
    'Rwandan',
    'Saint Lucian',
    'Salvadoran',
    'Samoan',
    'San Marinese',
    'Sao Tomean',
    'Saudi',
    'Scottish',
    'Senegalese',
    'Serbian',
    'Seychellois',
    'Sierra Leonean',
    'Singaporean',
    'Slovakian',
    'Slovenian',
    'Solomon Islander',
    'Somali',
    'South African',
    'South Korean',
    'Spanish',
    'Sri Lankan',
    'Sudanese',
    'Surinamer',
    'Swazi',
    'Swedish',
    'Swiss',
    'Syrian',
    'Taiwanese',
    'Tajik',
    'Tanzanian',
    'Thai',
    'Togolese',
    'Tongan',
    'Trinidadian or Tobagonian',
    'Tunisian',
    'Turkish',
    'Tuvaluan',
    'Ugandan',
    'Ukrainian',
    'Uruguayan',
    'Uzbekistani',
    'Venezuelan',
    'Vietnamese',
    'Welsh',
    'Yemenite',
    'Zambian',
    'Zimbabwean'
  ];

  static const List<String> baseOccupation = [
    'Chairman',
    'Vice Chairman',
    'Managing Director',
    'Senior Vice President',
    'Vice President',
    'General Manager',
    'Deputy General Manager',
    'Assistant General Manager',
    'Chief Manager',
    'Senior Manager',
    'Manager',
    'Deputy Manager',
    'Assistant Manager',
    'Senior Officer',
    'Officer',
    'Jr. Officer',
    'Senior Associate',
    'Associate',
    'Jr. Associate',
    'Assistant',
    'Employee'
  ];

  static const List<String> baseBanks = [
    "SELECT",
    'Ahli United Bank (Bahrain) B.S.C. ( c )',
    'Ahli United Bank B.S.C',
    'Al Baraka Islamic Bank B.S.C. (c)',
    'Al-Salam Bank - Bahrain B.S.C.',
    'Arab Bank plc',
    'Bahrain Development Bank B.S.C.',
    'Bahrain Islamic Bank B.S.C.',
    'BBK',
    'BMI Bank B.S.C (c)',
    'BNP Paribas',
    'Citibank N.A.',
    'Credit Libanais SAL ',
    'Eskan Bank',
    'First Abu Dhabi Bank - Bahrain Branch',
    'Future Bank B.S.C. (c)',
    'Gulf International Bank B.S.C.',
    'Habib Bank Limited',
    'HSBC Bank Middle East Limited',
    'ICICI Bank Limited',
    'Ila',
    'Ithmaar Bank B.S.C. ( c )',
    'Khaleeji Commercial Bank B.S.C.',
    'Kuwait Finance House Bahrain  B.S.C. (c)',
    'MashreqBank psc',
    'National Bank of Bahrain BSC',
    'National Bank of Kuwait S.A.K.P',
    'Rafidain Bank',
    'Standard Chartered Bank',
    'State Bank of India',
    'The Housing Bank for Trade and Finance - Jordan',
    'United Bank Limited'
  ];

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: '??????????????',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
