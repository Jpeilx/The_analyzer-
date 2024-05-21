import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/features/search_vip/logic/search_result_cubit/search_result_cubit.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [];
    return BlocConsumer<SearchResultCubit, SearchResultStates>(
      buildWhen: (previous, current) =>
          current is GetPercentageDataLoadingState ||
          current is GetPercentageDataErrorState ||
          current is GetPercentageDataSuccessState,
      listenWhen: (previous, current) =>
          current is GetPercentageDataLoadingState ||
          current is GetPercentageDataErrorState ||
          current is GetPercentageDataSuccessState,
      listener: (context, state) {
        if (state is GetPercentageDataErrorState) {
          RepeatedFunctions.showSnackBar(context,
              message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is GetPercentageDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetPercentageDataErrorState) {
          return Text('error');
        }
        chartData.add(
          ChartData(
              'Positive tweets',
              SearchResultCubit.get(context)
                      .presentageData
                      ?.positivePercentage ??
                  0),
        );
        chartData.add(
          ChartData(
              'Negative tweets',
              SearchResultCubit.get(context)
                      .presentageData
                      ?.negativePercentage ??
                  0),
        );
        return Center(
            child: Container(
                child: SfCircularChart(series: <CircularSeries>[
          PieSeries<ChartData, String>(
            name: "Positive to negaitve tweets",
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelMapper: (ChartData data, _) => data.x,
            radius: '90',
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelIntersectAction: LabelIntersectAction.none,
                showZeroValue: false,
                labelPosition: ChartDataLabelPosition.outside,
                connectorLineSettings: ConnectorLineSettings(
                  type: ConnectorType.curve,
                )),
          )
        ])));
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
