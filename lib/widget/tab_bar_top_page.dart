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
      home: const TabbarTopPage(),
    );
  }
}

class TabbarTopPage extends StatefulWidget {
  const TabbarTopPage({Key? key}) : super(key: key);

  @override
  State<TabbarTopPage> createState() => _TabbarTopPageState();
}

class _TabbarTopPageState extends State<TabbarTopPage> {
  final PageController pageController = new PageController();
  final List<String> tab = ["动态", "趋势", "我的"];

  ///渲染 Tab
  _renderTab() {
    List<Widget> list = [];
    for (int i = 0; i < tab.length; i++) {
      list.add(
        new FlatButton(
          onPressed: () {
            ///每个 Tabbar 点击时，通过jumpTo 跳转页面
            ///每个页面需要跳转坐标为：当前屏幕大小 * 索引 index。
            pageController.jumpTo(MediaQuery.of(context).size.width * i);
          },
          child: new Text(
            tab[i],
            maxLines: 1,
          ),
        ),
      );
    }
    return list;
  }

  _renderPage() {
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
      type: TabType.top,
      tabItems: _renderTab(),
      tabViews: _renderPage(),
      pageController: pageController,
      isScrollable: true,
    );
  }
}
