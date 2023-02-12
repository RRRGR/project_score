import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_score/db/db.dart';
import 'package:project_score/model/process_image.dart';
import 'package:project_score/view/component/home/alerts.dart';
import 'package:project_score/view/component/home/ps_drawer.dart';
import 'package:project_score/view/component/home/song_list.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Project Score'),
        actions: [
          IconButton(
            onPressed: () => showDialog(
                context: context, builder: (_) => const ExplainAlert()),
            icon: const Icon(Icons.question_mark),
          )
        ],
      ),
      body: const ShowList(),
      drawer: const PSDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: _onPressed,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _onPressed() async {
    if (!mounted) return;
    showDialog(context: context, builder: (_) => ReadingAlert());
    final List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isEmpty) {
      if (!mounted) return;
      Navigator.pop(context);
      return;
    }
    for (XFile image in images) {
      dynamic path = image.path;
      if (path == null) {
        return;
      }
      final inputImage = InputImage.fromFilePath(path);
      Map scoreInfo;
      try {
        scoreInfo = await processImage(inputImage);
        await IsarService().updateScore(scoreInfo);
      } catch (e) {
        print(e);
        if (!mounted) return;
        Navigator.pop(context);
        showDialog(context: context, builder: (_) => const ErrorAlert());
        return;
      }
    }
    if (!mounted) return;
    Navigator.pop(context);
    if (!mounted) return;
    showDialog(context: context, builder: (_) => const OKAlert());
  }
}
