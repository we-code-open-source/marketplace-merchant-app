import 'package:flutter/material.dart';

import '../elements/StatisticsCarouselLoaderWidget.dart';
import '../models/statistic.dart';
import 'StatisticCarouselItemWidget.dart';

class StatisticsCarouselWidget extends StatelessWidget {
  final Statistics? statistics;

  StatisticsCarouselWidget({Key? key, this.statistics}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return statistics==null
        ? StatisticsCarouselLoaderWidget()
        : Container(
            height: 190,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                StatisticCarouselItemWidget(
                  title: 'total_orders',
                  amount: double.tryParse(statistics!.settlements!.count!)!+double.tryParse(statistics!.availabelOrdersForSettlement!.count!)!,
                ),StatisticCarouselItemWidget(
                  title: 'total_earning',
                  amount: double.tryParse(statistics!.settlements!.manager_fee!)!+double.tryParse(statistics!.availabelOrdersForSettlement!.manager_fee!)!,
                ),StatisticCarouselItemWidget(
                  title: 'company_ratio',
                  amount: double.tryParse(statistics!.availabelOrdersForSettlement!.amount!)!,
                ),


              ],));
  }
}
