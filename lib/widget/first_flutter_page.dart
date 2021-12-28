import 'package:flutter/material.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstFlutterPage(),
    );
  }
}

class FirstFlutterPage extends StatelessWidget {
  const FirstFlutterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("First Flutter Page"),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => const DemoItem(),
        itemCount: 20,
      ),
    );
  }
}

class DemoItem extends StatelessWidget {
  const DemoItem({Key? key}) : super(key: key);

  ///返回一个居中带图标和文本的Item
  _getBottomItem(IconData icon, String text) {
    ///充满 Row 横向的布局
    return Expanded(
      flex: 1,

      ///居中显示
      child: Center(
        ///横向布局
        child: Row(
          ///主轴居中,即是横向居中
          mainAxisAlignment: MainAxisAlignment.center,

          ///大小按照最大充满
          mainAxisSize: MainAxisSize.max,

          ///竖向也居中
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ///一个图标，大小16.0，灰色
            Icon(
              icon,
              size: 16.0,
              color: Colors.grey,
            ),

            ///间隔
            const Padding(padding: EdgeInsets.only(left: 5.0)),

            ///显示文本
            Text(
              text,
              //设置字体样式：颜色灰色，字体大小14.0
              style: const TextStyle(color: Colors.grey, fontSize: 14.0),
              //超过的省略为...显示
              overflow: TextOverflow.ellipsis,
              //最长一行
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      ///卡片包装
      child: Card(
        ///增加点击效果
        child: TextButton(
          onPressed: () {
            print("点击了哦");
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ///文本描述
                Container(
                    child: const Text(
                      "这是一点描述",
                      style: TextStyle(
                        color: Color(0xff959595),
                        fontSize: 14.0,
                      ),

                      ///最长三行，超过 ... 显示
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                    alignment: Alignment.topLeft),
                const Padding(padding: EdgeInsets.all(10.0)),

                ///三个平均分配的横向图标文字
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getBottomItem(Icons.star, "1000"),
                    _getBottomItem(Icons.link, "1000"),
                    _getBottomItem(Icons.subject, "1000"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
