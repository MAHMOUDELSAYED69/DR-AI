import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/view/screen/account/delete_account/delete_account_screen.dart';
import 'package:dr_ai/view/screen/account/delete_account/re_auth_screen.dart';
import 'package:dr_ai/view/screen/auth/login_screen.dart';
import 'package:dr_ai/view/screen/auth/password_screen.dart';
import 'package:flutter/material.dart';
import '../../view/screen/account/about_us_screen.dart';
import '../../view/screen/account/change_password/new_pass_word.dart';
import '../../view/screen/account/change_password/old_password_screen.dart';
import '../../view/screen/auth/create_profile.dart';
import '../../view/screen/auth/email_screen.dart';
import '../../view/screen/chat/chat_screen.dart';
import '../../view/screen/nav_bar/home_screen.dart';
import '../../view/screen/nav_bar/maps_screen.dart';
import '../../view/screen/nav_bar/nav_bar_screen_.dart';
import '../../view/screen/account/edit_profile_screen.dart';
import '../../view/screen/splash_screen.dart';
import 'page_transition.dart';

abstract class AppRouter {
  AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RouteManager.login:
        return PageTransitionManager.materialPageRoute(const LoginScreen());
      case RouteManager.home:
        return PageTransitionManager.materialPageRoute(const HomeScreen());
      case RouteManager.email:
        return PageTransitionManager.materialPageRoute(const EmailScreen());
      case RouteManager.password:
        return PageTransitionManager.fadeTransition(const PasswordScreen());
      case RouteManager.information:
        return PageTransitionManager.fadeTransition(const CreateProfile());
      case RouteManager.nav:
        return PageTransitionManager.materialPageRoute(const NavbarScreen());
      case RouteManager.chat:
        return PageTransitionManager.materialPageRoute(const ChatScreen());
      case RouteManager.editProfile:
        return PageTransitionManager.materialSlideTransition(
            const EditProfileScreen());
      case RouteManager.oldPassword:
        return PageTransitionManager.materialSlideTransition(
            const OldPasswordScreen());
      case RouteManager.newPassword:
        return PageTransitionManager.fadeTransition(const NewPasswordScreen());
      case RouteManager.aboutUs:
        return PageTransitionManager.materialSlideTransition(const AboutUsScreen());
      case RouteManager.maps:
        return PageTransitionManager.fadeTransition(const MapScreen());
      case RouteManager.reAuthScreen:
        return PageTransitionManager.materialSlideTransition(const ReAuthScreen());
      case RouteManager.deleteAccount:
        return PageTransitionManager.fadeTransition(
            const DeleteAccountScreen());
      default:
        return null;
    }
  }
}
