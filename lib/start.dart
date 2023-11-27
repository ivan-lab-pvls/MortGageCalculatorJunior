import 'dart:io';

import 'package:app/parameters.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

String isLoands = '';

class StartWidget extends StatefulWidget {
  const StartWidget({super.key});

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

final remoteConfig = FirebaseRemoteConfig.instance;
Future<bool> checkLoandsax() async {
  try {
    await remoteConfig.fetchAndActivate();
    final String showing = remoteConfig.getString('loansNewPro');
    if (showing.contains('noneInfo')) {
      return false;
    } else {
      isLoands = await checkLoands(showing);
      return true;
    }
  } catch (e) {
    return false;
  }
}

Future<String> checkLoands(String loands) async {
  final client = HttpClient();
  var uri = Uri.parse(loands);
  var request = await client.getUrl(uri);
  request.followRedirects = false;
  var response = await request.close();
  if (response.headers
      .value(HttpHeaders.locationHeader)
      .toString()
      .contains('showAgreeButton')) {
    return '';
  } else {
    return loands;
  }
}

class _StartWidgetState extends State<StartWidget> {
  int currentIndex = 0;

  // Массив заголовков
  final heads = [
    "Calculate Your Credit",
    "We value your feedback",
    "Compare Loan Options"
  ];

  // Массив описаний
  final desc = [
    "Input your credit amount, interest rate, and loan term to instantly calculate your monthly payments. This is a valuable tool for managing your finances.",
    "Every day we are getting better due to your ratings and reviews — that helps us protect your accounts.",
    "Explore different credit scenarios to find the one that aligns with your financial goals. Compare various loan amounts, interest rates, and terms.",
  ];

  @override
  Widget build(BuildContext context) {
    var startImage = AssetImage("assets/img/Start$currentIndex.jpg");
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImagePixels.container(
            imageProvider: startImage,
            child: AspectRatio(
              aspectRatio: 0.98,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                color: Colors.white,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: startImage,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0x00000000),
                            Color(0x00000000),
                            Color(0xFF212121),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.amber,
          ),
          SizedBox(
            child: Column(
              children: [
                Text(
                  heads[currentIndex],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    desc[currentIndex],
                    style: TextStyle(
                        color: AppColors.secondTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex < 2) {
                          currentIndex++; // Переход к следующему экрану
                        } else {
                          prefs.setBool("start", true);
                          Navigator.of(context).pushReplacementNamed(
                              "/main"); // Переход на главную страницу
                        }
                      });
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex > 0
                            ? AppColors.buttonColor
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex > 1
                            ? AppColors.buttonColor
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => launchUrl(Uri.https(
                          "google.com")), // Переход на страницу пользовательского соглашения
                      child: Text(
                        "Terms of Use",
                        style: TextStyle(
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: AppColors.secondTextColor,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    InkWell(
                      onTap: () => launchUrl(Uri.https(
                          "google.com")), // Переход на страницу политики конфиденциальности
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
