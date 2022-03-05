import 'package:flutter/material.dart';

class ListViewAppBar extends StatefulWidget {
  const ListViewAppBar({Key? key}) : super(key: key);

  @override
  State<ListViewAppBar> createState() => _ListViewAppBarState();
}

class _ListViewAppBarState extends State<ListViewAppBar> {
  String _title = 'Everything', _timeFrame = '';

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      backgroundColor: Theme.of(context).colorScheme.background,
      floating: true,
      snap: true,
      toolbarHeight: 0,
      collapsedHeight: 0,
      flexibleSpace: SafeArea(
        child: FlexibleSpaceBar(
          title: Center(
            child: Container(margin: EdgeInsets.only(right: 5), child: Text(_title)),
          ),
          background: Container(
            margin: const EdgeInsets.only(top: 150, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(_timeFrame,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      onSelected: (item) {
                        setState(() {
                          _timeFrame = item as String;
                        });
                      },
                      icon: Icon(
                        Icons.access_time,
                        size: 35,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text('All time'),
                            value: '',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                          PopupMenuItem(
                            child: Text('Last week'),
                            value: 'Last week',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                          PopupMenuItem(
                            child: Text('Last month'),
                            value: 'Last month',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                          PopupMenuItem(
                            child: Text('today'),
                            value: 'Today',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                        ];
                      },
                    ),
                    PopupMenuButton(
                      onSelected: (item) {
                        setState(() {
                          _title = item as String;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 35,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text('Everything'),
                            value: 'Everything',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                          PopupMenuItem(
                            child: Text('Expenses'),
                            value: 'Expenses',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                          PopupMenuItem(
                            child: Text('Incomes'),
                            value: 'Incomes',
                            textStyle: TextStyle(color: Color(0xffeeeeee)),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
          titlePadding: const EdgeInsets.only(top: 150),
          expandedTitleScale: 2,
        ),
      ),
    );
  }
}
