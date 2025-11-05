import 'package:todo/core/ui_utils.dart';
import 'package:todo/ui/pages/todo_view.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:flutter/material.dart';

class TodosView extends StatelessWidget {
  //

  const TodosView({super.key});

  void itemDialog(BuildContext ctx, [int index = -1]) {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Dialog(child: TodoView(index: index));
      },
    );
  }

  @override
  Widget build(BuildContext _) {
    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (context, __) {
        return todoViewModel.isLoading
            ? const Padding(
                padding: EdgeInsetsGeometry.all(64),
                child: Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(title: const Text('ToDo List')),
                body: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 160),
                  itemCount: todoViewModel.todos.length,
                  itemBuilder: (_, index) {
                    final todo = todoViewModel.todos[index];
                    return ListTile(
                      onTap: () => onItemTap(context, index),
                      title: Text(todo.title),
                      leading: Icon(
                        todo.isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      trailing: IconButton(
                        onPressed: () => itemDialog(context, index),
                        icon: const Icon(Icons.open_in_new),
                        tooltip: 'View details about this item',
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  },
                ),
                floatingActionButton: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () => itemDialog(context),
                      tooltip: 'Add Todo',
                      heroTag: "btn1",
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 16),
                    FloatingActionButton(
                      onPressed: todoViewModel.refreshList,
                      tooltip: 'Refresh the list',
                      heroTag: "btn2",
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Future<void> onItemTap(BuildContext ctx, int index) async {
    var error = await todoViewModel.onItemTap(index);
    if (!ctx.mounted) return;

    if (error.isNotEmpty) {
      UiUtils.alertDialog(ctx, error, 'Saving failed');
    } else {
      UiUtils.toast(ctx, 'Item saved!');
    }
  }
}
