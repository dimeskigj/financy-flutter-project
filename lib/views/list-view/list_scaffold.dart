import 'package:financy/commands/item_notifier.dart';
import 'package:financy/views/add/add_scaffold.dart';
import 'package:financy/views/list-view/widgets/item_card.dart';
import 'package:financy/views/list-view/widgets/list_view_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class ListViewScaffold extends StatefulWidget {
  const ListViewScaffold({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListViewScaffoldState();
  }
}

class ListViewScaffoldState extends State<ListViewScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  void openDrawer() => _key.currentState?.openDrawer();

  ShakeDetector? _shakeDetector;

  @override
  void initState() {
    _shakeDetector ??= ShakeDetector.waitForStart(
        // shakeThresholdGravity: 2.7,
        onPhoneShake: () {
      // showDialog(context: context, builder: (BuildContext ctx) {
      //   print('ok');
      //   return const AlertDialog(title: Text('Don\'t be depresso, have an espresso'),);
      // });
      print('==============================\nok================================\n');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Don't be depresso, have an espresso")));
    });
    _shakeDetector?.startListening();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: CustomScrollView(
        slivers: [
          ListViewAppBar(),
          ...context.watch<ItemNotifier>().itemList.map((e) => SliverToBoxAdapter(key: Key(e.id.toString()), child: ItemCard(e))),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 200,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddScaffold()));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
