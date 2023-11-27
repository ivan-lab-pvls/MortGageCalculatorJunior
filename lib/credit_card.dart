// ignore_for_file: unused_import

import 'dart:convert';

import 'package:app/parameters.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  CreditCard({
    super.key,
    required this.credit,
  });

  double paid = 0;
  Credit credit;

  @override
  Widget build(BuildContext context) {
    for (var i in credit.history) {
      paid += i.amount; // Расчёт суммы платежей
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/info", arguments: {
            "credit": credit,
          });
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondTextColor,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.buttonColor,
                ),
                child: Image.asset(
                  "assets/img/${CreditType[credit.type]}.png",
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My credit",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Paid $paid \$ out of ${credit.fullCost.toStringAsFixed(2)} \$",
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.thirdTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: LinearProgressIndicator(
                        value: paid / credit.totalPayment,
                        minHeight: 5,
                        color: AppColors.accentColor,
                        backgroundColor: AppColors.secondTextColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
