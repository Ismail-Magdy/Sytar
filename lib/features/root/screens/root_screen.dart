import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/root/gpa_screen.dart';
import 'package:sytar/features/root/home_screen.dart';
import 'package:sytar/features/root/profile_screen.dart';
import 'package:sytar/features/root/subjects_screen.dart';
import 'package:sytar/features/root/tasks_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  late List<Widget> screens;
  int currentScreen = 2;
  late List<AnimationController> iconControllers;

  @override
  void initState() {
    super.initState();

    screens = [
      const SubjectsScreen(),
      const TasksScreen(),
      const HomeScreen(),
      const GpaScreen(),
      const ProfileScreen(),
    ];
    //
    iconControllers = List.generate(
      screens.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    //
    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    for (var c in iconControllers) {
      c.dispose();
    }
    super.dispose();
  }

  ///
  void _onTabTapped(int index) {
    if (index == currentScreen) return;

    if (index == 1) {
      screens[1] = TasksScreen(key: UniqueKey());
    }

    if (index == 4) {
      screens[4] = ProfileScreen(key: UniqueKey());
    }

    setState(() => currentScreen = index);

    iconControllers[index].forward();
    for (var i = 0; i < iconControllers.length; i++) {
      if (i != index) iconControllers[i].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        //
        extendBody: true,
        //
        body: IndexedStack(index: currentScreen, children: screens),
        //
        bottomNavigationBar: GlassBottomNavigationBar(
          currentIndex: currentScreen,
          onTap: _onTabTapped,

          items: [
            //
            BottomNavigationBarItemData(
              icon: const Icon(CupertinoIcons.book),
              filledIcon: Icon(CupertinoIcons.book_solid),
            ),
            //
            BottomNavigationBarItemData(
              icon: const Icon(CupertinoIcons.rectangle_grid_1x2),
              filledIcon: const Icon(CupertinoIcons.rectangle_grid_1x2_fill),
            ),
            //
            BottomNavigationBarItemData(
              icon: const Icon(CupertinoIcons.square_grid_2x2),
              filledIcon: const Icon(CupertinoIcons.square_grid_2x2_fill),
            ),
            //
            BottomNavigationBarItemData(
              icon: const Icon(CupertinoIcons.chart_bar),
              filledIcon: const Icon(CupertinoIcons.chart_bar_fill),
            ),
            //
            BottomNavigationBarItemData(
              icon: const Icon(CupertinoIcons.person_alt_circle),
              filledIcon: const Icon(CupertinoIcons.person_alt_circle),
            ),
            //
          ],
        ),
        //
      ),
    );
  }
}

/////////////////////////////////////////////////////////

class GlassBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItemData> items;

  const GlassBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<GlassBottomNavigationBar> createState() =>
      _GlassBottomNavigationBarState();
}

class BottomNavigationBarItemData {
  final Widget icon;
  final Widget filledIcon;
  BottomNavigationBarItemData({required this.icon, required this.filledIcon});
}

class _GlassBottomNavigationBarState extends State<GlassBottomNavigationBar> {
  double? _dragX;
  bool _isDragging = false;
  int? _hoverIndex;
  int? _localIndex;

  @override
  void didUpdateWidget(covariant GlassBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _localIndex = widget.currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == .rtl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(100),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final itemWidth = totalWidth / widget.items.length;

            final int activeIndex = _isDragging && _hoverIndex != null
                ? _hoverIndex!
                : (_localIndex ?? widget.currentIndex);

            final int activeVisualIndex = isRtl
                ? (widget.items.length - 1 - activeIndex)
                : activeIndex;

            double currentLeft;
            if (_isDragging && _dragX != null) {
              currentLeft = _dragX! - (itemWidth / 2);
              currentLeft = currentLeft.clamp(0.0, totalWidth - itemWidth);
            } else {
              currentLeft = itemWidth * activeVisualIndex;
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapUp: (details) {
                      // 3. التعديل التالت: بنحسب الضغطة صح بناءً على الاتجاه
                      int visualIndex = (details.localPosition.dx / itemWidth)
                          .floor()
                          .clamp(0, widget.items.length - 1);
                      int logicalIndex = isRtl
                          ? (widget.items.length - 1 - visualIndex)
                          : visualIndex;

                      setState(() {
                        _localIndex = logicalIndex;
                      });
                      widget.onTap(logicalIndex);
                    },
                    onHorizontalDragStart: (details) {
                      setState(() {
                        _isDragging = true;
                        _dragX = details.localPosition.dx;
                        int visualIndex = (_dragX! / itemWidth).floor().clamp(
                          0,
                          widget.items.length - 1,
                        );
                        _hoverIndex = isRtl
                            ? (widget.items.length - 1 - visualIndex)
                            : visualIndex;
                      });
                    },
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _dragX = details.localPosition.dx;
                        int visualIndex = (_dragX! / itemWidth).floor().clamp(
                          0,
                          widget.items.length - 1,
                        );
                        _hoverIndex = isRtl
                            ? (widget.items.length - 1 - visualIndex)
                            : visualIndex;
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      if (_hoverIndex != null &&
                          _hoverIndex != widget.currentIndex) {
                        widget.onTap(_hoverIndex!);
                      }
                      setState(() {
                        if (_hoverIndex != null) {
                          _localIndex = _hoverIndex;
                        }
                        _isDragging = false;
                        _hoverIndex = null;
                        _dragX = null;
                      });
                    },
                    onHorizontalDragCancel: () {
                      setState(() {
                        _isDragging = false;
                        _hoverIndex = null;
                        _dragX = null;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedPositioned(
                          duration: Duration(
                            milliseconds: _isDragging ? 0 : 350,
                          ),
                          curve: Curves.fastOutSlowIn,
                          left: currentLeft,
                          top: 0,
                          bottom: 0,
                          width: itemWidth,
                          child: Center(
                            child: AnimatedScale(
                              scale: _isDragging ? 1.12 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOutBack,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    width: 1.5,
                                  ),
                                  boxShadow: _isDragging
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.1,
                                            ),
                                            blurRadius: 15,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(widget.items.length, (index) {
                            final item = widget.items[index];
                            final isSelected = index == activeIndex;

                            return Expanded(
                              child: Container(
                                height: 72,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 280,
                                      ),
                                      child: IconTheme(
                                        data: IconThemeData(
                                          size: isSelected ? 21 : 20,
                                          color: isSelected
                                              ? AppColors.primaryColor
                                                    .withValues(alpha: 0.9)
                                              : Colors.white70,
                                        ),
                                        child: isSelected
                                            ? item.filledIcon
                                            : item.icon,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
//380