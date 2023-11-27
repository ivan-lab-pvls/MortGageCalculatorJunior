import 'dart:convert';

import 'package:app/credit_card.dart';
import 'package:app/parameters.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import 'main.dart';

class HomeWidget extends StatefulWidget {
  // Главная страница
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var credits = <Credit>[];
  final InAppReview inAppReview = InAppReview.instance;

  void updateList() {
    setState(() {
      // Загрузка списка кредитов
      credits = [
        for (var i = 0; i < (prefs.getStringList("credits") ?? []).length; i++)
          Credit.fromJson(
              json: jsonDecode((prefs.getStringList("credits") ?? [])[i]),
              index: i),
      ];
    });
  }

  @override
  void initState() {
    updateHomeList = updateList; // Создание глобальной функции для обновления
    updateList();

    if (prefs.getBool("review") == null || !prefs.getBool("review")!) {
      callReview();
      prefs.setBool("review", true);
    } else {
    }

    super.initState();
  }

  void callReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBgColor,
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Credit calculator",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            )),
        actions: [
          // Иконка настроек
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/settings");
            },
            child: Image.asset(
              "assets/img/Settings.png",
              width: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: credits.isEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          const Text(
                            "It's empty",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Add information about your mortgage by clicking the '
                            '"Add credit info" button',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                        ])
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Если есть кредиты
                          for (var i = 0; i < credits.length; i++)
                            CreditCard(
                              credit: credits[i],
                            ),
                        ],
                      ),
                    ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/add"); // Переход на страницу добавления
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    "Add credit info",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
