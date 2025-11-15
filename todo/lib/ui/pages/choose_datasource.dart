import 'package:flutter/material.dart';
import 'package:todo/core/config.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';

class ChooseDatasource extends StatelessWidget {
  //
  const ChooseDatasource({super.key});

  @override
  Widget build(BuildContext ctx) {
    final todoViewModel = TodoViewModel.instance;

    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (context, _) {
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: const Text('Choose the datasource:'),
                    ),
                    Divider(height: 8, thickness: 1, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DataSourceRadioBtn.fromDataSource(
                            ctx,
                            DataSources.memory,
                          ),
                          DataSourceRadioBtn.fromDataSource(
                            ctx,
                            DataSources.remoteApi,
                          ),
                          DataSourceRadioBtn.fromDataSource(
                            ctx,
                            DataSources.localDb,
                          ),
                          Divider(height: 8, thickness: 1, color: Colors.grey),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: const Text('Cancel'),
                            ),
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

class DataSourceRadioBtn extends RadioBtn {
  const DataSourceRadioBtn({
    super.key,
    required super.dataSource,
    required super.selected,
    required super.onPressed,
  });

  factory DataSourceRadioBtn.fromDataSource(BuildContext ctx, DataSources ds) {
    final todoViewModel = TodoViewModel.instance;

    final selected = (ds == todoViewModel.dataSource);
    return DataSourceRadioBtn(
      dataSource: ds,
      selected: selected,
      onPressed: () async {
        await todoViewModel.setDataSource(ds);
        if (!ctx.mounted) return;
        //returns true only when change the ds
        Navigator.of(ctx).pop(!selected);
      },
    );
  }
}

class RadioBtn extends StatelessWidget {
  //
  final DataSources dataSource;
  final void Function() onPressed;
  final bool selected;

  const RadioBtn({
    super.key,
    required this.dataSource,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext ctx) {
    final Color color = (Theme.of(ctx).textTheme.bodySmall!.color)!;
    final IconData radioIco = selected
        ? Icons.radio_button_checked
        : Icons.radio_button_off_outlined;

    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(radioIco, color: color),
          Text(
            '   ${dataSource.text}',
            style: Theme.of(ctx).textTheme.bodyMedium,
          ),
          const SizedBox(width: 16),
          Icon(dataSource.iconData, color: color),
        ],
      ),
    );
  }
}
