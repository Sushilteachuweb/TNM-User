import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('mr'),
    Locale('pa'),
  ];

  /// No description provided for @selectYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Your Language'**
  String get selectYourLanguage;

  /// No description provided for @moreLanguagesComingSoon.
  ///
  /// In en, this message translates to:
  /// **'More languages will be added soon!'**
  String get moreLanguagesComingSoon;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @rozgarDigitalSaathi.
  ///
  /// In en, this message translates to:
  /// **'Rozgar ka Digital Saathi'**
  String get rozgarDigitalSaathi;

  /// No description provided for @jobSearchPartner.
  ///
  /// In en, this message translates to:
  /// **'Your Job Search Partner'**
  String get jobSearchPartner;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @searchJobs.
  ///
  /// In en, this message translates to:
  /// **'Search Jobs'**
  String get searchJobs;

  /// No description provided for @featuredJobs.
  ///
  /// In en, this message translates to:
  /// **'Featured Jobs'**
  String get featuredJobs;

  /// No description provided for @nearbyJobs.
  ///
  /// In en, this message translates to:
  /// **'Nearby Jobs'**
  String get nearbyJobs;

  /// No description provided for @careerDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Career Development'**
  String get careerDevelopment;

  /// No description provided for @jobCategories.
  ///
  /// In en, this message translates to:
  /// **'Job Categories'**
  String get jobCategories;

  /// No description provided for @allJobs.
  ///
  /// In en, this message translates to:
  /// **'All Jobs'**
  String get allJobs;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @jobDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get jobDetails;

  /// No description provided for @companyDetails.
  ///
  /// In en, this message translates to:
  /// **'Company Details'**
  String get companyDetails;

  /// No description provided for @requirements.
  ///
  /// In en, this message translates to:
  /// **'Requirements'**
  String get requirements;

  /// No description provided for @responsibilities.
  ///
  /// In en, this message translates to:
  /// **'Responsibilities'**
  String get responsibilities;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your job search'**
  String get signInToContinue;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @enter10DigitNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter 10-digit number'**
  String get enter10DigitNumber;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the terms and conditions to log in to the app'**
  String get agreeToTerms;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone Number'**
  String get verifyPhoneNumber;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @weSentCodeTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a 4-digit code to'**
  String get weSentCodeTo;

  /// No description provided for @changePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get changePhoneNumber;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCode;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @workExperience.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get workExperience;

  /// No description provided for @iAmFresher.
  ///
  /// In en, this message translates to:
  /// **'I am a fresher'**
  String get iAmFresher;

  /// No description provided for @iHaveExperience.
  ///
  /// In en, this message translates to:
  /// **'I have experience'**
  String get iHaveExperience;

  /// No description provided for @tenthPass.
  ///
  /// In en, this message translates to:
  /// **'10th Pass'**
  String get tenthPass;

  /// No description provided for @twelfthPass.
  ///
  /// In en, this message translates to:
  /// **'12th Pass'**
  String get twelfthPass;

  /// No description provided for @diploma.
  ///
  /// In en, this message translates to:
  /// **'Diploma'**
  String get diploma;

  /// No description provided for @graduate.
  ///
  /// In en, this message translates to:
  /// **'Graduate'**
  String get graduate;

  /// No description provided for @postGraduate.
  ///
  /// In en, this message translates to:
  /// **'Post Graduate'**
  String get postGraduate;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @selectSkills.
  ///
  /// In en, this message translates to:
  /// **'Select Skills'**
  String get selectSkills;

  /// No description provided for @addYourSkills.
  ///
  /// In en, this message translates to:
  /// **'Add Your Skills'**
  String get addYourSkills;

  /// No description provided for @typeCustomSkill.
  ///
  /// In en, this message translates to:
  /// **'Type a custom skill...'**
  String get typeCustomSkill;

  /// No description provided for @popularSkills.
  ///
  /// In en, this message translates to:
  /// **'Popular Skills'**
  String get popularSkills;

  /// No description provided for @selectedSkills.
  ///
  /// In en, this message translates to:
  /// **'Selected Skills'**
  String get selectedSkills;

  /// No description provided for @iWantJob.
  ///
  /// In en, this message translates to:
  /// **'I want a Job'**
  String get iWantJob;

  /// No description provided for @iWantToHire.
  ///
  /// In en, this message translates to:
  /// **'I want to Hire'**
  String get iWantToHire;

  /// No description provided for @chooseCareerPath.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Career Path'**
  String get chooseCareerPath;

  /// No description provided for @selectJobCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a job category that matches your skills'**
  String get selectJobCategory;

  /// No description provided for @searchJobCategories.
  ///
  /// In en, this message translates to:
  /// **'Search job categories...'**
  String get searchJobCategories;

  /// No description provided for @experienceLevel.
  ///
  /// In en, this message translates to:
  /// **'Experience Level'**
  String get experienceLevel;

  /// No description provided for @imExperienced.
  ///
  /// In en, this message translates to:
  /// **'I\'m Experienced'**
  String get imExperienced;

  /// No description provided for @imFresher.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Fresher'**
  String get imFresher;

  /// No description provided for @experienceDetails.
  ///
  /// In en, this message translates to:
  /// **'Experience Details'**
  String get experienceDetails;

  /// No description provided for @selectExperienceLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Experience Level'**
  String get selectExperienceLevel;

  /// No description provided for @currentSalary.
  ///
  /// In en, this message translates to:
  /// **'Current Salary (₹)'**
  String get currentSalary;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @fresher.
  ///
  /// In en, this message translates to:
  /// **'Fresher'**
  String get fresher;

  /// No description provided for @experienced.
  ///
  /// In en, this message translates to:
  /// **'Experienced'**
  String get experienced;

  /// No description provided for @selectJobType.
  ///
  /// In en, this message translates to:
  /// **'Select Job Type'**
  String get selectJobType;

  /// No description provided for @areYouFresher.
  ///
  /// In en, this message translates to:
  /// **'Are you a fresher or experienced?'**
  String get areYouFresher;

  /// No description provided for @fresherDescription.
  ///
  /// In en, this message translates to:
  /// **'New to the job market'**
  String get fresherDescription;

  /// No description provided for @experiencedDescription.
  ///
  /// In en, this message translates to:
  /// **'Have work experience'**
  String get experiencedDescription;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @exploreJobs.
  ///
  /// In en, this message translates to:
  /// **'Explore Jobs'**
  String get exploreJobs;

  /// No description provided for @findYourDreamJob.
  ///
  /// In en, this message translates to:
  /// **'Find Your Dream Job'**
  String get findYourDreamJob;

  /// No description provided for @thousandsOfJobs.
  ///
  /// In en, this message translates to:
  /// **'Thousands of jobs available'**
  String get thousandsOfJobs;

  /// No description provided for @easyApplication.
  ///
  /// In en, this message translates to:
  /// **'Easy Application Process'**
  String get easyApplication;

  /// No description provided for @quickApply.
  ///
  /// In en, this message translates to:
  /// **'Quick Apply'**
  String get quickApply;

  /// No description provided for @instantNotifications.
  ///
  /// In en, this message translates to:
  /// **'Instant Notifications'**
  String get instantNotifications;

  /// No description provided for @stayUpdated.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with job alerts'**
  String get stayUpdated;

  /// No description provided for @personalizedRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Personalized Recommendations'**
  String get personalizedRecommendations;

  /// No description provided for @jobsForYou.
  ///
  /// In en, this message translates to:
  /// **'Jobs tailored for you'**
  String get jobsForYou;

  /// No description provided for @chooseYourCareerPath.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Career Path'**
  String get chooseYourCareerPath;

  /// No description provided for @selectJobCategoryMatching.
  ///
  /// In en, this message translates to:
  /// **'Select a job category that matches your skills'**
  String get selectJobCategoryMatching;

  /// No description provided for @searchJobCategoriesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search job categories...'**
  String get searchJobCategoriesPlaceholder;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get noCategoriesFound;

  /// No description provided for @trySearchingDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords'**
  String get trySearchingDifferentKeywords;

  /// No description provided for @fresherPosition.
  ///
  /// In en, this message translates to:
  /// **'Fresher Position'**
  String get fresherPosition;

  /// No description provided for @typeCustomSkillPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type a custom skill...'**
  String get typeCustomSkillPlaceholder;

  /// No description provided for @pleaseCompleteAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all fields'**
  String get pleaseCompleteAllFields;

  /// No description provided for @pleaseAddAtLeastOneSkill.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one skill'**
  String get pleaseAddAtLeastOneSkill;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'gu', 'hi', 'mr', 'pa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
    case 'pa':
      return AppLocalizationsPa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
