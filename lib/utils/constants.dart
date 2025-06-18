class AppConstants {
  // App Information
  static const String appName = 'Employee Management';
  static const String appVersion = '1.0.0';

  // Colors
  static const int primaryColorValue = 0xFF2196F3;
  static const int secondaryColorValue = 0xFF1976D2;
  static const int accentColorValue = 0xFF03DAC6;
  static const int errorColorValue = 0xFFB00020;

  // Text Styles
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 14.0;

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;

  // Border Radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;

  // Animation Duration
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  // Validation Messages
  static const String requiredFieldMessage = 'This field is required';
  static const String invalidEmailMessage =
      'Please enter a valid email address';
  static const String invalidPhoneMessage = 'Please enter a valid phone number';
  static const String invalidSalaryMessage =
      'Please enter a valid salary amount';

  // Success Messages
  static const String employeeAddedSuccess = 'Employee added successfully';
  static const String employeeUpdatedSuccess = 'Employee updated successfully';
  static const String employeeDeletedSuccess = 'Employee deleted successfully';

  // Error Messages
  static const String generalErrorMessage =
      'Something went wrong. Please try again.';
  static const String networkErrorMessage =
      'Network error. Please check your connection.';
  static const String dataLoadErrorMessage =
      'Failed to load data. Please try again.';
}
