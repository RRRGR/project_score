import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_score/model/provider.dart';

class SortButton extends ConsumerWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortSetting = ref.watch(sortProvider);
    return DropdownButton(
      value: sortSetting,
      items: ['デフォルト', 'レベル', '曲名'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(sortProvider.notifier).state = value!;
        ref.refresh(streamSongDataProvider);
      },
    );
  }
}

class DiffButton extends ConsumerWidget {
  const DiffButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diffSetting = ref.watch(diffProvider);
    return DropdownButton(
      value: diffSetting,
      items: ['Easy', 'Normal', 'Hard', 'Expert', 'Master'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(diffProvider.notifier).state = value!;
        ref.refresh(streamSongDataProvider);
      },
    );
  }
}
