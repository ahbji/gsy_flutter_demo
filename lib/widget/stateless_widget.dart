import 'package:flutter/material.dart';

class StlWidget extends StatelessWidget {
  final String? text;

  const StlWidget({Key? key, this.text,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text(text ?? "这就是无状态DMEO"),
    );
  }
}
