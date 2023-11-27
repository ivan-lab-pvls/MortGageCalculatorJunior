import 'package:app/parameters.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () => launchUrl(Uri.parse(
                  "https://docs.google.com/document/d/1ggieGm7Zykbraiv7to0xsv9hb_g2rA-iG09XS6CEi6k/edit?usp=sharing")), // Политика конфиденциальности
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Shield.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Privacy policy",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => launchUrl(Uri.parse(
                  "https://docs.google.com/document/d/16FOxNZk1OiC0zAzuSvG2dPTwTsWFwVNUoJq1y255J3A/edit?usp=sharing")), // Пользовательское соглашение
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Doc.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Terms of use",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                final InAppReview inAppReview = InAppReview.instance;
                inAppReview.openStoreListing(appStoreId: '6473171168');
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Star.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Rate our app in the AppStore",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
