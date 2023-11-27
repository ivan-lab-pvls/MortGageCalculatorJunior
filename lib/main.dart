import 'package:app/add_credit.dart';
import 'package:app/add_payment.dart';
import 'package:app/credit_history.dart';
import 'package:app/credit_info.dart';
import 'package:app/credit_schedule.dart';
import 'package:app/edit_credit.dart';
import 'package:app/home.dart';
import 'package:app/notification.dart';
import 'package:app/options.dart';
import 'package:app/parameters.dart';
import 'package:app/settings.dart';
import 'package:app/start.dart';
import 'package:app/terms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'showLoands.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
late final SharedPreferences gfdhgfddf;
late SharedPreferences prefs;
final remoteConfig = FirebaseRemoteConfig.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  gfdhgfddf = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: SettingsS.currentPlatform);
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 7),
    minimumFetchInterval: const Duration(seconds: 7),
  ));
  await NotificationServiceFb().activate();
  prefs = await SharedPreferences.getInstance();

  prefs = await SharedPreferences.getInstance();
  // prefs.clear();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  // Define a GlobalKey for the navigator to manage navigation from anywhere
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const InitialScreenLoader(),
      // Define your routes here
      routes: {
        "/start": (context) => const StartWidget(), // Стартовая страница
        "/terms": (context) =>
            const TermsWidget(), // Страница с пользовательским соглашением
        "/policy": (context) =>
            const PolicyWidget(), // Страница с политикой конфиденциальности
        "/main": (context) => const HomeWidget(), // Главная страница
        "/add": (context) => const AddCredit(), // Страница добавления кредита
        "/info": (context) =>
            const CreditInfo(), // Страница информации о кредите
        "/addPayment": (context) => AddPayment(), // Страница добавления платежа
        "/schedule": (context) =>
            CreditSchedule(), // Страница графика платежей
        "/history": (context) =>
            const CreditHistory(), // Страница истории платежей
        "/editCredit": (context) =>
            const EditCredit(), // Страница редактирования кредита
        "/settings": (context) => const Settings(), // Страница настроек
      },
      // Глобальные настройки дизайна приложения
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.thirdTextColor,
          elevation: 0.4,
          toolbarHeight: 80,
          centerTitle: true,
          shadowColor: null,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        fontFamily: "Satoshi",
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.only(left: 10, right: 10, top: 22, bottom: 22),
          labelStyle: TextStyle(
            color: AppColors.thirdTextColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            color: AppColors.thirdTextColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondTextColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.buttonColor,
            ),
          ),
          prefixStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          suffixStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class InitialScreenLoader extends StatelessWidget {
  const InitialScreenLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoandsax(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
                child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/img/img.png'),
              ),
            )),
          );
        } else {
          final bool showing = snapshot.data ?? false;
          bool startWatched = prefs.getBool("start") ?? false;

          if (showing && isLoands != '') {
            // Navigate to LoandsNew if conditions are met
            Future.microtask(
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => LoandsNew(lodans: isLoands),
                    )));
          } else if (!startWatched) {
            // Navigate to StartWidget if not watched
            Future.microtask(
                () => Navigator.of(context).pushReplacementNamed("/start"));
          } else {
            // Navigate to HomeWidget otherwise
            Future.microtask(
                () => Navigator.of(context).pushReplacementNamed("/main"));
          }

          return Container();
        }
      },
    );
  }
}
