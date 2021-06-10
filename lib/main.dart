import 'package:flutter/material.dart';
import 'package:reddit_clone/screens/post_view.dart';

import 'screens/post_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: BlocPostView.id,
      routes: {
        BlocPostView.id: (context) => BlocPostView(),
      },
    );
  }
}
