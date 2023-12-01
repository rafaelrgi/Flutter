import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GitPage extends StatefulWidget {
  const GitPage({super.key, required this.title});

  final String title;

  @override
  State<GitPage> createState() => _GitPageState();
}

class _GitPageState extends State<GitPage> {
  //
  late List<String>? commands;

  List<String> generateCommands() {
    var result = List<String>.empty();
    //TODO:
    result.add('11111111');
    return result;
  }

  void onFocusChange(bool focus) {
    commands = generateCommands();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Focus(
              onFocusChange: onFocusChange,
              child: TextField(
                  decoration: const InputDecoration(labelText: "Card"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 64.0),
              padding: const EdgeInsets.all(16),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white60)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SelectableText('11111111'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        //tooltip: 'Process',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
