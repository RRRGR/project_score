import 'package:project_score/db/pj_songs.dart';

List<ChartData> getDiffCounterList(List<pj_song> songDataList) {
  int allAPCounter = 0;
  int allFCCounter = 0;
  int masterAPCounter = 0;
  int masterFCCounter = 0;
  int expertAPCounter = 0;
  int expertFCCounter = 0;
  int hardAPCounter = 0;
  int hardFCCounter = 0;
  int normalAPCounter = 0;
  int normalFCCounter = 0;
  int easyAPCounter = 0;
  int easyFCCounter = 0;
  for (pj_song songData in songDataList) {
    bool? masterAPed = songData.master.APed;
    bool? masterFCed = songData.master.FCed;
    bool? expertAPed = songData.expert.APed;
    bool? expertFCed = songData.expert.FCed;
    bool? hardAPed = songData.hard.APed;
    bool? hardFCed = songData.hard.FCed;
    bool? normalAPed = songData.normal.APed;
    bool? normalFCed = songData.normal.FCed;
    bool? easyAPed = songData.easy.APed;
    bool? easyFCed = songData.easy.FCed;
    if (masterAPed != null && masterAPed) {
      masterAPCounter++;
      allAPCounter++;
    } else if (masterFCed != null && masterFCed) {
      masterFCCounter++;
      allFCCounter++;
    }
    if (expertAPed != null && expertAPed) {
      expertAPCounter++;
      allAPCounter++;
    } else if (expertFCed != null && expertFCed) {
      expertFCCounter++;
      allFCCounter++;
    }
    if (hardAPed != null && hardAPed) {
      hardAPCounter++;
      allAPCounter++;
    } else if (hardFCed != null && hardFCed) {
      hardFCCounter++;
      allFCCounter++;
    }
    if (normalAPed != null && normalAPed) {
      normalAPCounter++;
      allAPCounter++;
    } else if (normalFCed != null && normalFCed) {
      normalFCCounter++;
      allFCCounter++;
    }
    if (easyAPed != null && easyAPed) {
      easyAPCounter++;
      allAPCounter++;
    } else if (easyFCed != null && easyFCed) {
      easyFCCounter++;
      allFCCounter++;
    }
  }
  int allOtherCounter = songDataList.length * 5 - allAPCounter - allFCCounter;
  int masterOtherCounter =
      songDataList.length - masterAPCounter - masterFCCounter;
  int expertOtherCounter =
      songDataList.length - expertAPCounter - expertFCCounter;
  int hardOtherCounter = songDataList.length - hardAPCounter - hardFCCounter;
  int normalOtherCounter =
      songDataList.length - normalAPCounter - normalFCCounter;
  int easyOtherCounter = songDataList.length - easyAPCounter - easyFCCounter;
  List<ChartData> chartData = [
    ChartData("Easy", easyAPCounter, easyFCCounter, easyOtherCounter),
    ChartData("Normal", normalAPCounter, normalFCCounter, normalOtherCounter),
    ChartData("Hard", hardAPCounter, hardFCCounter, hardOtherCounter),
    ChartData("Expert", expertAPCounter, expertFCCounter, expertOtherCounter),
    ChartData("Master", masterAPCounter, masterFCCounter, masterOtherCounter),
    ChartData("All", allAPCounter, allFCCounter, allOtherCounter)
  ];
  return chartData;
}

class ChartData {
  ChartData(this.diff, this.apNum, this.fcNum, this.otherNum);
  final String diff;
  final num apNum;
  final num fcNum;
  final num otherNum;
}
