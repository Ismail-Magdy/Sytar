import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/features/home/data/models/home_dashboard_model.dart';
import 'package:sytar/features/home/manager/home_cubit.dart';
import 'package:sytar/features/home/presentation/widgets/build_chip.dart';
import 'package:sytar/features/home/presentation/widgets/show_selection_bottom_sheet.dart';

class BuildTermSwitchers extends StatelessWidget {
  final HomeDashboardModel data;

  const BuildTermSwitchers({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Level Chip
        GestureDetector(
          onTap: () {
            _showSelectionBottomSheet(
              context: context,
              title: "اختر المستوى",
              options: data.availableLevels,
              currentSelection: data.currentLevel,
              onSelect: (selectedLevel) {
                context.read<HomeCubit>().changeLevel(selectedLevel);
              },
            );
          },
          child: BuildChip(text: data.currentLevel),
        ),
        //
        horizontalSpace(10),
        //
        // Term Chip
        GestureDetector(
          onTap: () {
            _showSelectionBottomSheet(
              context: context,
              title: "اختر الترم",
              options: data.availableSemesters,
              currentSelection: data.currentSemester,
              onSelect: (selectedSemester) {
                context.read<HomeCubit>().changeSemester(selectedSemester);
              },
            );
          },
          child: BuildChip(text: data.currentSemester),
        ),
        //
      ],
    );
  }

  // Bottom Sheet
  void _showSelectionBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String currentSelection,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: .vertical(top: .circular(24.r)),
      ),
      builder: (context) {
        return ShowSelectionBottomSheet(
          currentSelection: currentSelection,
          onSelect: onSelect,
          options: options,
          title: title,
        );
      },
    );
  }
}
