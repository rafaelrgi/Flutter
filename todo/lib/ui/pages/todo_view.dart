import 'package:todo/domain/models/todo.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/ui_utils.dart';

class TodoView extends StatelessWidget {
  //
  static TodoViewModel get todoViewModel => TodoViewModel.instance;

  final int index;
  final Todo _todo;

  TodoView({super.key, required this.index})
    : _todo = todoViewModel.getForEditing(index);

  Future<void> _saveItem(BuildContext ctx, int index, Todo todo) async {
    if (!todoViewModel.canSave(_todo)) return;

    var error = await todoViewModel.saveItem(index, todo);
    if (!ctx.mounted) return;
    //error
    if (error.isNotEmpty) {
      UiUtils.errorDialog(ctx, error, 'Saving failed!');
      return;
    }
    //sucess
    Navigator.of(ctx).pop();
  }

  void _removeItem(BuildContext ctx, int index) {
    final navigator = Navigator.of(ctx);

    UiUtils.yesNoDialog(ctx, 'Confirm item deletion?', 'Delete item', () async {
      navigator.pop();
      var error = await todoViewModel.removeItem(index);
      if (!ctx.mounted) return;

      //error
      if (error.isNotEmpty) {
        UiUtils.errorDialog(ctx, error, 'Deletion failed!');
        return;
      }
      //sucess
      navigator.pop();
      UiUtils.toast(ctx, 'Item deleted');
    });
  }

  @override
  Widget build(_) {
    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (ctx, child) {
        final theme = Theme.of(ctx);
        final navigator = Navigator.of(ctx);

        return todoViewModel.isLoading
            ? const Padding(
                padding: .all(64),
                child: Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisSize: .max,
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Padding(
                            padding: const .symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: Text(_todo.title, overflow: .ellipsis),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => _removeItem(ctx, index),
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
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .start,
                        children: [
                          InkWell(
                            onTap: () => todoViewModel.onCheckItem(_todo),
                            child: Row(
                              children: [
                                Icon(
                                  _todo.isDone
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: theme.dividerColor,
                                ),
                                const Text('   Completed?'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: _todo.title,
                            onChanged: (value) => _todo.title = value,
                            decoration: InputDecoration(
                              labelText: 'Todo',
                              errorText: todoViewModel.validateTitle(_todo),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: .end,
                            children: [
                              TextButton(
                                onPressed: () => navigator.pop(),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 16),
                              TextButton(
                                onPressed: todoViewModel.canSave(_todo)
                                    ? () => _saveItem(ctx, index, _todo)
                                    : null,
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
