import 'package:flutter/material.dart';
import 'main_game_page.dart';
import 'package:logging/logging.dart';


void main() {
  // ログレベルの設定
  Logger.root.level = Level.ALL; // 全てのログを出力

  // ログリスナーの設定
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoguelikeCardGame',
      home: MainGamePage(),
    );
  }
}