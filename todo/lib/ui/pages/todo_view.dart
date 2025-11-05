import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/ui_utils.dart';

class TodoView extends StatelessWidget {
  //
  final int index;

  const TodoView({super.key, required this.index});

  Future<void> saveItem(BuildContext ctx, int index, Todo todo) async {
    var error = await todoViewModel.saveItem(index, todo);
    //error
    if (error.isNotEmpty) {
      if (ctx.mounted) {
        UiUtils.errorDialog(ctx, error, 'Saving failed!');
        return;
      }
    }
    //sucess
    if (ctx.mounted) {
      Navigator.of(ctx).pop();
      UiUtils.toast(ctx, 'Item saved!');
    }
  }

  void removeItem(BuildContext ctx, int index) {
    UiUtils.yesNoDialog(ctx, 'Confirm item deletion?', 'Delete item', () async {
      Navigator.of(ctx).pop();
      //error
      var error = await todoViewModel.removeItem(index);
      if (error.isNotEmpty) {
        if (ctx.mounted) {
          UiUtils.errorDialog(ctx, error, 'Deletion failed!');
        }
        return;
      }
      //sucess
      if (ctx.mounted) {
        Navigator.of(ctx).pop();
        UiUtils.toast(ctx, 'Item deleted');
      }
    });
  }

  @override
  Widget build(BuildContext _) {
    Todo todo = index >= 0 ? Todo.copy(todoViewModel.todos[index]) : Todo();
    if (todo.title.isEmpty) todo.title = 'Todo';

    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (context, child) {
        return todoViewModel.isLoading
            ? const Padding(
                padding: EdgeInsetsGeometry.all(64),
                child: Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: Text(
                              todo.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => removeItem(context, index),
                            tooltip: 'Delete this todo item',
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 8, thickness: 1, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => todoViewModel.checkItem(todo),
                            child: Row(
                              children: [
                                Icon(
                                  todo.isDone
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: Theme.of(context).dividerColor,
                                ),
                                const Text('   Completed?'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: todo.title,
                            onChanged: (value) =>
                                todoViewModel.textItem(todo, value),
                            decoration: InputDecoration(
                              labelText: 'Todo',
                              errorText: todo.title.trim().isNotEmpty
                                  ? null
                                  : 'Required field',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 16),
                              TextButton(
                                onPressed: () => saveItem(context, index, todo),
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
