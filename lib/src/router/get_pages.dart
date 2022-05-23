import 'package:ebpv2/src/router/app_routes.dart';
import 'package:ebpv2/src/views/ui/about_us/about_us_screen.dart';
import 'package:ebpv2/src/views/ui/about_us/faqs_screen.dart';
import 'package:ebpv2/src/views/ui/about_us/pdpl_screen.dart';
import 'package:ebpv2/src/views/ui/about_us/privacy_policy.dart';
import 'package:ebpv2/src/views/ui/about_us/terms_screen.dart';
import 'package:ebpv2/src/views/ui/activate_account/account_activate_screen.dart';
import 'package:ebpv2/src/views/ui/auth/change_password/change_password_screen.dart';
import 'package:ebpv2/src/views/ui/auth/forgot_password/forgot_password_screen.dart';
import 'package:ebpv2/src/views/ui/auth/forgot_password/forgot_password_verify_screen.dart';
import 'package:ebpv2/src/views/ui/auth/forgot_password/reset_password/reset_password_screen.dart';
import 'package:ebpv2/src/views/ui/auth/login/login_screen.dart';
import 'package:ebpv2/src/views/ui/auth/profile/complete_profile_screen.dart';
import 'package:ebpv2/src/views/ui/claims/claims_screen.dart';
import 'package:ebpv2/src/views/ui/contact_form/complaint_success_screen.dart';
import 'package:ebpv2/src/views/ui/contact_form/contact_form_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/change_email/change_email_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/change_mobile/change_mobile_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/personal_identification/personal_identification_completed_view.dart';
import 'package:ebpv2/src/views/ui/customer_profile/personal_identification/personal_identification_required_view.dart';
import 'package:ebpv2/src/views/ui/customer_profile/verify_password/verify_password_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/widgets/view_documents_screen.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_retirement/ghady_retirement_details/ghady_retirement_details_screen.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_existing_plan/ghady_saving_beneficiares.dart/saving_beneficiary_view.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_start_saving/ghady_start_saving_home.dart';
import 'package:ebpv2/src/views/ui/help/help_screen.dart';
import 'package:ebpv2/src/views/ui/home/pending_payment_view.dart';
import 'package:ebpv2/src/views/ui/medical_claim/medical_claim_screen.dart';
import 'package:ebpv2/src/views/ui/auth/verification/identity_verification/identity_verification_required/identity_verification_required_screen.dart';

import 'package:ebpv2/src/views/ui/medical_claim/my_claims/edit_claim_screen.dart';
import 'package:ebpv2/src/views/ui/medical_claim/my_claims/my_claims_detail_view.dart';
import 'package:ebpv2/src/views/ui/medical_claim/success_claim_screen.dart';
import 'package:ebpv2/src/views/ui/medical_group/widgets/view_document_share.dart';
import 'package:ebpv2/src/views/ui/motor/motor_insurance/motor_insurance_screen.dart';
import 'package:ebpv2/src/views/ui/notification/webview/notifications_webview.dart';
import 'package:ebpv2/src/views/ui/pay/payment_screen.dart';

import 'package:ebpv2/src/views/ui/plan/plan.dart';
import 'package:ebpv2/src/views/ui/plan/plan_details.dart';
import '../views/ui/auth/verification/complete_registration/complete_registration_screen.dart';
import 'package:ebpv2/src/views/ui/auth/verification/confirm_email/confirm_email_screen.dart';
import 'package:ebpv2/src/views/ui/auth/verification/confirm_phone/confirm_phone_number_screen.dart';
import 'package:ebpv2/src/views/ui/auth/verification/congrats_account_screen.dart';
import 'package:ebpv2/src/views/ui/medical_group/medical_group_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_claim/motor_claim.dart';

import 'package:ebpv2/src/views/ui/motor/motor_renewal/motor_renewal.dart';

import 'package:ebpv2/src/views/ui/medical_ecard/medical_ecard_screen.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_fail_screen.dart';
import 'package:ebpv2/src/views/ui/motor/payment/payment_sucess_screen.dart';
import '../views/ui/auth/verification/identity_verification/identity_verification_screen.dart';

import 'package:ebpv2/src/views/ui/auth/verification/mobile_email_verification_screen.dart';
import 'package:ebpv2/src/views/ui/auth/verification/verify_otp/verify_otp_screen.dart';
import 'package:ebpv2/src/views/ui/auth/welcome/welcome_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_basic_information_screen.dart';
import 'package:ebpv2/src/views/ui/customer_profile/customer_profile_screen.dart';
import 'package:ebpv2/src/views/ui/dashboard/dashboard_binding.dart';
import 'package:ebpv2/src/views/ui/dashboard/dashboard_screen.dart';
import 'package:ebpv2/src/views/ui/e_card/e_plans_screen.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/add_dependent/add_new_dependent_screen.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/dependent_list/employee_dependent_screen.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/dependent/edit_dependent/edit_dependent_screen.dart';
import 'package:ebpv2/src/views/ui/employee_dashboard_profile/employee/employee_dashboard_profile_screen.dart';
import 'package:ebpv2/src/views/ui/employee_profile/employee_profile_screen.dart';
import 'package:ebpv2/src/views/ui/employee_profile/employee_profile_wizard_two_screen.dart';
import 'package:ebpv2/src/views/ui/feedback/feedback_screen.dart';
import 'package:ebpv2/src/views/ui/ghady/ghady_saving_plan/ghady_saving_home_screen.dart';
import 'package:ebpv2/src/views/ui/group_life/group_life_screen.dart';
import 'package:ebpv2/src/views/ui/home/home_screen.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/loyalty_screen.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/loyalty_success_screen.dart';
import 'package:ebpv2/src/views/ui/loyalty_program/transfer_points_screen.dart';
import 'package:ebpv2/src/views/ui/more/more_screen.dart';
import 'package:ebpv2/src/views/ui/more/notification_preference_screen.dart';
import 'package:ebpv2/src/views/ui/motor/motor_renewal/screen/switch_plan.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_life/group_life_screen.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/group_medical_screen.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/medical_network/medical_network_screen.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/medical_network/my_medical_network_screen.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/my_medical_e_cards/medical_e_card_screen.dart';
import 'package:ebpv2/src/views/ui/my_benefits/group_medical/table_of_benefits/table_of_benefits_screen.dart';
import 'package:ebpv2/src/views/ui/my_benefits/my_benefits_screen.dart';
import 'package:ebpv2/src/views/ui/notification/notification_screen.dart';
import 'package:ebpv2/src/views/ui/password/reset_password_link_screen.dart';
import 'package:ebpv2/src/views/ui/pay/pay_bills_screen.dart';
import 'package:ebpv2/src/views/ui/refer/refer_friend_screen.dart';
import 'package:ebpv2/src/views/ui/register/register_screen.dart';
import 'package:ebpv2/src/views/ui/startup/startup_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> getAllPages() {
    return [
      GetPage(
        name: AppRoutes.SPLASH,
        page: () => StartUpScreen(),
      ),
      GetPage(
        name: AppRoutes.LOGIN,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: AppRoutes.REGISTER,
        page: () => RegisterScreen(),
      ),
      GetPage(
        name: AppRoutes.DASHBOARD,
        page: () => DashboardScreen(),
        binding: DashboardBinding(),
      ),
      GetPage(
        name: AppRoutes.ACTIVATE_ACCOUNT,
        page: () => ActivateAccountScreen(),
      ),
      GetPage(
        name: AppRoutes.FORGOT_PASSWORD,
        page: () => ForgotPasswordScreen(),
      ),
      GetPage(
        name: AppRoutes.FORGOT_PASSWORD_VERIFY_OTP,
        page: () => ForgotPasswordVerifyScreen(),
      ),
      GetPage(
        name: AppRoutes.RESET_PASSWORD_LINK,
        page: () => ResetPasswordLinkScreen(),
      ),
      GetPage(
        name: FeedbackScreen.pageId,
        page: () => FeedbackScreen(),
      ),
      GetPage(
        name: EmployeeProfileScreen.pageId,
        page: () => EmployeeProfileScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: EmployeeProfileWizardTwoScreen.pageId,
        page: () => EmployeeProfileWizardTwoScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: EmployeeDashboardProfileScreen.pageId,
        page: () => EmployeeDashboardProfileScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: EmployeeDependentScreen.pageId,
        page: () => EmployeeDependentScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: AddNewDependentScreen.pageId,
        page: () => AddNewDependentScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: EditDependentScreen.pageId,
        page: () => EditDependentScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: MedicalNetworkScreen.pageId,
        page: () => MedicalNetworkScreen(),
      ),
      GetPage(
        name: MyMedicalNetworkScreen.pageId,
        page: () => MyMedicalNetworkScreen(),
      ),
      GetPage(
        name: MyBenefitsScreen.pageId,
        page: () => MyBenefitsScreen(),
      ),
      GetPage(
        name: GroupMedicalScreen.pageId,
        page: () => GroupMedicalScreen(),
      ),
      GetPage(
        name: GroupLifeScreen.pageId,
        page: () => GroupLifeScreen(),
      ),
      GetPage(
        name: MedicalECardScreen.pageId,
        page: () => MedicalECardScreen(),
      ),
      GetPage(
        name: TableOfBenefitsScreen.pageId,
        page: () => TableOfBenefitsScreen(),
      ),
      GetPage(
        name: AppRoutes.HOME,
        page: () => HomeScreen(),
      ),
      GetPage(
        name: AppRoutes.MORE,
        page: () => MoreScreen(),
      ),
      GetPage(
        name: AppRoutes.CHANGE_PASSWORD,
        page: () => ChangePasswordScreen(),
      ),
      GetPage(
        name: AppRoutes.E_PLANS,
        page: () => EPlansScreen(),
      ),
      GetPage(
        name: AppRoutes.REFER_A_FRIEND,
        page: () => ReferFriendScreen(),
      ),
      GetPage(
        name: AppRoutes.NOTIFICATION,
        page: () => NotificationScreen(),
      ),
      GetPage(
        name: AppRoutes.PAY_MY_BILLS,
        page: () => PayBillsScreen(),
      ),
      GetPage(
        name: AppRoutes.ABOUT_SNIC,
        page: () => AboutUsScreen(),
      ),
      GetPage(
        name: AppRoutes.PRIVACY_POLICY,
        page: () => PrivacyPolicyScreen(),
      ),
      GetPage(
        name: AppRoutes.PDPL,
        page: () => PDPLScreen(),
      ),
      GetPage(
        name: AppRoutes.TERMS,
        page: () => TermsScreen(),
      ),
      GetPage(
        name: AppRoutes.FAQS,
        page: () => FAQScreen(),
      ),
      GetPage(
        name: AppRoutes.LOYALTY_HOME,
        page: () => LoyaltyScreen(),
      ),
      GetPage(
        name: AppRoutes.LOYALTY_TRANSFER_POINTS,
        page: () => TransferPointsScreen(),
      ),
      GetPage(
        name: AppRoutes.LOYALTY_TRANSFER_POINTS_SUCCESS,
        page: () => LoyaltySuccessScreen(),
      ),
      GetPage(
        name: AppRoutes.WELCOME,
        page: () => WelcomeScreen(),
      ),
      GetPage(
        name: AppRoutes.MOBILE_EMAIL_VERIFICATION,
        page: () => MobileEmailVerificationScreen(),
      ),
      GetPage(
        name: AppRoutes.CONFIRM_MOBILE_NUMBER,
        page: () => ConfirmPhoneNumberScreen(),
      ),
      GetPage(
        name: AppRoutes.VERIFY_MOBILE_NUMBER,
        page: () => VerifyOTPScreen(),
      ),
      GetPage(
        name: AppRoutes.CONFIRM_EMAIL,
        page: () => ConfirmEmailScreen(),
      ),
      GetPage(
        name: AppRoutes.IDENTITY_VERIFICATION_COMPLETED,
        page: () => IdentityVerificationScreen(),
      ),
      GetPage(
        name: AppRoutes.IDENTITY_VERIFICATION_REQUIRED,
        page: () => IdentityVerificationRequiredScreen(),
      ),
      GetPage(
        name: AppRoutes.PERSONAL_IDENTIFICATION_REQUIRED,
        page: () => PersonalIdentificationRequiredScreen(),
      ),
      GetPage(
        name: AppRoutes.PERSONAL_IDENTIFICATION_COMPLETED,
        page: () => PersonalIdentificationCompletedScreen(),
      ),
      GetPage(
        name: AppRoutes.COMPLETE_PROFILE,
        page: () => CompleteProfileScreen(),
      ),
      GetPage(
        name: AppRoutes.COMPLETE_REGISTRATION,
        page: () => CompleteRegistrationScreen(),
      ),
      GetPage(
        name: AppRoutes.CONGRATS_ACCOUNT,
        page: () => CongratsAccountScreen(),
      ),
      //CustomerProfileScreen
      GetPage(
        name: AppRoutes.CUSTOMER_PROFILE,
        page: () => CustomerProfileScreen(),
      ),
      //CustomerBasicInfoScreen
      GetPage(
        name: AppRoutes.CUSTOMER_BASIC_INFO,
        page: () => CustomerBasicInformationScreen(),
      ),
      GetPage(
        name: AppRoutes.VIEW_DOCUMENTS,
        page: () => ViewDocumentsScreen(),
      ),
      //Group Life Screen
      GetPage(
        name: AppRoutes.GROUP_LIFE_SCREEN,
        page: () => GroupLifeDashBoardScreen(),
      ),

      //Motor Insurance
      GetPage(
        name: AppRoutes.MOTOR_INSURANCE,
        page: () => MotorInsuranceScreen(),
      ),

      //payment success
      GetPage(
        name: AppRoutes.PAYMENT_SUCCESS,
        page: () => PaymentSuccessScreen(),
      ),
      GetPage(
        name: AppRoutes.PAYMENT_FAILED,
        page: () => PaymentFailedScreen(),
      ),

      GetPage(
        name: AppRoutes.MOTOR_RENEWAL,
        page: () => MotorRenewalScreen(),
      ),

      GetPage(
        name: AppRoutes.MEDICAL_ECARD,
        page: () => MedicalEcardScreen(),
      ),
      GetPage(
        name: AppRoutes.RESET_PASSWORD,
        page: () => ResetPasswordScreen(),
      ),
      //Medical Group
      GetPage(name: AppRoutes.MEDICAL_GROUP, page: () => MedicalGroupScreen()),
      GetPage(
        name: AppRoutes.SWITCH_PLAN,
        page: () => SwitchPlan(),
      ),
      GetPage(
        name: AppRoutes.NOTIFICATION_PREFERENCES,
        page: () => NotificationPreferenceScreen(),
      ),
      GetPage(
        name: AppRoutes.GHADY_SAVING_HOME,
        page: () => GhadySavingHomeScreen(),
      ),

      GetPage(
        name: AppRoutes.PLANS,
        page: () => Plans(),
      ),
      GetPage(
        name: AppRoutes.PLAN_DETAILS,
        page: () => PlanDetails(),
      ),
      GetPage(
        name: AppRoutes.MY_CLAIMS_DETAILS,
        page: () => MyClaimsDetailView(),
      ),

      GetPage(
        name: AppRoutes.EDIT_CLAIMS_DETAILS,
        page: () => EditClaimScreen(),
      ),

      GetPage(
        name: AppRoutes.MOTOR_CLAIM,
        page: () => MotorClaim(),
      ),
      GetPage(
        name: AppRoutes.MEDICAL_CLAIM,
        page: () => MedicalClaimScreen(),
      ),
      GetPage(
        name: AppRoutes.CLAIM_SCREEN,
        page: () => ClaimScreen(),
      ),
      GetPage(
        name: AppRoutes.SUCCESS_CLAIM,
        page: () => SuccessClaimScreen(),
      ),
      GetPage(
        name: AppRoutes.CHANGE_EMAIL,
        page: () => ChangeEmailScreen(),
      ),
      GetPage(
        name: AppRoutes.CHANGE_MOBILE,
        page: () => ChangeMobileScreen(),
      ),
      GetPage(
        name: AppRoutes.VERIFY_PASSWORD,
        page: () => VerifyPasswordScreen(),
      ),
      GetPage(
        name: AppRoutes.VIEW_DOCUMENT_SHARE,
        page: () => ViewDocumentAndShareScreen(),
      ),
      GetPage(
        name: AppRoutes.GHADY_START_SAVING_HOME,
        page: () => GhadyStartSavingHomeView(),
      ),
      GetPage(
        name: AppRoutes.GHADY_RETIREMENT_DETAILS,
        page: () => GhadyRetirementDetailsScreen(),
      ),

      GetPage(
        name: AppRoutes.GHADY_BENEFICIERIES_VIEW,
        page: () => SavingBeneficiaryView(),
      ),

      GetPage(
        name: AppRoutes.CONTACT_FORM,
        page: () => ContactFormScreen(),
      ),
      GetPage(
        name: AppRoutes.CONTACT_FORM_SUCCESS,
        page: () => ComplaintSuccessScreen(),
      ),
      GetPage(
        name: AppRoutes.CUSTOM_WEBVIEW,
        page: () => NotificationsWebview(),
      ),
      GetPage(
        name: AppRoutes.HELP_VIEW,
        page: () => HelpScreen(),
      ),
      GetPage(
        name: AppRoutes.GENERALPAYMENTVIEW,
        page: () => GeneralPaymentScreen(),

      ),
      GetPage(
        name: AppRoutes.PENDINGPAYMENTVIEW,
        page: () => PendingPaymentView(),

      ),
    ];
  }
}
