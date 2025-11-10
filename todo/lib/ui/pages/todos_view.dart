import 'package:todo/core/config.dart';
import 'package:todo/core/ui_utils.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/pages/choose_datasource.dart';
import 'package:todo/ui/pages/todo_view.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:flutter/material.dart';

class TodosView extends StatelessWidget {
  //

  static const String _title = 'ToDo List';

  const TodosView({super.key});

  void _itemDialog(BuildContext ctx, [int index = -1]) {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Dialog(child: TodoView(index: index));
      },
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return FutureBuilder<List<Todo>>(
      future: todoViewModel.fetchAll(),
      builder: (BuildContext _, AsyncSnapshot<List<Todo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _page(ctx, false, Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          return _page(ctx, true, _todoList(ctx));
        } else {
          // if (snapshot.hasError)
          return _page(ctx, false, _loadingError(ctx));
        }
      },
    );
  }

  Future<void> _onItemTap(BuildContext ctx, int index) async {
    var error = await todoViewModel.checkAndSaveItem(index);
    if (!ctx.mounted) return;

    if (error.isNotEmpty) {
      UiUtils.alertDialog(ctx, error, 'Saving failed');
    } else {
      UiUtils.toast(ctx, 'Item saved!');
    }
  }

  void _loadData(BuildContext ctx) {
    (ctx as Element).markNeedsBuild();
  }

  Future<void> _changeDataSource(BuildContext ctx) async {
    if (!await showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Dialog(child: ChooseDatasource());
      },
    )) {
      return;
    }
    if (ctx.mounted) _loadData(ctx);
  }

  IconData _dataSourceIcon() {
    switch (todoViewModel.dataSource) {
      case DataSources.memory:
        return Icons.memory_outlined;
      case DataSources.remoteApi:
        return Icons.cloud_outlined;
      case DataSources.localDb:
        return Icons.sd_storage_outlined;
      case DataSources.none:
        return Icons.cable_sharp;
    }
  }

  Widget _page(BuildContext ctx, bool floatingActionBtn, Widget body) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        actions: [
          IconButton(
            icon: Icon(_dataSourceIcon()),
            tooltip: 'Change data source',
            onPressed: () => _changeDataSource(ctx),
          ),
          /*
          //UNDONE: change theme
          IconButton(
            icon: Icon(Icons.brightness_6_outlined),
            tooltip: 'Change theme',
            onPressed: () => UiUtils.toast(ctx, "Ñot implemented yet!"),
          ),
          */
        ],
      ),
      body: body,
      floatingActionButton: floatingActionBtn
          ? _floatingActionButton(ctx)
          : const SizedBox(),
    );
  }

  Widget _floatingActionButton(BuildContext ctx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () => _itemDialog(ctx),
          tooltip: 'Add Todo',
          heroTag: "btn1",
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          onPressed: () => _loadData(ctx),
          tooltip: 'Refresh the list',
          heroTag: "btn2",
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  Widget _todoList(BuildContext ctx) {
    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (context, __) {
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 160),
          itemCount: todoViewModel.todos.length,
          itemBuilder: (_, index) {
            final todo = todoViewModel.todos[index];
            return ListTile(
              onTap: () => _onItemTap(ctx, index),
              title: Text(todo.title),
              leading: Icon(
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              trailing: IconButton(
                onPressed: () => _itemDialog(ctx, index),
                icon: const Icon(Icons.open_in_new),
                tooltip: 'View details about this item',
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        );
      },
    );
  }

  Widget _loadingError(BuildContext ctx, [String? loadingError]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            loadingError ?? 'Failed to load data',
            style: Theme.of(
              ctx,
            ).textTheme.bodyLarge?.copyWith(color: Colors.red),
          ),
          Divider(height: 16, thickness: 1, color: Colors.grey),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _loadData(ctx),
            child: const Text('Retry!'),
          ),
        ],
      ),
    );
  }
}
