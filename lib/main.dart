import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sqlite_todolist/provider/task_provider.dart';
import 'package:sqlite_todolist/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TaskProvider()..getTasks(),
      child: Sizer(builder: (_,orientation,deviceType){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      }),
    );
  }
}

