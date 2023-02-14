import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_score/db/pj_songs.dart';
import 'package:project_score/model/constant.dart';
import 'package:project_score/model/provider.dart';
import 'package:project_score/view/component/home/alerts.dart';

class SongDataTable extends ConsumerWidget {
  final List songData;
  const SongDataTable(this.songData, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diffSetting = ref.watch(diffProvider);
    double width = MediaQuery.of(context).size.width;
    return DataTable(
      columnSpacing: 8,
      columns: const [
        DataColumn(label: Text("曲名")),
        DataColumn(label: Text("難易度")),
        DataColumn(label: Text("レベル")),
        DataColumn(label: Text("最高記録")),
      ],
      rows: songData
          .map((e) => DataRow(
                color: getRowBackgroundColor(e, ref),
                onLongPress: () => showDialog(
                    context: context, builder: (_) => EditScoreAlert(e)),
                cells: [
                  DataCell(SizedBox(
                    width: width / 2.5,
                    child: Text(
                      e.name,
                    ),
                  )),
                  DataCell(Text(diffSetting)),
                  DataCell(DiffText(e)),
                  DataCell(ScoreText(e)),
                ],
              ))
          .toList(),
    );
  }
}

class DiffText extends ConsumerWidget {
  final pj_song e;
  const DiffText(this.e, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diff = ref.watch(diffProvider);
    if (diff == "Master") {
      return Text(e.master.level.toString());
    } else if (diff == "Expert") {
      return Text(e.expert.level.toString());
    } else if (diff == "Hard") {
      return Text(e.hard.level.toString());
    } else if (diff == "Normal") {
      return Text(e.normal.level.toString());
    } else {
      return Text(e.easy.level.toString());
    }
  }
}

class ScoreText extends ConsumerWidget {
  final pj_song e;
  const ScoreText(this.e, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diff = ref.watch(diffProvider);
    if (diff == "Master") {
      if (e.master.bestPerfect == null) {
        return const Text("-");
      } else {
        return Text(
            '${e.master.bestPerfect.toString()}-${e.master.bestGreat.toString()}-${e.master.bestGood.toString()}-${e.master.bestBad.toString()}-${e.master.bestMiss.toString()}');
      }
    } else if (diff == "Expert") {
      if (e.expert.bestPerfect == null) {
        return const Text("-");
      } else {
        return Text(
            '${e.expert.bestPerfect.toString()}-${e.expert.bestGreat.toString()}-${e.expert.bestGood.toString()}-${e.expert.bestBad.toString()}-${e.expert.bestMiss.toString()}');
      }
    } else if (diff == "Hard") {
      if (e.hard.bestPerfect == null) {
        return const Text("-");
      } else {
        return Text(
            '${e.hard.bestPerfect.toString()}-${e.hard.bestGreat.toString()}-${e.hard.bestGood.toString()}-${e.hard.bestBad.toString()}-${e.hard.bestMiss.toString()}');
      }
    } else if (diff == "Normal") {
      if (e.normal.bestPerfect == null) {
        return const Text("-");
      } else {
        return Text(
            '${e.normal.bestPerfect.toString()}-${e.normal.bestGreat.toString()}-${e.normal.bestGood.toString()}-${e.normal.bestBad.toString()}-${e.normal.bestMiss.toString()}');
      }
    } else {
      if (e.easy.bestPerfect == null) {
        return const Text("-");
      } else {
        return Text(
            '${e.easy.bestPerfect.toString()}-${e.easy.bestGreat.toString()}-${e.easy.bestGood.toString()}-${e.easy.bestBad.toString()}-${e.easy.bestMiss.toString()}');
      }
    }
  }
}

MaterialStateProperty<MaterialColor> getRowBackgroundColor(
    pj_song e, WidgetRef ref) {
  final diff = ref.watch(diffProvider);
  bool APed = false;
  bool FCed = false;
  if (diff == "Master") {
    if (e.master.FCed != null && e.master.FCed == true) {
      FCed = true;
    }
    if (e.master.APed != null && e.master.APed == true) {
      APed = true;
    }
    return MaterialStateProperty.resolveWith((states) {
      if (APed) {
        return Colors.red;
      } else if (FCed) {
        return Colors.green;
      } else {
        return materialWhite;
      }
    });
  } else if (diff == "Expert") {
    if (e.expert.FCed != null && e.expert.FCed == true) {
      FCed = true;
    }
    if (e.expert.APed != null && e.expert.APed == true) {
      APed = true;
    }
    return MaterialStateProperty.resolveWith((states) {
      if (APed) {
        return Colors.red;
      } else if (FCed) {
        return Colors.green;
      } else {
        return materialWhite;
      }
    });
  } else if (diff == "Hard") {
    if (e.hard.FCed != null && e.hard.FCed == true) {
      FCed = true;
    }
    if (e.hard.APed != null && e.hard.APed == true) {
      APed = true;
    }
    return MaterialStateProperty.resolveWith((states) {
      if (APed) {
        return Colors.red;
      } else if (FCed) {
        return Colors.green;
      } else {
        return materialWhite;
      }
    });
  } else if (diff == "Normal") {
    if (e.normal.FCed != null && e.normal.FCed == true) {
      FCed = true;
    }
    if (e.normal.APed != null && e.normal.APed == true) {
      APed = true;
    }
    return MaterialStateProperty.resolveWith((states) {
      if (APed) {
        return Colors.red;
      } else if (FCed) {
        return Colors.green;
      } else {
        return materialWhite;
      }
    });
  } else if (diff == "Easy") {
    if (e.easy.FCed != null && e.easy.FCed == true) {
      FCed = true;
    }
    if (e.easy.APed != null && e.easy.APed == true) {
      APed = true;
    }
    return MaterialStateProperty.resolveWith((states) {
      if (APed) {
        return Colors.red;
      } else if (FCed) {
        return Colors.green;
      } else {
        return materialWhite;
      }
    });
  } else {
    return MaterialStateProperty.resolveWith((states) {
      return Colors.yellow;
    });
  }
}
