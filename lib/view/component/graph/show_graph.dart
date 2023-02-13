import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_score/db/db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowGraph extends ConsumerStatefulWidget {
  const ShowGraph({super.key});
  @override
  ShowGraphState createState() => ShowGraphState();
}

class ShowGraphState extends ConsumerState<ShowGraph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData('Master', 35, 2),
      ChartData('Hard', 100, 11)
    ];
    return FutureBuilder(
      future: IsarService().getPjMaster(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return SfCartesianChart(
            plotAreaBorderWidth: 1,
            series: <ChartSeries>[
              StackedBar100Series<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData d, _) => d.x,
                yValueMapper: (ChartData d, _) => d.y,
              ),
              StackedBar100Series<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData d, _) => d.x,
                yValueMapper: (ChartData d, _) => d.z,
              ),
            ],
            primaryXAxis: CategoryAxis(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z);
  final String x;
  final num y;
  final num z;
}
