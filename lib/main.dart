import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Page(),
    );
  }
}

List<String> mainList = ['A', 'B', 'C'];
List<String> tempList = ['A', 'B', 'C', 'D', 'E'];

final listStateProvider = StateProvider((ref) => mainList);
final selectedTextStateProvider = StateProvider((ref) => "");

class Page extends ConsumerWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("list: ${ref.watch(listStateProvider)}"),
            Text("selected: ${ref.watch(selectedTextStateProvider)}"),
            DropdownMenu<String>(
              label: const Text("Text"),
              // Ref watch no working.
              dropdownMenuEntries: ref.watch(listStateProvider).map((text) => DropdownMenuEntry<String>(
                value: text,
                label: text,
              )).toList(),
              onSelected: (String? selected) {
                ref.read(selectedTextStateProvider.notifier).state = selected ?? "N/A";
              },
            ),
            FilledButton(
              onPressed: () {
                ref.read(listStateProvider.notifier).state = tempList;
              },
              child: const Text("Change dropdownMenuEntries"),
            ),
          ],
        ),
      ),
    );
  }
}
