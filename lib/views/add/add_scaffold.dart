import 'package:financy/views/add/widgets/form.dart';
import 'package:flutter/material.dart';

class AddScaffold extends StatelessWidget {
  const AddScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: const AddForm(),
    );
  }
}
