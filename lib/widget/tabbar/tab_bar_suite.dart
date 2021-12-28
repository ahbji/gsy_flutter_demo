import 'package:flutter/material.dart';

enum TabType { bottom, top }

class TabBarSuite extends StatefulWidget {
  final TabType type;

  final List<Widget>? tabItems;

  final List<Widget>? tabViews;

  final Color indicatorColor;

  final Color backgroundColor;

  final Widget? title;

  final PageController? pageController;

  final ValueChanged<int>? onPageChanged;

  final int initTabIndex;

  final bool isScrollable;

  const TabBarSuite({
    Key? key,
    this.type = TabType.top,
    this.tabItems,
    this.tabViews,
    this.indicatorColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.title,
    this.pageController,
    this.initTabIndex = 0,
    this.onPageChanged,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  _TabBarSuiteState createState() => _TabBarSuiteState();
}

class _TabBarSuiteState extends State<TabBarSuite>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();

    ///初始化时创建控制器
    ///通过 with SingleTickerProviderStateMixin 实现动画效果。
    _tabController = new TabController(
      vsync: this,
      length: widget.tabItems!.length,
      initialIndex: widget.initTabIndex,
    );
    _pageController = widget.pageController;
    _pageController ??= PageController();
  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 顶部 tab bar
    if (widget.type == TabType.top) {
      return Scaffold(
        appBar: AppBar(
          title: widget.title,
          bottom: TabBar(
            /// 顶部时，tabBar为可以滑动的模式
            isScrollable: widget.isScrollable,

            ///必须有的控制器，与 pageView 的控制器同步
            controller: _tabController,

            /// 每一个 tab item，是一个 List<Widget>
            tabs: widget.tabItems!,

            /// tab 底部选中条颜色
            indicatorColor: widget.indicatorColor,
          ),
        ),
        body: _buildPageBody(),
      );
    }

    /// 底部 tab bar
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        title: widget.title,
      ),
      body: _buildPageBody(),
      bottomNavigationBar: _getBottomNavByType(),
    );
  }

  Widget _buildPageBody() {
    if (widget.tabItems! is List<Tab>) {
      return TabBarView(
        /// 必须有的控制器，与 tabBar 的控制器同步
        controller: _tabController,
        children: widget.tabViews!,
      );
    }
    return PageView(
      ///必须有的控制器，与tabBar的控制器同步
      controller: _pageController,

      ///每一个 tab 对应的页面主体，是一个List<Widget>
      children: widget.tabViews!,

      ///页面触摸作用滑动回调，用于同步tab选中状态
      onPageChanged: (index) {
        if (!_tabController!.indexIsChanging) {
          _tabController!.animateTo(index);
        }
        widget.onPageChanged?.call(index);
      },
    );
  }

  Widget _getBottomNavByType() {
    return Material(
      color: widget.backgroundColor,
      child: TabBar(
        /// 必须有的控制器，与pageView的控制器同步
        controller: _tabController,

        /// 每一个 tab item，是一个 List<Widget>
        tabs: widget.tabItems!,

        /// tab 底部选中条颜色
        indicatorColor: widget.indicatorColor,
      ),
    );
  }
}
