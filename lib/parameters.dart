library parameters;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';



class AppColors {
  // Цвета используемые в приложении
  static var darkColor = const Color(0xFF1C1C1E);
  static var buttonColor = const Color(0xFFFF3B30);
  static var buttonSecondColor = const Color(0xFFFBF4F4);
  static var textColor = const Color(0xFFFFFFFF);
  static var mainTextColor = const Color(0xFFDEDEDE);
  static var secondTextColor = const Color(0xFFC7C7CC);
  static var thirdTextColor = const Color(0xFF858585);
  static var secondBgColor = const Color(0xFFFcFcFc);
  static var accentColor = const Color(0xFF34C759);
}

const String iosAppId = "";

Function updateHomeList =
    () {}; // Глобальная функция обновления списка кредитов

const CreditType = ["Vehicle", "Personal", "Home"]; // Типы кредитов

String formatDate(DateTime dt) {
  // Форматирование даты
  return DateFormat("dd.MM.yyyy").format(dt);
}

String formatDateTime(DateTime dt) {
  // Форматирование даты и времени
  return DateFormat("dd.MM.yyyy HH:mm").format(dt);
}

DateTime dateFromString(String s) {
  // Преобразование строки в дату
  return DateFormat("dd.MM.yyyy").parse(s);
}

class Credit {
  // Кредит
  Credit({
    required this.creditAmount,
    required this.interestRate,
    required this.creditPeriod,
    required this.notaryServices,
    required this.depositCost,
    this.history = const [],
    required this.type,
    required this.date,
    required this.index,
  }) {
    countPayments(); // Подсчет платежей
  }

  Credit.fromJson({
    // Конструктор кредита из JSON
    required Map<String, dynamic> json,
    required this.index,
  }) {
    creditAmount = json["creditAmount"];
    interestRate = json["interestRate"];
    creditPeriod = json["creditPeriod"];
    notaryServices = json["notaryServices"];
    depositCost = json["depositCost"];
    type = json["type"];
    date = json["date"];
    history = [for (var i in json["history"]) Payment.fromJson(json: i)];

    countPayments(); // Подсчет платежей
  }

  void save() {
    // Функция сохранения кредита
    var i = prefs.getStringList("credits")!; // Сохранение кредита
    i[index] = toString(); // Запись
    prefs.setStringList("credits", i); // Сохранение в Shared Preferences

    updateHomeList(); // Обновление списка
  }

  void countPayments() {
    // Функция подсчета платежей
    var monthlyRate = (interestRate / 100) / 12; // Процентная ставка в месяц

    monthlyPayment = interestRate == 0
        ? creditAmount / creditPeriod
        : creditAmount *
            (monthlyRate +
                monthlyRate /
                    (pow((1 + monthlyRate), creditPeriod) -
                        1)); // Ежемесячный платеж
    totalPayment = monthlyPayment * creditPeriod; // Общая сумма платежей
    fullCost =
        totalPayment + notaryServices + depositCost; // Общая стоимость кредита
    overpayment = totalPayment - creditAmount; // Переплата
  }

  late int type;
  late double interestRate;
  late double creditAmount;
  late int creditPeriod;
  late double notaryServices;
  late double depositCost;
  late String date;

  int index;

  late List<Payment> history;

  late double monthlyPayment;
  late double totalPayment;
  late double fullCost;
  late double overpayment;

  // Функция преобразования кредита в строку
  @override
  String toString() {
    return '{"type": $type, "interestRate": $interestRate, "date": "$date", "creditAmount": $creditAmount, "creditPeriod": $creditPeriod, "notaryServices": $notaryServices, "depositCost": $depositCost, "history": $history}';
  }
}

class Payment {
  // Платеж
  Payment({
    this.amount = 0,
    this.date = "",
  });

  Payment.fromJson({
    // Конструктор платежа из JSON
    required Map<String, dynamic> json,
  }) {
    amount = json["amount"];
    date = json["date"];
  }

  late double amount;
  late String date;

  // Функция преобразования платежа в строку
  @override
  String toString() {
    return '{"amount": $amount, "date": "$date"}';
  }
}
