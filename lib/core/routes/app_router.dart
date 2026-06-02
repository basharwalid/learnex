import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnex/UI/classes_screen/classes_view.dart';
import 'package:learnex/UI/home/home_view.dart';
import 'package:learnex/UI/payment/payment_view.dart';
import 'package:learnex/UI/payment/payment_web_view.dart';
import 'package:learnex/UI/seat_reservation/seat_reserve_view.dart';
import 'package:learnex/core/routes/routes.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/model/course.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('navigate to ${settings.name}');
    }
    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );

      case Routes.classScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ClassesView(
            courseId: args['courseId'] as int,
            courseName: args['courseName'] as String,
            course: args['course'] as Course,
          ),
        );

      case Routes.reserveScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final session = args['session'] as Class;
        final onPaymentSuccess = args['onPaymentSuccess'] as VoidCallback;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ReserveScreen(
            session: session,
            onPaymentSuccess: onPaymentSuccess,
            course: args['course'] as Course,
          ),
        );

      case Routes.paymentScreen:
      // args: {'session': Class, 'orderId': String, 'studentName': String,
      //        'studentEmail': String, 'onPaymentSuccess': VoidCallback}
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaymentScreen(
            session: args['session'] as Class,
            orderId: args['orderId'] as String,
            studentName: args['studentName'] as String,
            studentEmail: args['studentEmail'] as String,
            onPaymentSuccess: args['onPaymentSuccess'] as VoidCallback?,
          ),
        );
      case Routes.paymobWebView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaymobWebView(
            clientSecret: args['clientSecret'] as String,
            onSuccess: args['onSuccess'] as VoidCallback,
            onFailure: args['onFailure'] as VoidCallback,
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
