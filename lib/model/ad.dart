import 'dart:io';

String getBannerUnitId() {
  String bannerUnitId = "";
  if (Platform.isAndroid) {
    bannerUnitId = "ca-app-pub-3940256099942544/6300978111";
  } else if (Platform.isIOS) {
    bannerUnitId = "ca-app-pub-3940256099942544/2934735716";
  }
  return bannerUnitId;
}
