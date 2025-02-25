import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_utils.dart';

class AppTabBarView extends StatefulWidget {
  const AppTabBarView({
    super.key,
    required this.tabWidgets,
    required this.tabList,
    this.isScrollableTab = false,
    this.onTabChanged,
  });

  final List<Widget> tabWidgets;
  final List<String> tabList;
  final bool isScrollableTab;
  final ValueChanged<int>? onTabChanged;

  @override
  State<AppTabBarView> createState() => _AppTabBarViewState();
}

class _AppTabBarViewState extends State<AppTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabList.length, vsync: this);

    // Listen to tab index changes
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    // Trigger callback when the animation completes (swipe or tap)
    if (_tabController.index == _tabController.animation?.value.round()) {
      widget.onTabChanged?.call(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Column(
        children: [
          ColoredBox(
            color: AppColors.colorWhite,
            child: TabBar(
              controller: _tabController,
              tabs: tabs(),
              physics: const ClampingScrollPhysics(),
              labelStyle: AppTextStyle.textSize16Bold.copyWith(
                color: AppColors.primary,
              ),
              unselectedLabelStyle: AppTextStyle.textSize16Bold,
              indicatorColor: AppColors.primary,
              indicatorSize: widget.isScrollableTab
                  ? TabBarIndicatorSize.label
                  : TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: AppColors.primary,
              indicatorWeight: AppDimens.dimens3.h,
              dividerHeight: AppDimens.dimens1.h,
              isScrollable: widget.isScrollableTab,
              tabAlignment: widget.isScrollableTab ? TabAlignment.start : null,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabWidgets,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> tabs() {
    return List.generate(widget.tabList.length, (index) {
      return Tab(
        text: widget.tabList[index],
      );
    });
  }
}
