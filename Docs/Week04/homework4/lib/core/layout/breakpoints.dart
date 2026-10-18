/// Width thresholds shared by every screen.
abstract final class Breakpoints {
  /// At or above this width, layouts switch from phone to wide.
  static const double wide = 600;

  /// Reading width for single-column content on wide screens.
  static const double contentMaxWidth = 720;
}