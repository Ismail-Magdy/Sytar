import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/features/home/presentation/screens/home_screen.dart';
import 'package:sytar/features/root/gpa_screen.dart';
import 'package:sytar/features/root/profile_screen.dart';
import 'package:sytar/features/root/widgets/glass_bottom_navigation_bar.dart';
import 'package:sytar/features/subjects/presentation/screens/subjects_screen.dart';
import 'package:sytar/features/tasks/manager/add_task_cubit.dart';
import 'package:sytar/features/tasks/presentation/screens/add_task_screen.dart';

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
      SubjectsScreen(),
      BlocProvider(
        create: (_) => getIt<AddTaskCubit>(),
        child: const AddTaskScreen(),
      ),
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
      screens[1] = BlocProvider(
        create: (_) => getIt<AddTaskCubit>(),
        child: AddTaskScreen(key: UniqueKey()),
      );
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



//380