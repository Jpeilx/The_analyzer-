import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_state.dart';

class FreePieChartWidget extends StatefulWidget {
  const FreePieChartWidget({super.key});

  @override
  State<FreePieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<FreePieChartWidget> {
  @override
  Widget build(BuildContext context) {
    final List<ChartDataFree> chartDataFree = [];
    return BlocConsumer<FreeSearchResultCubit , FreeSearchResultStates>(
      buildWhen: (previous, current) =>
          current is GetPercentageDataFreeLoadingState ||
          current is GetPercentageDataFreeErrorState ||
          current is GetPercentageDataFreeSuccessState,
      listenWhen: (previous, current) =>
          current is GetPercentageDataFreeLoadingState ||
          current is GetPercentageDataFreeErrorState ||
          current is GetPercentageDataFreeSuccessState,
      listener: (context, state) {
        if (state is GetPercentageDataFreeErrorState) {
          RepeatedFunctions.showSnackBar(context,
              message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is GetPercentageDataFreeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetPercentageDataFreeErrorState) {
          return Text('error');
        }
        chartDataFree.add(
          ChartDataFree(
              'Positive tweets',
              FreeSearchResultCubit.get(context)
                      .presentageDataFree
                      ?.positivePercentage ??
                  0),
        );
        chartDataFree.add(
          ChartDataFree(
              'Negative tweets',
              FreeSearchResultCubit.get(context)
                      .presentageDataFree
                      ?.negativePercentage ??
                  0),
        );
        return Center(
            child: Container(
                child: SfCircularChart(series: <CircularSeries>[
          PieSeries<ChartDataFree, String>(
            name: "Positive to negaitve tweets",
            dataSource: chartDataFree,
            pointColorMapper: (ChartDataFree DataFree, _) => DataFree.color,
            xValueMapper: (ChartDataFree DataFree, _) => DataFree.x,
            yValueMapper: (ChartDataFree DataFree, _) => DataFree.y,
            dataLabelMapper: (ChartDataFree DataFree, _) => DataFree.x,
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

class ChartDataFree {
  ChartDataFree(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
