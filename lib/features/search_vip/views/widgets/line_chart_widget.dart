import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/features/search_vip/logic/search_result_cubit/search_result_cubit.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [];
    return BlocConsumer<SearchResultCubit, SearchResultStates>(
      buildWhen: (previous, current) =>
          current is GetPlotingTableDataLoadingState ||
          current is GetPlotingTableDataErrorState ||
          current is GetPlotingTableDataSuccessState,
      listenWhen: (previous, current) =>
          current is GetPlotingTableDataLoadingState ||
          current is GetPlotingTableDataErrorState ||
          current is GetPlotingTableDataSuccessState,
      listener: (context, state) {
        if (state is GetPlotingTableDataErrorState) {
          RepeatedFunctions.showSnackBar(context,
              message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is GetPlotingTableDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetPlotingTableDataErrorState) {
          return Text('error');
        }
        SearchResultCubit.get(context)
            .plotingTabelData
            ?.data
            ?.forEach((element) {
          chartData.add(
            SalesData(DateFormat('yyyy-MM-ddThh:mm:ss').parse(element.x ?? ''),
                element.y ?? 0),
          );
        });

        return Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <CartesianSeries>[
              // Renders line chart
              LineSeries<SalesData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ])));
      },
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final int sales;
}
