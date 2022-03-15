import 'package:financy/models/enums/item_type.dart';
import 'package:financy/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../commands/item_notifier.dart';
import '../../../models/item.dart';
import '../../../services/item_service.dart';
import 'form_field.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddFormState();
  }
}

class AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleC = TextEditingController(), _descC = TextEditingController(), _amountC = TextEditingController();
  var _isIncome = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AddFormField(_titleC, 'Title', 'Please add a title for this entry', 1),
                AddFormField(_descC, 'Description', 'Please add a description for this entry', 4),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundColor:
                              _isIncome ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.primary,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isIncome = !_isIncome;
                              });
                            },
                            icon: Icon(
                              _isIncome ? Icons.add : Icons.remove,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _amountC,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add an amount for this entry';
                            } else if (double.parse(value) < 0 && _isIncome) {
                              return 'Please add a positive amount for incomes';
                            } else if (double.parse(value) >= 0 && !_isIncome) {
                              return 'Please add a negative amount for expenses';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: InkWell(
                child: Ink(
                  color: _isIncome ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.primary,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Add ${_isIncome ? 'Income' : 'Expense'}',
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
                onTap: () async {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    LatLng location = await LocationService.getLocation();
                    await ItemService.insert(Item(
                        title: _titleC.text,
                        description: _descC.text,
                        amount: double.parse(_amountC.text),
                        dateTime: DateTime.now(),
                        itemType: _isIncome ? ItemType.income : ItemType.expense,
                        latitude: location.latitude,
                        longitude: location.longitude));
                    Provider.of<ItemNotifier>(context, listen: false).getCurrent();
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
