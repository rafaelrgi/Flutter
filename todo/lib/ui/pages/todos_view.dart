import 'package:todo/core/app.dart';
import 'package:todo/core/config.dart';
import 'package:todo/core/ui_utils.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/pages/choose_datasource.dart';
import 'package:todo/ui/pages/todo_view.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:flutter/material.dart';

//This Widget is composed by other helper widgets
//Those are kept in this file as private classes as they won't be used
//anywhere else
class TodosView extends StatelessWidget {
  //
  static const String _title = 'ToDo List';
  TodoViewModel get todoViewModel => TodoViewModel.instance;

  const TodosView({super.key});

  void _itemDialog(BuildContext ctx, [int index = -1]) {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(child: TodoView(index: index));
      },
    );
  }

  Future<void> _onItemTap(BuildContext ctx, int index) async {
    var error = await todoViewModel.checkAndSaveItem(index);
    if (!ctx.mounted) return;

    if (error.isNotEmpty) {
      UiUtils.alertDialog(ctx, error, 'Saving failed');
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

  Future<void> _changeTheme(BuildContext ctx) async {
    int i = (appController.themeMode.index + 1);
    if (i >= ThemeMode.values.length) {
      i = 0;
    }
    ThemeMode val = ThemeMode.values[i];
    await Config.setTheme(val);
    appController.themeMode = val;
    if (!ctx.mounted) return;
    UiUtils.toast(ctx, appController.themeMode.toString());
  }

  @override
  Widget build(BuildContext ctx) {
    return FutureBuilder<List<Todo>>(
      future: todoViewModel.fetchAll(),
      builder: (_, AsyncSnapshot<List<Todo>> snapshot) {
        final theme = Theme.of(ctx);
        final isDarkMode = theme.brightness == .dark;

        //waiting
        if (snapshot.connectionState == .waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: _leading(isDarkMode: isDarkMode),
              title: const Text(_title),
            ),
            body: Center(child: CircularProgressIndicator()),
          );

          //hasData
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: _leading(isDarkMode: isDarkMode),
              title: const Text(_title),
              actions: [
                IconButton(
                  icon: Icon(todoViewModel.dataSource.iconData),
                  tooltip: 'Change data source',
                  onPressed: () => _changeDataSource(ctx),
                ),

                IconButton(
                  icon: const Icon(Icons.brightness_6_outlined),
                  tooltip: 'Change theme',
                  onPressed: () => _changeTheme(ctx),
                ),
              ],
            ),
            floatingActionButton: _floatingActionButtons(
              _itemDialog,
              (_) => _loadData(ctx), //must use THIS ctx
            ),

            body: _todoList(_itemDialog, _onItemTap),
          );

          //error
        } else {
          //if (snapshot.hasError)
          return Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: _loadingError(_loadData),
          );
        }
      },
    );
  }
}

//------------------------------------------------------------------------------
//Helper widgets, kept in this file as private classes because they won't be
//used anywhere else

// ignore: camel_case_types
class _leading extends StatelessWidget {
  //
  final bool isDarkMode;

  const _leading({required this.isDarkMode});

  @override
  Widget build(BuildContext ctx) {
    final navigator = Navigator.of(ctx);

    return Tooltip(
      message: 'Logout',
      child: TextButton(
        onPressed: () => navigator.pushReplacementNamed('/'),
        child: Hero(
          tag: 'icon',
          child: isDarkMode
              ? Image.asset('assets/icons/app_icon_p_dark.png')
              : Image.asset('assets/icons/app_icon_p.png'),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _floatingActionButtons extends StatelessWidget {
  //
  final void Function(BuildContext) itemDialog;
  final void Function(BuildContext) loadData;

  const _floatingActionButtons(this.itemDialog, this.loadData);

  @override
  Widget build(BuildContext ctx) {
    return Row(
      crossAxisAlignment: .end,
      mainAxisAlignment: .end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () => itemDialog(ctx),
          tooltip: 'Add Todo',
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () => loadData(ctx),
          tooltip: 'Refresh the list',
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class _loadingError extends StatelessWidget {
  //
  final String? message;
  final void Function(BuildContext) loadData;

  const _loadingError(this.loadData, [this.message]);

  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);

    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 64),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          Text(
            message ?? 'Failed to load data',
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
          ),
          Divider(height: 16, thickness: 1, color: Colors.grey),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => loadData(ctx),
            child: const Text('Retry!'),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _todoList extends StatelessWidget {
  //
  final void Function(BuildContext, int) itemDialog;
  final void Function(BuildContext, int) itemTap;

  TodoViewModel get todoViewModel => TodoViewModel.instance;

  const _todoList(this.itemDialog, this.itemTap);

  @override
  Widget build(BuildContext ctx) {
    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (_, _) {
        return ListView.builder(
          padding: const .fromLTRB(8, 8, 8, 160),
          itemCount: todoViewModel.todos.length,
          itemBuilder: (_, index) {
            final todo = todoViewModel.todos[index];
            return ListTile(
              onTap: () => itemTap(ctx, index),
              title: Text(todo.title),
              leading: Icon(
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              trailing: IconButton(
                onPressed: () => itemDialog(ctx, index),
                icon: const Icon(Icons.open_in_new),
                tooltip: 'View details about this item',
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1),
                borderRadius: .circular(5),
              ),
            );
          },
        );
      },
    );
  }
}
