import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GitPage extends StatefulWidget {
  const GitPage({super.key, required this.title});

  final String title;

  @override
  State<GitPage> createState() => _GitPageState();
}

enum WorkItemType { feature, fix }

class _GitPageState extends State<GitPage> {
  //
  int _workItem = 0;
  WorkItemType _type = WorkItemType.fix;
  List<String>? commands_1;
  List<String>? commands_2;

  List<String> generateCommands1(int num) {
    final branch = '${_type == WorkItemType.fix ? 'Fix' : 'Feature'}/Card$num';
    final result = List<String>.empty(growable: true);

    result.add('git status');
    result.add('');
    result.add('git branch $branch');
    result.add('git checkout $branch');
    result.add('git add .');
    result.add('git-cz');
    result.add('');
    result.add('git push -u origin $branch');
    result.add('');

    return result;
  }

  List<String> generateCommands2(int workItem) {
    //final branch = '${_type==WorkItemType.fix? 'Fix' : 'Feature'}/Card$num';
    final result = List<String>.empty(growable: true);

    result.add('git status');
    result.add('git restore .');
    result.add('');
    result.add('git checkout garantia');
    result.add('git fetch --all');
    result.add('git pull --all');
    result.add('');
    // &&
    result.add(
        'flutter clean \r\n flutter pub get \r\n flutter packages pub get \r\n flutter pub run build_runner build --delete-conflicting-outputs \r\n flutter pub run intl_utils:generate');
    result.add('');

    return result;
  }

  bool get canProcess => _workItem > 0;

  void setCard(String value) {
    _workItem = int.tryParse(value) ?? 0;
    setState(() {});
  }

  void onProcess() {
    commands_1 = generateCommands1(_workItem);
    commands_2 = generateCommands2(_workItem);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: MediaQuery.of(context).size.width < 790
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: TextField(
                            onChanged: setCard,
                            autofocus: true,
                            decoration: const InputDecoration(
                                labelText: "Número do item"),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                      ),
                      const Flexible(flex: 5, child: SizedBox(width: 80.0)),
                      Flexible(
                          flex: 3,
                          child: RadioListTile(
                              title: const Text('Fix'),
                              value: WorkItemType.fix,
                              groupValue: _type,
                              onChanged: (value) => setState(() {
                                    _type = value!;
                                  }))),
                      Flexible(
                          flex: 6,
                          child: RadioListTile(
                              title: const Text('Feature'),
                              value: WorkItemType.feature,
                              groupValue: _type,
                              onChanged: (value) => setState(() {
                                    _type = value!;
                                  }))),
                      Flexible(
                          flex: 1,
                          child: IconButton(
                              tooltip: 'Process',
                              icon: const Icon(Icons.play_arrow),
                              style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              onPressed: !canProcess ? null : onProcess)),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Texts(commands: commands_1),
                        _Texts(commands: commands_2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Visibility(
        visible: canProcess,
        child: FloatingActionButton(
          tooltip: 'Process',
          onPressed: onProcess,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

class _Texts extends StatelessWidget {
  const _Texts({
    required this.commands,
  });

  final List<String>? commands;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.15,
      margin: const EdgeInsets.only(top: 64.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white60)),
      child: commands == null
          ? const SizedBox()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (var s in commands!) _CopyableText(s),
              ],
            ),
    );
  }
}

class _CopyableText extends StatelessWidget {
  final String _text;

  const _CopyableText(this._text);

  void _copy(text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return _text.isEmpty
        ? const SizedBox(height: 32)
        : Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton.icon(
              icon: const Icon(
                Icons.copy,
                size: 24.0,
              ),
              label: Text(_text, overflow: TextOverflow.fade),
              style: TextButton.styleFrom(foregroundColor: Colors.white70),
              onPressed: () => _copy(_text),
            ),
          );
  }
}
