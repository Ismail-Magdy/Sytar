import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

import 'package:sytar/features/subjects/manager/add_subjects/add_subject_cubit.dart';
import 'package:sytar/features/subjects/manager/add_subjects/add_subject_state.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectNameController = TextEditingController();
  Color _selectedColor = AppColors.primaryColor;

  final List<Color> _availableColors = [
    AppColors.primaryColor,
    AppColors.success,
    AppColors.error,
    AppColors.warning,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
  ];

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AddSubjectCubit>().addSubject(
        subjectName: _subjectNameController.text.trim(),
        colorCode: _selectedColor.value.toRadixString(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة مادة',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      body: BlocConsumer<AddSubjectCubit, AddSubjectState>(
        listener: (context, state) {
          if (state is AddSubjectSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إضافة المادة بنجاح'),
                backgroundColor: AppColors.success,
              ),
            );

            // بنقفل الشاشة ونبعت true عشان الشاشة اللي قبلها (الهوم) تعمل ريفريش
            Navigator.pop(context, true);
          } else if (state is AddSubjectError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('اسم المادة'),
                  verticalSpace(8),
                  TextFormField(
                    controller: _subjectNameController,
                    decoration: _buildInputDecoration('ادخل اسم المادة'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يرجى إدخال اسم المادة';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(32),
                  _buildSectionTitle('لون المادة'),
                  verticalSpace(12),
                  _buildColorPicker(),
                  verticalSpace(50),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: state is AddSubjectLoading
                          ? null
                          : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: state is AddSubjectLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'حفظ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: _availableColors.map((color) {
        final isSelected = _selectedColor == color;
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: Colors.black87, width: 2.5)
                  : null,
            ),
            child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 20.sp)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
