import 'package:app/parameters.dart';
import 'package:flutter/material.dart';

class CreditHistory extends StatefulWidget {
  const CreditHistory({super.key});

  @override
  State<CreditHistory> createState() => _CreditHistoryState();
}

class _CreditHistoryState extends State<CreditHistory> {
  late Credit credit;

  void addPayment(Payment pay) {
    setState(() {
      addPaymentParent(pay);
    });
  }

  late Function(Payment pay) addPaymentParent;

  // При использовании StatefullWidget
  // получение аргументов из предыдущего экрана
  // должно осуществляться в didChangeDependencies
  // во избежание зацикливания
  @override
  void didChangeDependencies() {
    credit = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)["credit"];
    addPaymentParent = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)["fun"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    for (var i = 0; i < credit.history.length; i++) {
      // Вывод истории платежей
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "\$ ${credit.history[i].amount}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  credit.history[i].date,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondTextColor,
                  ),
                ),
              ],
            ),
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
          ],
        ),
      );

      if (i != credit.history.length - 1) {
        list.add(
          Container(
            height: 1,
            color: AppColors.secondTextColor,
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Credit history",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: credit.history.isEmpty // Если история пустая
              ? <Widget>[
                  const Spacer(),
                  const Text(
                    "History is empty",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You have not yet entered information about your payments. Add information about your mortgage by clicking the "+" button',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.secondTextColor,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/addPayment",
                        arguments: {
                          "fun": addPayment,
                        },
                      );
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Add payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  )
                ]
              : [
                  // Если история не пустая
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.secondTextColor,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: list,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
