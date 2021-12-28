import 'package:flutter/material.dart';
import 'package:gsy_flutter_demo/widget/tabbar/keep_alive_list.dart';
import 'package:gsy_flutter_demo/widget/tabbar/tab_bar_suite.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter.demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabWidgetBottomPage(),
    );
  }
}

class TabWidgetBottomPage extends StatefulWidget {
  const TabWidgetBottomPage({Key? key}) : super(key: key);

  @override
  State<TabWidgetBottomPage> createState() => _TabWidgetBottomPageState();
}

class _TabWidgetBottomPageState extends State<TabWidgetBottomPage> {
  List<Tab> _getTab() {
    return [
      Tab(
        icon: Icon(Icons.access_alarm),
      ),
      Tab(
        icon: Icon(Icons.android),
      ),
      Tab(
        icon: Icon(Icons.ac_unit),
      ),
    ];
  }

  List<Widget> _renderPage() {
    return [
      Container(
        color: Colors.blue,
        child: KeepAliveList(),
      ),
      Container(
        color: Colors.red,
        child: KeepAliveList(),
      ),
      Container(
        color: Colors.amber,
        child: KeepAliveList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TabBarSuite(
      title: Text("标题"),
      type: TabType.bottom,
      tabItems: _getTab(),
      tabViews: _renderPage(),
    );
  }
}
