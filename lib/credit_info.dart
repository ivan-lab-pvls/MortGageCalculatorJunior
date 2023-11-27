// ignore_for_file: unused_import

import 'dart:convert';

import 'package:app/parameters.dart';
import 'package:flutter/material.dart';

import 'edit_credit.dart';
import 'main.dart';

class CreditInfo extends StatefulWidget {
  const CreditInfo({super.key});

  @override
  State<CreditInfo> createState() => _CreditInfoState();
}

class _CreditInfoState extends State<CreditInfo> {
  var outputs = [
    "Total payments",
    "Monthly payments",
    "Full cost of credit",
    "Overpayment",
  ];

  double paid = 0;

  void addPayment(Payment pay) {
    setState(() {
      credit.history.add(pay);
      credit.save();

      paid = 0;
      for (var i in credit.history) {
        paid += i.amount;
      }
    });
  }

  void updateInfo(Credit credit) {
    setState(() {
      this.credit = credit;
    });
  }

  late Credit credit;

  // При использовании StatefullWidget
  // получение аргументов из предыдущего экрана
  // должно осуществляться в didChangeDependencies
  // во избежание зацикливания
  @override
  void didChangeDependencies() {
    credit = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)["credit"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    paid = 0;
    for (var i in credit.history) {
      paid += i.amount; // Расчёт суммы платежей
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Credit info"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.secondTextColor,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 15,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${paid.toStringAsFixed(2)} \$",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${credit.fullCost.toStringAsFixed(2)} \$",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LinearProgressIndicator(
                            value: paid / credit.totalPayment,
                            minHeight: 5,
                            color: AppColors.accentColor,
                            backgroundColor: AppColors.secondTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Paid",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.thirdTextColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "Debt",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.thirdTextColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    for (var i in outputs)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              i,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.thirdTextColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              getCreditInfo(i, credit),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/addPayment", arguments: {
                        "fun": addPayment,
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.buttonColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          "Add payment",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/schedule", arguments: {
                        "credit": credit,
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainTextColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          "Schedule",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/history", arguments: {
                        "credit": credit,
                        "fun": addPayment,
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainTextColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          "History",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/editCredit", arguments: {
                        "credit": credit,
                        "fun": updateInfo,
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainTextColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      var i = prefs.getStringList("credits") ?? [];
                      i.removeAt(credit.index);

                      prefs.setStringList("credits", i);
                      updateHomeList();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainTextColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
