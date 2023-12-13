import 'package:flutter/material.dart';
import 'package:race_flutter/pages/generate/generate_page.dart';
import 'package:race_flutter/pages/like/like_page.dart';

const int tabCount = 2;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  var selectedIndex = 0;

  @override
  String get restorationId => 'home_page';

  late TabController _tabController;
  RestorableInt tabIndex = RestorableInt(0);

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabCount, vsync: this)
      ..addListener(() {
        // Set state to make sure that the [_RallyTab] widgets get updated when changing tabs.
        setState(() {
          tabIndex.value = _tabController.index;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  List<Widget> _buildTabs(
      {required BuildContext context,
      required ThemeData theme,
      bool isVertical = false}) {
    return [
      _RallyTab(
        theme: theme,
        iconData: Icons.pie_chart,
        title: '概览',
        tabIndex: 0,
        tabController: _tabController,
        isVertical: isVertical,
      ),
      _RallyTab(
        theme: theme,
        iconData: Icons.attach_money,
        title: '统计',
        tabIndex: 1,
        tabController: _tabController,
        isVertical: isVertical,
      ),
    ];
  }

  List<Widget> _buildTabViews() {
    return [
      GeneratePage(),
      LikePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget tabBarView;
    final isTextDirectionRtl = false;
    final isDesktop = true;

    final verticalRotation =
        isTextDirectionRtl ? turnsToRotateLeft : turnsToRotateRight;
    final revertVerticalRotation =
        isTextDirectionRtl ? turnsToRotateRight : turnsToRotateLeft;

    tabBarView = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 150,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              // Rotate the tab bar, so the animation is vertical for desktops.
              RotatedBox(
                quarterTurns: verticalRotation,
                child: _RallyTabBar(
                  tabs: _buildTabs(
                          context: context, theme: theme, isVertical: true)
                      .map(
                    (widget) {
                      // Revert the rotation on the tabs.
                      return RotatedBox(
                        quarterTurns: revertVerticalRotation,
                        child: widget,
                      );
                    },
                  ).toList(),
                  tabController: _tabController,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          // Rotate the tab views so we can swipe up and down.
          child: RotatedBox(
            quarterTurns: verticalRotation,
            child: TabBarView(
              controller: _tabController,
              children: _buildTabViews().map(
                (widget) {
                  // Revert the rotation on the tab views.
                  return RotatedBox(
                    quarterTurns: revertVerticalRotation,
                    child: widget,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: SafeArea(
          // For desktop layout we do not want to have SafeArea at the top and
          // bottom to display 100% height content on the accounts view.
          top: !isDesktop,
          bottom: !isDesktop,
          child: Theme(
            // This theme effectively removes the default visual touch
            // feedback for tapping a tab, which is replaced with a custom
            // animation.
            data: theme.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: tabBarView,
            ),
          ),
        ),
      );
    });
  }
}

class _RallyTabBar extends StatelessWidget {
  const _RallyTabBar({
    required this.tabs,
    this.tabController,
  });

  final List<Widget> tabs;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalOrder(
      order: const NumericFocusOrder(0),
      child: TabBar(
        // Setting isScrollable to true prevents the tabs from being
        // wrapped in [Expanded] widgets, which allows for more
        // flexible sizes and size animations among tabs.
        isScrollable: true,
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
        controller: tabController,
        // This hides the tab indicator.
        indicatorColor: Colors.transparent,
      ),
    );
  }
}

class _RallyTab extends StatefulWidget {
  _RallyTab({
    required ThemeData theme,
    IconData? iconData,
    required String title,
    int? tabIndex,
    required TabController tabController,
    required this.isVertical,
  })  : titleText = Text(title, style: theme.textTheme.labelLarge),
        isExpanded = tabController.index == tabIndex,
        icon = Icon(iconData, semanticLabel: title);

  final Text titleText;
  final Icon icon;
  final bool isExpanded;
  final bool isVertical;

  @override
  _RallyTabState createState() => _RallyTabState();
}

class _RallyTabState extends State<_RallyTab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _titleSizeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _iconFadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(_RallyTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVertical) {
      return Column(
        children: [
          const SizedBox(height: 18),
          FadeTransition(
            opacity: _iconFadeAnimation,
            child: widget.icon,
          ),
          const SizedBox(height: 12),
          FadeTransition(
            opacity: _titleFadeAnimation,
            child: SizeTransition(
              axis: Axis.vertical,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
              child: Center(child: ExcludeSemantics(child: widget.titleText)),
            ),
          ),
          const SizedBox(height: 18),
        ],
      );
    }

    // Calculate the width of each unexpanded tab by counting the number of
    // units and dividing it into the screen width. Each unexpanded tab is 1
    // unit, and there is always 1 expanded tab which is 1 unit + any extra
    // space determined by the multiplier.
    final width = MediaQuery.of(context).size.width;
    const expandedTitleWidthMultiplier = 2;
    final unitWidth = width / (tabCount + expandedTitleWidthMultiplier);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Row(
        children: [
          FadeTransition(
            opacity: _iconFadeAnimation,
            child: SizedBox(
              width: unitWidth,
              child: widget.icon,
            ),
          ),
          FadeTransition(
            opacity: _titleFadeAnimation,
            child: SizeTransition(
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
              child: SizedBox(
                width: unitWidth * expandedTitleWidthMultiplier,
                child: Center(
                  child: ExcludeSemantics(child: widget.titleText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
