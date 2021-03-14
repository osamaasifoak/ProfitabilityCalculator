import 'package:flutter/material.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

class TabBarViewComponent extends StatefulWidget {
  final List<Widget> childrenTabs;
  final List<String> tabsName;
  const TabBarViewComponent({Key key, this.childrenTabs, this.tabsName})
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
          unselectedLabelColor: ColorConstant.greyishBrownTwo,
          tabs: widget.tabsName
              .map(
                (e) => AnimatedContainer(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 500),
                  width: 168,
                  height: 38,
                  decoration: new BoxDecoration(
                    color: widget.tabsName[index] == e
                        ? ColorConstant.black
                        : ColorConstant.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextComponent(
                        text: e,
                        textStyle: FontStyles.inter(
                            color: widget.tabsName[index] == e
                                ? ColorConstant.white
                                : ColorConstant.greyishBrownTwo,
                            fontWeight: FontWeight.w600),
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
