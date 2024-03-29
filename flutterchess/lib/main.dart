// This code is distributed under the MIT License.
// Copyright (c) 2019 Remi Rousselet.
// You can find the original at https://github.com/rrousselGit/provider.


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/chess/data/data_array_provider.dart';
import 'package:flutterchess/features/main_window/data/widget_on_screen.dart';
import 'package:flutterchess/features/chess/data/game_controller_provider.dart';


// This is a reimplementation of the default Flutter application
// using provider + [ChangeNotifier].
void main() {
  runApp(
    // Providers are above [MyApp] instead of inside it, so that
    // tests can use [MyApp] while mocking the providers
  
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataArray()),
        ChangeNotifierProvider(create: (context) =>WidgetOnScreen()),
        ChangeNotifierProvider(create: (context) =>GameController())
      ],

      
      child: const MyApp(),
    ),
  );
}

// Mix-in [DiagnosticableTreeMixin] to have access to


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Add ChessBoard to the Body

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.lightGreen.shade200,
        child: Consumer<WidgetOnScreen>(builder: (context, widgetProvider, child)=>
         Stack(children: Provider.of<WidgetOnScreen>(context, listen:false).onScreen))),
      floatingActionButton: 
      Consumer<WidgetOnScreen>(builder:(context, value, child) => 
      FloatingActionButton(
        onPressed: () {
          Provider.of<DataArray>(context, listen: false).setData();
          Provider.of<GameController>(context,listen:false).restartPosition();
        },
        child: const Icon(Icons.clear),
      )),
    );

  }
}