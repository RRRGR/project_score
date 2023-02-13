import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_score/model/ad.dart';
import 'package:project_score/view/component/graph/show_graph.dart';

class GraphPage extends ConsumerStatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends ConsumerState<GraphPage> {
  BannerAd myBanner = BannerAd(
    adUnitId: getBannerUnitId(),
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  @override
  void initState() {
    myBanner.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('グラフ'),
      ),
      body: Column(
        children: [
          const ShowGraph(),
          SizedBox(
            height: 50.0,
            width: double.infinity,
            child: AdWidget(ad: myBanner),
          ),
        ],
      ),
    );
  }
}
