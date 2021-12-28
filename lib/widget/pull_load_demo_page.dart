import 'package:flutter/material.dart';
import 'package:gsy_flutter_demo/widget/custom_pull/data_result.dart';
import 'package:gsy_flutter_demo/widget/custom_pull/list_state.dart';
import 'package:gsy_flutter_demo/widget/custom_pull/pull_load_widget.dart';


class PullLoadDemoPage extends StatefulWidget {
  @override
  _PullLoadDemoPageState createState() => _PullLoadDemoPageState();
}

class _PullLoadDemoPageState extends State<PullLoadDemoPage>
    with
        AutomaticKeepAliveClientMixin<PullLoadDemoPage>,
        ListState<PullLoadDemoPage> {

  bool disposed = false;

  _renderItem(index) {
    if (pullLoadWidgetControl.dataList.length == 0) {
      return null;
    }
    var data = pullLoadWidgetControl.dataList[index];

    return Card(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        child: Text("Item $data $index"),
      ),
    );
  }

  _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    List<String> list = [];
    for (int i = 0; i < 30; i++) {
      list.add("refresh");
    }
    return DataResult(list, true);
  }

  _loadMoreData() async {
    await Future.delayed(Duration(seconds: 2));
    List<String> list = [];
    for (int i = 0; i < 30; i++) {
      list.add("loadmore");
    }
    return DataResult(list, true);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => false;

  @override
  requestRefresh() async {
    return await _refreshData();
  }

  @override
  requestLoadMore() async {
    return await _loadMoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Pull Load Demo Page",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )),
      body: PullLoadWidget(
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderItem(index),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}
