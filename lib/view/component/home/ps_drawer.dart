import 'package:flutter/material.dart';
import 'package:project_score/view/screen/graph_page.dart';

class PSDrawer extends StatelessWidget {
  const PSDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: const Text('グラフ'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GraphPage()));
          },
        ),
      ]),
    );
  }
}
