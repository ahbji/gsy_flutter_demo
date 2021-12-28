import 'package:flutter/material.dart';

class StfWidget extends StatefulWidget {

  const StfWidget({Key? key}) : super(key: key);

  @override
  _StfWidgetState createState() => _StfWidgetState();
}

class _StfWidgetState extends State<StfWidget> {
  String? text;

  _StfWidgetState({this.text});

  @override
  void initState() {
    // 初始化
    super.initState();
    // 定时 1 秒
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        text = '这就变了数值';
      });
      return true;
    });
  }

  @override
  void dispose() {
    // 销毁，只调用一次
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // initState 之后调用
    // 当组件依赖发生变化时调用
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text(text ?? '这是有状态的 Demo'),
    );
  }
}
