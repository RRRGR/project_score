import 'package:isar/isar.dart';

part 'pj_songs.g.dart';

@Collection()
class pj_song {
  Id id = Isar.autoIncrement;

  late String name;
  late pj_level_and_score easy;
  late pj_level_and_score normal;
  late pj_level_and_score hard;
  late pj_level_and_score expert;
  late pj_level_and_score master;
}

@embedded
class pj_level_and_score {
  late int level;
  int? highScore;
  int? bestPerfect;
  int? bestGreat;
  int? bestGood;
  int? bestBad;
  int? bestMiss;
  bool? FCed;
  bool? APed;
}
