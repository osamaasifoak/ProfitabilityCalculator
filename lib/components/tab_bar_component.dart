import 'package:flutter/material.dart';

import '../constants/colors/colors_constants.dart';
import '../constants/styles/font_styles_constants.dart';
import 'text_component.dart';

class TabBarViewComponent extends StatefulWidget {
  final List<Widget> childrenTabs;
  final List<String> tabsName;
  final double horizontalPadding;
  const TabBarViewComponent(
      {Key key, this.childrenTabs, this.tabsName, this.horizontalPadding = 5})
      : super(key: key);
  @override
  _TabBarViewComponentState createState() => _TabBarViewComponentState();
}

class _TabBarViewComponentState extends State<TabBarViewComponent>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int index = 0;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        initialIndex: 0, length: widget.childrenTabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorWeight: 0.01,
          labelColor: ColorConstant.white,
          labelPadding: EdgeInsetsGeometry.lerp(
              EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
              EdgeInsets.symmetric(horizontal: 10),
              0),
          unselectedLabelColor: ColorConstant.greyishBrownTwo,
          tabs: widget.tabsName
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: AnimatedContainer(
                    curve: Curves.easeOutSine,
                    duration: Duration(milliseconds: 500),
                    width: widget.tabsName[index] == e ? 180 : 120,
                    height: 35,
                    transform: Matrix4.identity(),
                    decoration: new BoxDecoration(
                      boxShadow: widget.tabsName[index] == e
                          ? [
                              BoxShadow(
                                  color: ColorConstant.greyishBrownThree
                                      .withOpacity(0.2),
                                  offset: Offset(1, 0.8),
                                  spreadRadius: 1,
                                  blurRadius: 0.8)
                            ]
                          : [],
                      color: widget.tabsName[index] == e
                          ? ColorConstant.black
                          : ColorConstant.brownGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                          widget.tabsName[index] == e ? 4.0 : 4.0),
                      child: Center(
                        child: TextComponent(
                          text: e,
                          textStyle: FontStyles.inter(
                              fontSize: widget.tabsName[index] == e ? 12 : 12,
                              color: widget.tabsName[index] == e
                                  ? ColorConstant.white
                                  : ColorConstant.greyishBrownTwo,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          isScrollable: true,
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
              controller: _tabController, children: widget.childrenTabs),
        )
      ],
    );
  }
}
