import 'package:financy/commands/item_notifier.dart';
import 'package:financy/views/add/add_scaffold.dart';
import 'package:financy/views/list-view/widgets/item_card.dart';
import 'package:financy/views/list-view/widgets/list_view_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewScaffold extends StatefulWidget {
  const ListViewScaffold({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListViewScaffoldState();
  }
}

class ListViewScaffoldState extends State<ListViewScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const ListViewAppBar(),
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
