import 'package:financy/views/list-view/widgets/list_view_app_bar.dart';
import 'package:flutter/material.dart';

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
          SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.all(10),
                child: Container(
                  color: Colors.white,
                  width: 100,
                  height: 100,
                )),
          ),
        ],
      ),
    );
  }
}
