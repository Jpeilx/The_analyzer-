import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_state.dart';

class FreeLineChartWidget extends StatelessWidget {
  const FreeLineChartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final List<SalesDataFree> chartDataFree = [];
    return BlocConsumer<FreeSearchResultCubit , FreeSearchResultStates >(
      buildWhen: (previous, current) =>
          current is GetPlotingTableDataFreeLoadingState ||
          current is GetPlotingTableDataFreeErrorState ||
          current is GetPlotingTableDataFreeSuccessState,
      listenWhen: (previous, current) =>
          current is GetPlotingTableDataFreeLoadingState ||
          current is GetPlotingTableDataFreeErrorState ||
          current is GetPlotingTableDataFreeSuccessState,
      listener: (context, state) {
        if (state is GetPlotingTableDataFreeErrorState) {
          RepeatedFunctions.showSnackBar(context,
              message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is GetPlotingTableDataFreeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetPlotingTableDataFreeErrorState) {
          return Text('error');
        }
        FreeSearchResultCubit.get(context)
            .plotingTabelDataFree
            ?.data
            ?.forEach((element) {
          chartDataFree.add(
            SalesDataFree(DateFormat('yyyy-MM-ddThh:mm:ss').parse(element.x ?? ''),
                element.y ?? 0),
          );
        });

        return Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <CartesianSeries>[
              // Renders line chart
              LineSeries<SalesDataFree, DateTime>(
                  dataSource: chartDataFree,
                  xValueMapper: (SalesDataFree sales, _) => sales.year,
                  yValueMapper: (SalesDataFree sales, _) => sales.sales)
            ])));
      },
    );
  }
}

class SalesDataFree {
  SalesDataFree(this.year, this.sales);
  final DateTime year;
  final int sales;
}
