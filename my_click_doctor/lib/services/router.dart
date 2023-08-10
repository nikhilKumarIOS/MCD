//import 'package:adequate_travel/core/constants/app_constants.dart';

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:my_click_doctor/booking_appointment.dart';
import '../appointment_details.dart';
import '../basic_infomation.dart';
import '../book_appointment_screen.dart';
import '../call_screen.dart';
import '../chat_live_screen.dart';
import '../chat_screen.dart';
import '../colleagues_screen.dart';
import '../doctor_profile.dart';
import '../download_action.dart';
import '../forgot_password.dart';
import '../home_screen.dart';
import '../loginView.dart';
import '../register_screen.dart';
import '../splashView.dart';
import '../support_screen.dart';
import '../tabbar_view.dart';
import '../testing_mic.dart';
import '../timeWindowManagementList.dart';

class RoutePaths {
  static const splash = '/splash';
  static const loginscreen = '/loginScreen';
  static const appointmentDetailScreen = '/appointmentDetailScreen';
  static const basicInformationScreen = '/basicInformationScreen';
  static const bookAppointmentScreen = '/bookAppointmentScreen';
  static const callScreen = '/callScreen';
  static const chatLiveScreen = '/chatLiveScreen';
  static const chatScreen = '/chatScreen';
  static const colleaguesScreen = '/colleaguesScreen';
  static const doctorProfileScreen = '/doctorProfileScreen';
  static const downloadingDialog = '/downloadingDialog';
  static const forgotPasswordScreen = '/ForgotPasswordScreen';
  static const homeScreen = '/homeScreen';
  static const registerScreen = '/registerScreen';
  static const supportScreen = '/supportScreen';
  static const myTabBar = '/myTabBar';
  static const testingMicScreen = '/testingMicScreen';
  static const bookingAppointmentScreen = "/bookingAppointmentScreen";
  static const timeWindowManagementSCreen = "/timeWindowManagementScreen";
}

class Routers {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutePaths.loginscreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePaths.appointmentDetailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                AppointmentDetailScreen(settings.arguments as dynamic));
      case RoutePaths.basicInformationScreen:
        return MaterialPageRoute(
            builder: (_) => const BasicInformationScreen());
      case RoutePaths.bookAppointmentScreen:
        return MaterialPageRoute(builder: (_) => const BookAppointmentScreen());
      case RoutePaths.callScreen:
        return MaterialPageRoute(builder: (_) => const CallScreen());
      case RoutePaths.chatLiveScreen:
        return MaterialPageRoute(builder: (_) => const ChatLiveScreen());
      case RoutePaths.chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case RoutePaths.colleaguesScreen:
        return MaterialPageRoute(builder: (_) => const ColleaguesScreen());
      case RoutePaths.doctorProfileScreen:
        return MaterialPageRoute(builder: (_) => const DoctorProfileScreen());
      case RoutePaths.bookingAppointmentScreen:
        return MaterialPageRoute(
            builder: (_) => const BookingAppointmentScreen());
      // case RoutePaths.downloadingDialog:
      //   return MaterialPageRoute(builder: (_) => const DownloadingDialog(settings.arguments as dynamic));
      case RoutePaths.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RoutePaths.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutePaths.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RoutePaths.supportScreen:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      case RoutePaths.timeWindowManagementSCreen:
        return MaterialPageRoute(
            builder: (_) => const TimeWindowManagementScreen());
      case RoutePaths.myTabBar:
        return MaterialPageRoute(
            builder: (_) => const MyTabBar()); //TimeWindowManagementScreen
      case RoutePaths.testingMicScreen:
        return MaterialPageRoute(
            builder: (_) => TestingMicScreen(settings.arguments as dynamic));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ));
    }
  }
}
