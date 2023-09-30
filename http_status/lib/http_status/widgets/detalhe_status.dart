import 'package:flutter/material.dart';
import 'package:http_status/http_status/model.dart';

class DetalheStatus extends StatelessWidget {
  const DetalheStatus({
    super.key,
    required this.codigo,
    required this.httpStatus,
  });

  final int codigo;
  final HttpStatus httpStatus;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatusDto>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        StatusDto status = snapshot.data ?? StatusDto();
        return ListView(
          children: [
            Center(
                child:
                    Text(status.code.toString(), style: Theme.of(context).textTheme.headlineSmall)),
            Center(child: Text(status.title, style: Theme.of(context).textTheme.headlineSmall)),
            const SizedBox(height: 16),
            Image(image: NetworkImage(status.image)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                child: Text('Voltar'),
              ),
            ),
          ],
        );
      },
      future: httpStatus.getStatus(codigo),
    );
  }
}
