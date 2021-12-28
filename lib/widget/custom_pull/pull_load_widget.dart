import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PullLoadWidget extends StatefulWidget {
  /// 控制器，比如数据和一些配置
  final PullLoadWidgetControl? control;

  /// item 渲染
  final IndexedWidgetBuilder itemBuilder;

  /// 下拉刷新回调
  final RefreshCallback? onRefresh;

  /// 加载更多回调
  final RefreshCallback? onLoadMore;

  final Key? refreshKey;

  const PullLoadWidget(
    this.control,
    this.itemBuilder,
    this.onRefresh,
    this.onLoadMore, {
    this.refreshKey,
    Key? key,
  }) : super(key: key);

  @override
  _PullLoadWidgetState createState() => _PullLoadWidgetState();
}

class _PullLoadWidgetState extends State<PullLoadWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.control?.needLoadMore.addListener(
      () {
        ///延迟两秒等待确认
        try {
          Future.delayed(Duration(seconds: 2), () {
            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
            _scrollController.notifyListeners();
          });
        } catch (e) {
          print(e);
        }
      },
    );

    ///增加滑动监听
    _scrollController.addListener(
      () {
        ///判断当前滑动位置是不是到达底部，触发加载更多回调
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (widget.control?.needLoadMore.value == true) {
            widget.onLoadMore?.call();
          }
        }
      },
    );
    super.initState();
  }

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount() {
    ///是否需要头部
    if (widget.control!.needHeader) {
      ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
      ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (widget.control!.dataList.length > 0)
          ? widget.control!.dataList.length + 2
          : widget.control!.dataList.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (widget.control!.dataList.length == 0) {
        return 1;
      }

      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return (widget.control!.dataList.length > 0)
          ? widget.control!.dataList.length + 1
          : widget.control!.dataList.length;
    }
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!widget.control!.needHeader &&
        index == widget.control!.dataList.length &&
        widget.control!.dataList.length != 0) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.control!.needHeader &&
        index == _getListCount() - 1 &&
        widget.control!.dataList.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!widget.control!.needHeader &&
        widget.control!.dataList.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return widget.itemBuilder(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: widget.refreshKey,

      ///下拉刷新触发，返回的是一个Future
      onRefresh: widget.onRefresh ?? () async {},
      child: ListView.builder(
        ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
        physics: const AlwaysScrollableScrollPhysics(),

        ///根据状态返回子孔健
        itemBuilder: (context, index) {
          return _getItem(index);
        },

        ///根据状态返回数量
        itemCount: _getListCount(),

        ///滑动监听
        controller: _scrollController,
      ),
    );
  }

  ///空页面
  Widget _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Container(
              child: Text(
                '暂无数据',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///上拉加载更多
  Widget _buildProgressIndicator() {
    ///是否需要显示上拉加载更多的loading
    Widget bottomWidget = (widget.control!.needLoadMore.value)
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ///loading框
            SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
            Container(
              width: 5.0,
            ),
          ])

        /// 不需要加载
        : Container();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: bottomWidget,
      ),
    );
  }
}

class PullLoadWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = [];

  ///是否需要加载更多
  ValueNotifier<bool> needLoadMore = ValueNotifier(false);

  ///是否需要头部
  bool needHeader = false;
}
