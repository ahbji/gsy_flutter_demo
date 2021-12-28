import 'package:flutter/material.dart';

class KeepAliveList extends StatefulWidget {
  @override
  _KeepAliveListState createState() => _KeepAliveListState();
}

class _KeepAliveListState extends State<KeepAliveList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new ListView.builder(
      itemBuilder: (context, index) {
        return new Card(
          ///设置阴影的深度
          elevation: 5.0,

          ///增加圆角
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: Colors.white,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
          child: new Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 80,
            child: new Text("显示文本 ${index}"),
          ),
        );
      },
      itemCount: 20,
    );
  }
}
