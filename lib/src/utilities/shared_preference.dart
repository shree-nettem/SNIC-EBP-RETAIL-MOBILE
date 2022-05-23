import 'package:ebpv2/src/views/ui/auth/login/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final userId = "userId";
  final accessToken = "accessToken";
  final email = "email";
  final password = "password";
  final bioMetricUserId = "bioMetricUserId";
  final bioMetricEmail = "bioMetricEmail";
  final bioMetricPassword = "bioMetricPassword";
  final tokenType = "tokenType";
  final expiresIn = "expiresIn";
  final name = "name";
  final companies = "companies";
  final issued = "issued";
  final expires = "expires";
  final customerId = "CustomerId";
  final String numberOfReferrals = "numberOfReferrals";
  final String referralCode = "referralCode";
  final String savedCompanyId = "SavedCompanyId";
  final String lang = "lang";

  SharedPreferencesHelper._();

  static final SharedPreferencesHelper _shared = SharedPreferencesHelper._();

  factory SharedPreferencesHelper() => _shared;

  setUserId(String value) async {
    (await SharedPreferences.getInstance()).setString(userId, value);
  }

  setCustomerId(String value) async {
    (await SharedPreferences.getInstance()).setString(customerId, value);
  }

  setAccessToken(String value) async {
    (await SharedPreferences.getInstance()).setString(accessToken, value);
  }

  setEmail(String value) async {
    (await SharedPreferences.getInstance()).setString(email, value);
  }

  setPassword(String value) async {
    (await SharedPreferences.getInstance()).setString(password, value);
  }

  setBioMetricUserId(String value) async {
    (await SharedPreferences.getInstance()).setString(bioMetricUserId, value);
  }

  setBioMetricEmail(String value) async {
    (await SharedPreferences.getInstance()).setString(bioMetricEmail, value);
  }

  setBioMetricPassword(String value) async {
    (await SharedPreferences.getInstance()).setString(bioMetricPassword, value);
  }

  setTokenType(String value) async {
    (await SharedPreferences.getInstance()).setString(tokenType, value);
  }

  setExpiresIn(int value) async {
    (await SharedPreferences.getInstance()).setInt(expiresIn, value);
  }

  setName(String value) async {
    (await SharedPreferences.getInstance()).setString(name, value);
  }

  setCompanies(String value) async {
    (await SharedPreferences.getInstance()).setString(companies, value);
  }

  setIssued(String value) async {
    (await SharedPreferences.getInstance()).setString(issued, value);
  }

  setExpires(String value) async {
    (await SharedPreferences.getInstance()).setString(expires, value);
  }

  setReferralCode(String value) async {
    (await SharedPreferences.getInstance()).setString(referralCode, value);
  }

  setNumberOfReferrals(int value) async {
    (await SharedPreferences.getInstance()).setInt(numberOfReferrals, value);
  }

  setCompanyId(String value) async {
    (await SharedPreferences.getInstance()).setString(savedCompanyId, value);
  }

  setLanguagCode(bool value) async {
    (await SharedPreferences.getInstance()).setBool(lang, value);
  }

  // SET USER DETAILS AFTER LOG IN SUCCESSFUL
  static void saveUserDetails(TokenModel userDetails) {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();

    _sharedPreferencesHelper.setAccessToken(userDetails.accessToken);
    _sharedPreferencesHelper.setTokenType(userDetails.tokenType);
    _sharedPreferencesHelper.setExpiresIn(userDetails.expiresIn);
    _sharedPreferencesHelper.setName(userDetails.name);
    _sharedPreferencesHelper.setCompanies(userDetails.companies);
    _sharedPreferencesHelper.setIssued(userDetails.issued);
    _sharedPreferencesHelper.setExpires(userDetails.expires);
    _sharedPreferencesHelper.setCompanyId(userDetails.companyId);
  }

  static void saveAccesstoken(String token) {
    SharedPreferencesHelper _sharedPreferencesHelper =
        SharedPreferencesHelper();

    _sharedPreferencesHelper.setAccessToken(token);
  }

  final keepMeSignedIn = "keepMeSignedIn";
  final isUserNew = "isUserNew";

  setKeepMeSignedIn(bool value) async {
    (await SharedPreferences.getInstance()).setBool(keepMeSignedIn, value);
  }

  setNewUser(bool value) async {
    (await SharedPreferences.getInstance()).setBool(isUserNew, value);
  }

  Future<bool> get isSignedIn async =>
      (await SharedPreferences.getInstance()).getBool(keepMeSignedIn);

  Future<bool> get isNewUser async =>
      (await SharedPreferences.getInstance()).getBool(isUserNew);

  Future<String> get getAccessToken async =>
      (await SharedPreferences.getInstance()).getString(accessToken);

  Future<String> get getName async =>
      (await SharedPreferences.getInstance()).getString(name);

  Future<String> get getUserId async =>
      (await SharedPreferences.getInstance()).getString(userId);

  Future<String> get getCompanyId async =>
      (await SharedPreferences.getInstance()).getString(companies);

  Future<String> get getCustomerId async =>
      (await SharedPreferences.getInstance()).getString(customerId);

  Future<String> get getEmail async =>
      (await SharedPreferences.getInstance()).getString(email);
  Future<String> get getPassword async =>
      (await SharedPreferences.getInstance()).getString(password);

  Future<String> get getBioMetricUserId async =>
      (await SharedPreferences.getInstance()).getString(bioMetricUserId);

  Future<String> get getBioMetricEmail async =>
      (await SharedPreferences.getInstance()).getString(bioMetricEmail);
  Future<String> get getBioMetricPassword async =>
      (await SharedPreferences.getInstance()).getString(bioMetricPassword);

  Future<String> get getReferalCode async =>
      (await SharedPreferences.getInstance()).getString(referralCode);

  Future<int> get getNumberOfReferrals async =>
      (await SharedPreferences.getInstance()).getInt(numberOfReferrals);

  Future<String> get getSavedCompanyId async =>
      (await SharedPreferences.getInstance()).getString(savedCompanyId);

  Future<bool> get getLang async =>
      (await SharedPreferences.getInstance()).getBool(lang);

  // REMOVE USER DETAILS
  removeUserDetails() async {
    (await SharedPreferences.getInstance()).remove(userId);
    (await SharedPreferences.getInstance()).remove(accessToken);
    // (await SharedPreferences.getInstance()).remove(email);
    // (await SharedPreferences.getInstance()).remove(password);
    (await SharedPreferences.getInstance()).remove(tokenType);
    (await SharedPreferences.getInstance()).remove(expiresIn);
    (await SharedPreferences.getInstance()).remove(name);
    (await SharedPreferences.getInstance()).remove(companies);
    (await SharedPreferences.getInstance()).remove(issued);
    (await SharedPreferences.getInstance()).remove(expires);
    (await SharedPreferences.getInstance()).remove(keepMeSignedIn);
    (await SharedPreferences.getInstance()).remove(isUserNew);
    (await SharedPreferences.getInstance()).remove(customerId);
    (await SharedPreferences.getInstance()).remove(referralCode);
    (await SharedPreferences.getInstance()).remove(numberOfReferrals);
    (await SharedPreferences.getInstance()).remove(savedCompanyId);
    (await SharedPreferences.getInstance()).remove(lang);
  }

  removeBiometricLoginData() async {
    (await SharedPreferences.getInstance()).remove(bioMetricEmail);
    (await SharedPreferences.getInstance()).remove(bioMetricPassword);
  }
}
