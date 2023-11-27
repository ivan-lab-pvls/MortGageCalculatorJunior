// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:app/parameters.dart';
import 'package:flutter/material.dart';

class CreditSchedule extends StatelessWidget {
  CreditSchedule({super.key});

  late Credit credit;

  @override
  Widget build(BuildContext context) {
    // При использовании StatelessWidget возможно
    // получение параметров из предыдущего экрана
    // в функции build

    credit = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)["credit"];
    var debt = credit.fullCost;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      color: AppColors.thirdTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Amount",
                    style: TextStyle(
                      color: AppColors.thirdTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Debt",
                    style: TextStyle(
                      color: AppColors.thirdTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: AppColors.secondTextColor,
                width: double.infinity,
                height: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              for (var i = 0; i < credit.creditPeriod; i++)
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  color: i % 2 == 0
                      ? Colors.white
                      : AppColors.buttonSecondColor, // Чередование цветов
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80,
                        child: Center(
                          child: Text(
                            formatDate(
                              DateTime(
                                dateFromString(credit.date).year,
                                dateFromString(credit.date).month + i,
                                dateFromString(credit.date).day,
                              ), // Вывод даты следующего платежа
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: const EdgeInsets.only(left: 30),
                        child: Center(
                          child: Text(
                            credit.monthlyPayment
                                .toStringAsFixed(2), // Вывод платежа
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          (credit.fullCost - credit.monthlyPayment * (i + 1))
                              .toStringAsFixed(2), // Вывод долга после платежа
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
