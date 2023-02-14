import 'package:isar/isar.dart';
import 'package:project_score/db/pj_songs.dart';
import 'package:project_score/model/load_json.dart';
import 'package:string_similarity/string_similarity.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> updatePjSong() async {
    final isar = await db;
    List songsList = await loadLocalJson();
    String songName = "";
    int easyLevel = 0;
    int normalLevel = 0;
    int hardLevel = 0;
    int expertLevel = 0;
    int masterLevel = 0;
    for (Map songData in songsList) {
      songName = songData["name"];
      easyLevel = songData["easy_level"];
      normalLevel = songData["normal_level"];
      hardLevel = songData["hard_level"];
      expertLevel = songData["expert_level"];
      masterLevel = songData["master_level"];
      List result =
          await isar.pj_songs.filter().nameContains(songName).findAll();
      // final easyInfo = pj_diff_and_score()..diff = eDiff;
      // final normalInfo = pj_diff_and_score()..diff = nDiff;
      // final hardInfo = pj_diff_and_score()..diff = hDiff;
      // final expertInfo = pj_diff_and_score()..diff = exDiff;
      // final masterInfo = pj_diff_and_score()..diff = mDiff;
      pj_song songInfo;
      if (result.isEmpty) {
        final easyInfo = pj_level_and_score()..level = easyLevel;
        final normalInfo = pj_level_and_score()..level = normalLevel;
        final hardInfo = pj_level_and_score()..level = hardLevel;
        final expertInfo = pj_level_and_score()..level = expertLevel;
        final masterInfo = pj_level_and_score()..level = masterLevel;
        songInfo = pj_song()
          ..name = songName
          ..easy = easyInfo
          ..normal = normalInfo
          ..hard = hardInfo
          ..expert = expertInfo
          ..master = masterInfo;
      } else {
        pj_song state = result[0];
        state.easy.level = easyLevel;
        state.normal.level = normalLevel;
        state.hard.level = hardLevel;
        state.expert.level = expertLevel;
        state.master.level = masterLevel;
        songInfo = pj_song()
          ..id = state.id
          ..name = songName
          ..easy = state.easy
          ..normal = state.normal
          ..hard = state.hard
          ..expert = state.expert
          ..master = state.master;
      }
      await isar.writeTxn(() async => await isar.pj_songs.put(songInfo));
    }
  }

  Future<void> updateScore(Map scoreData) async {
    final isar = await db;
    bool APed = false;
    bool FCed = false;
    pj_song songInfo;
    List result =
        await isar.pj_songs.filter().nameContains(scoreData["name"]).findAll();
    if (result.isEmpty) {
      List allSongInfo = isar.pj_songs.where().findAllSync();
      List<String> allSongName =
          List.generate(allSongInfo.length, (index) => allSongInfo[index].name);
      BestMatch bestMatch =
          StringSimilarity.findBestMatch(scoreData["name"], allSongName);
      scoreData["name"] = bestMatch.bestMatch.target;
      result = await isar.pj_songs
          .filter()
          .nameContains(scoreData["name"])
          .findAll();
    }
    final old_pj_songs = result[0];
    if (scoreData["great"] == 0 &&
        scoreData["good"] == 0 &&
        scoreData["bad"] == 0 &&
        scoreData["miss"] == 0)
      APed = true;
    else if (scoreData["good"] == 0 &&
        scoreData["bad"] == 0 &&
        scoreData["miss"] == 0) FCed = true;
    if (scoreData['diff'] == 'MASTER') {
      final masterInfo = pj_level_and_score()
        ..level = old_pj_songs.master.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreData["perfect"]
        ..bestGreat = scoreData["great"]
        ..bestGood = scoreData["good"]
        ..bestBad = scoreData["bad"]
        ..bestMiss = scoreData["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = old_pj_songs.normal
        ..hard = old_pj_songs.hard
        ..expert = old_pj_songs.expert
        ..master = masterInfo;
    } else if (scoreData['diff'] == 'EXPERT') {
      final expertInfo = pj_level_and_score()
        ..level = old_pj_songs.expert.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreData["perfect"]
        ..bestGreat = scoreData["great"]
        ..bestGood = scoreData["good"]
        ..bestBad = scoreData["bad"]
        ..bestMiss = scoreData["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = old_pj_songs.normal
        ..hard = old_pj_songs.hard
        ..expert = expertInfo
        ..master = old_pj_songs.master;
    } else if (scoreData['diff'] == 'HARD') {
      final hardInfo = pj_level_and_score()
        ..level = old_pj_songs.hard.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreData["perfect"]
        ..bestGreat = scoreData["great"]
        ..bestGood = scoreData["good"]
        ..bestBad = scoreData["bad"]
        ..bestMiss = scoreData["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = old_pj_songs.normal
        ..hard = hardInfo
        ..expert = old_pj_songs.expert
        ..master = old_pj_songs.master;
    } else if (scoreData['diff'] == 'NORMAL') {
      final normalInfo = pj_level_and_score()
        ..level = old_pj_songs.normal.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreData["perfect"]
        ..bestGreat = scoreData["great"]
        ..bestGood = scoreData["good"]
        ..bestBad = scoreData["bad"]
        ..bestMiss = scoreData["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = normalInfo
        ..hard = old_pj_songs.hard
        ..expert = old_pj_songs.expert
        ..master = old_pj_songs.master;
    } else {
      final easyInfo = pj_level_and_score()
        ..level = old_pj_songs.easy.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreData["perfect"]
        ..bestGreat = scoreData["great"]
        ..bestGood = scoreData["good"]
        ..bestBad = scoreData["bad"]
        ..bestMiss = scoreData["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = easyInfo
        ..normal = old_pj_songs.normal
        ..hard = old_pj_songs.hard
        ..expert = old_pj_songs.expert
        ..master = old_pj_songs.master;
    }
    await isar.writeTxn(() async => await isar.pj_songs.put(songInfo));
  }

  Future<void> updateFromForm(Map scoreMap) async {
    final isar = await db;
    bool APed = false;
    bool FCed = false;
    pj_song songInfo;
    List result = await isar.pj_songs
        .filter()
        .nameContains(scoreMap['songName'])
        .findAll();
    // if (result.isEmpty) {
    //   List allSongInfo = isar.pj_songs.where().findAllSync();
    //   List<String> allSongName =
    //   List.generate(allSongInfo.length, (index) => allSongInfo[index].name);
    //   BestMatch bestMatch =
    //   StringSimilarity.findBestMatch(scoreData["name"], allSongName);
    //   print(bestMatch.bestMatch.target);
    //   scoreData["name"] = bestMatch.bestMatch.target;
    //   result = await isar.pj_songs
    //       .filter()
    //       .nameContains(scoreData["name"])
    //       .findAll();
    // }
    final old_pj_songs = result[0];
    if (scoreMap["great"] == 0 &&
        scoreMap["good"] == 0 &&
        scoreMap["bad"] == 0 &&
        scoreMap["miss"] == 0)
      APed = true;
    else if (scoreMap["good"] == 0 &&
        scoreMap["bad"] == 0 &&
        scoreMap["miss"] == 0) FCed = true;
    if (scoreMap['diff'] == 'Master') {
      final masterInfo = pj_level_and_score()
        ..level = old_pj_songs.master.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreMap["perfect"]
        ..bestGreat = scoreMap["great"]
        ..bestGood = scoreMap["good"]
        ..bestBad = scoreMap["bad"]
        ..bestMiss = scoreMap["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = old_pj_songs.normal
        ..hard = old_pj_songs.hard
        ..expert = old_pj_songs.expert
        ..master = masterInfo;
    } else if (scoreMap['diff'] == 'Expert') {
      final expertInfo = pj_level_and_score()
        ..level = old_pj_songs.expert.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreMap["perfect"]
        ..bestGreat = scoreMap["great"]
        ..bestGood = scoreMap["good"]
        ..bestBad = scoreMap["bad"]
        ..bestMiss = scoreMap["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = old_pj_songs.normal
        ..hard = old_pj_songs.hard
        ..expert = expertInfo
        ..master = old_pj_songs.master;
    } else if (scoreMap['diff'] == 'Hard') {
      final hardInfo = pj_level_and_score()
        ..level = old_pj_songs.hard.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreMap["perfect"]
        ..bestGreat = scoreMap["great"]
        ..bestGood = scoreMap["good"]
        ..bestBad = scoreMap["bad"]
        ..bestMiss = scoreMap["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = old_pj_songs.normal
        ..hard = hardInfo
        ..expert = old_pj_songs.expert
        ..master = old_pj_songs.master;
    } else if (scoreMap['diff'] == 'Normal') {
      final normalInfo = pj_level_and_score()
        ..level = old_pj_songs.normal.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreMap["perfect"]
        ..bestGreat = scoreMap["great"]
        ..bestGood = scoreMap["good"]
        ..bestBad = scoreMap["bad"]
        ..bestMiss = scoreMap["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = old_pj_songs.easy
        ..normal = normalInfo
        ..hard = old_pj_songs.hard
        ..expert = old_pj_songs.expert
        ..master = old_pj_songs.master;
    } else {
      final easyInfo = pj_level_and_score()
        ..level = old_pj_songs.easy.level
        ..APed = APed
        ..FCed = FCed
        ..bestPerfect = scoreMap["perfect"]
        ..bestGreat = scoreMap["great"]
        ..bestGood = scoreMap["good"]
        ..bestBad = scoreMap["bad"]
        ..bestMiss = scoreMap["miss"];
      songInfo = pj_song()
        ..id = old_pj_songs.id
        ..name = old_pj_songs.name
        ..easy = easyInfo
        ..normal = old_pj_songs.normal
        ..hard = old_pj_songs.hard
        ..expert = old_pj_songs.expert
        ..master = old_pj_songs.master;
    }
    await isar.writeTxn(() async => await isar.pj_songs.put(songInfo));
  }

  Future<List> getPjMaster() async {
    final isar = await db;
    List result = await isar.pj_songs.where().findAll();
    return result;
  }

  Future<List> getPjScores(String sortSetting) async {
    final isar = await db;
    List result = [];
    if (sortSetting == "デフォルト") {
      result = await isar.pj_songs.where().findAll();
    } else if (sortSetting == "曲名") {
      result = await isar.pj_songs.where().sortByName().findAll();
    } else {
      for (int i = 40; i > 1; i--) {
        List<pj_song> newList = isar.pj_songs
            .filter()
            .master((q) => q.levelEqualTo(i))
            .findAllSync();
        result = [...result, ...newList];
      }
    }
    return result;
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [Pj_songSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
