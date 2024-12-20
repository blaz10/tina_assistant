/// Application-wide constants for consistent styling and text.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App information
  static const String appTitle = 'Book Search';
  static const String searchHint = 'Search for books...';

  // Padding values
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double defaultPadding = mediumPadding;

  // Grid layout
  static const double gridChildAspectRatio = 0.7;
  static const double minGridSpacing = 16.0;
  static const double maxGridSpacing = 24.0;

  // Font sizes
  static const double titleFontSize = 16.0;
  static const double subtitleFontSize = 14.0;

  // Breakpoints for responsive design
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
}
