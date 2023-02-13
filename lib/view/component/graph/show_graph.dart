import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_score/db/db.dart';
import 'package:project_score/db/pj_songs.dart';
import 'package:project_score/model/count_data.dart';
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
    return FutureBuilder(
      future: IsarService().getPjMaster(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<pj_song> songDataList = snapshot.data;
          List<ChartData> chartData = getDiffCounterList(songDataList);
          return SfCartesianChart(
            plotAreaBorderWidth: 1,
            series: <ChartSeries>[
              StackedBar100Series<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData d, _) => d.diff,
                yValueMapper: (ChartData d, _) => d.apNum,
              ),
              StackedBar100Series<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData d, _) => d.diff,
                yValueMapper: (ChartData d, _) => d.fcNum,
              ),
              StackedBar100Series<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData d, _) => d.diff,
                yValueMapper: (ChartData d, _) => d.otherNum,
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
