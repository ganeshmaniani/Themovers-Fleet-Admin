import 'package:flutter/material.dart';

import '../../feature/feature.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* ========= Splash Screen ========== */
      case SplashScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      // /* ========= Auth Screen ============ */
      case AuthScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AuthScreen());

      // /* ========= Auth Screen ============ */
      case RegistrationScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegistrationScreen());

      // /* ========= Auth Screen ============ */
      case RegistrationOTPScreen.id:
        final arg = settings.arguments as RegistrationOTPScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => RegistrationOTPScreen(
                email: arg.email, registerEntities: arg.registerEntities));

      // /* ========= Auth Screen ============ */
      case NotificationJobDetailScreen.id:
        final arg = settings.arguments as NotificationJobDetailScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                NotificationJobDetailScreen(bookingId: arg.bookingId));

      // /* ========= Auth Screen ============ */
      case ForgetPasswordScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetPasswordScreen());

      // /* ========= Auth Screen ============ */
      case OtpVerificationScreen.id:
        final arg = settings.arguments as OtpVerificationScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                OtpVerificationScreen(email: arg.email));

      // /* ========= Auth Screen ============ */
      case CreateNewPassword.id:
        final arg = settings.arguments as CreateNewPassword;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                CreateNewPassword(email: arg.email));

      // /* ========= Home Screen ============ */
      case HomeScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      // /* ========= Job List Screen ============ */
      case JobListScreen.id:
        final arg = settings.arguments as JobListScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                JobListScreen(stageId: arg.stageId, stageName: arg.stageName));

      // /* ========= Booking Detail Screen ============ */
      case JobDetailScreen.id:
        final arg = settings.arguments as JobDetailScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => JobDetailScreen(
                  bookingId: arg.bookingId,
                  stageId: arg.stageId,
                  bookingName: arg.bookingName,
                ));

      // /* ========= Booking Detail Screen ============ */
      case JobRatingScreen.id:
        final arg = settings.arguments as JobRatingScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => JobRatingScreen(
                  bookingId: arg.bookingId,
                ));

      // /* ========= Booking Edit Detail Screen ============ */
      case BudgetBookingEditScreen.id:
        final arg = settings.arguments as BudgetBookingEditScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => BudgetBookingEditScreen(
                  bookingId: arg.bookingId,
                  bookingStageId: arg.bookingStageId,
                  distance: arg.distance,
                ));

      case PremiumBookingEditScreen.id:
        final arg = settings.arguments as PremiumBookingEditScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => PremiumBookingEditScreen(
                  bookingId: arg.bookingId,
                  bookingStageId: arg.bookingStageId,
                  distance: arg.distance,
                ));

      case DisposalBookingEditScreen.id:
        final arg = settings.arguments as DisposalBookingEditScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => DisposalBookingEditScreen(
                  bookingId: arg.bookingId,
                  bookingStageId: arg.bookingStageId,
                ));

      case AdditionalServiceScreen.id:
        final arg = settings.arguments as AdditionalServiceScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) => AdditionalServiceScreen(
                bookingId: arg.bookingId, bookingName: arg.bookingName));

      // /* ========= User Account Edit Screen ============ */
      case AccountEditScreen.id:
        final arg = settings.arguments as AccountEditScreen;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                AccountEditScreen(user: arg.user));

      // /* ========= User Account Edit Screen ============ */
      case FAQScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FAQScreen());

      case TermPolicyScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TermPolicyScreen());

      case TermConditionScreen.id:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TermConditionScreen());

      /* ========= No Route =============== */
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(body: Center(child: Text('No route defined')));
        });
    }
  }
}
