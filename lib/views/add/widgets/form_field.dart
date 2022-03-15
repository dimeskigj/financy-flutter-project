import 'package:flutter/material.dart';

class AddFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _title, _message;
  final int _maxLines;

  const AddFormField(this._controller, this._title, this._message, this._maxLines, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _message;
              }
              return null;
            },
            maxLines: _maxLines,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            decoration: InputDecoration(labelText: _title, border: const OutlineInputBorder()),
          )
        ],
      ),
    );
  }
}
