import 'package:flutter/material.dart';
import 'package:my_coffee/core/consts/size.dart';
import 'package:my_coffee/core/styles/colors.dart';
import 'package:my_coffee/modules/home/pages/widgets/card_product_widget.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({
    super.key,
  });

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerHeight: 0,
                  indicatorColor: Colors.transparent,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  labelPadding: EdgeInsets.zero,
                  onTap: (value) {},
                  tabs: const [
                    TabWidget(titleTab: "Hot Coffees"),
                    TabWidget(titleTab: "Ice Teas"),
                    TabWidget(titleTab: "Hot Teas"),
                    TabWidget(titleTab: "Drinks"),
                    TabWidget(titleTab: "Bakery"),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.count(
                  padding: EdgeInsets.only(top: height * .01),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: (height * .21) / (width * .5),
                  children: [
                    ...List.generate(
                      4,
                      (index) => const CardProductWidget(),
                    ),
                  ],
                ),
                const Center(child: Text("1")),
                const Center(child: Text("1")),
                const Center(child: Text("1")),
                const Center(child: Text("1")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.titleTab,
  });

  final String titleTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width * .05),
      child: Tab(
        iconMargin: EdgeInsets.zero,
        child: Text(
          maxLines: 1,
          titleTab,
          style: TextStyle(
            fontSize: width * .04,
            fontFamily: "Inter",
          ),
        ),
      ),
    );
  }
}
