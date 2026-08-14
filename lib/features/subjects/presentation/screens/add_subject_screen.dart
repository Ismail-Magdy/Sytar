import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_app_bar.dart';
import 'package:sytar/core/widgets/custom_feedback_dialog.dart';
import 'package:sytar/core/widgets/custom_text_field.dart';
import 'package:sytar/features/subjects/manager/add_subjects/add_subject_cubit.dart';
import 'package:sytar/features/subjects/manager/add_subjects/add_subject_state.dart';
import 'package:sytar/features/subjects/presentation/widgets/add_subject/add_subject_input_decoration.dart';
import 'package:sytar/features/subjects/presentation/widgets/add_subject/add_subject_section_title.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _subjectCodeController = TextEditingController();
  final TextEditingController _instructorNameController =
      TextEditingController();
  final TextEditingController _totalMarksController = TextEditingController();

  // Variables
  Color _selectedColor = AppColors.primaryColor;
  int _selectedCreditHours = 3;
  String? _selectedTargetGrade;
  // Colors
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

  final List<int> _creditHoursList = [1, 2, 3, 4];
  final List<String> _gradesList = ["A+", "A", "B+", "B", "C+", "C", "D+", "D"];

  @override
  void dispose() {
    _subjectNameController.dispose();
    _subjectCodeController.dispose();
    _instructorNameController.dispose();
    _totalMarksController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AddSubjectCubit>().addSubject(
        subjectName: _subjectNameController.text.trim(),
        colorCode: _selectedColor.value.toRadixString(16),
        creditHours: _selectedCreditHours,
        subjectCode: _subjectCodeController.text.trim(),
        instructorName: _instructorNameController.text.trim(),
        targetGrade: _selectedTargetGrade,
        totalMarks: int.parse(_totalMarksController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      backgroundColor: AppColors.white,
      //
      appBar: CustomAppBar(text: "إضافة مادة"),
      //
      body: BlocConsumer<AddSubjectCubit, AddSubjectState>(
        listener: (context, state) {
          if (state is AddSubjectSuccess) {
            // Success Dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomFeedbackDialog(
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.success,
                title: "عاش",
                message: "تم إضافة المادة بنجاح",
                onFinish: () => Navigator.pop(context, true),
              ),
            );
            //
          } else if (state is AddSubjectError) {
            // Error Dialog
            showDialog(
              context: context,
              builder: (context) => CustomFeedbackDialog(
                icon: Icons.error_outline_rounded,
                color: AppColors.error,
                title: "عذراً",
                message: state.error,
              ),
            );
            //
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: .symmetric(horizontal: 24.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  //
                  AddSubjectSectionTitle(title: "إسم المادة"),
                  //
                  verticalSpace(8),
                  //
                  CustomTextFormField(
                    controller: _subjectNameController,
                    hintText: "أدخل إسم المادة",
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? "يرجى إدخال اسم المادة"
                        : null,
                  ),
                  //
                  verticalSpace(24),
                  //
                  AddSubjectSectionTitle(title: "الساعات المعتمدة"),
                  //
                  verticalSpace(8),
                  //
                  DropdownButtonFormField<int>(
                    focusColor: AppColors.white,
                    borderRadius: .circular(5.r),
                    value: _selectedCreditHours,
                    items: _creditHoursList.map((hours) {
                      return DropdownMenuItem(
                        value: hours,
                        child: Text("$hours ${hours == 1 ? "ساعة" : "ساعات"}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCreditHours = value);
                      }
                    },
                    decoration: addSubjectsInputDecoration("إختر الساعات"),
                  ),
                  //
                  verticalSpace(24),
                  //
                  Row(
                    children: [
                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            //
                            AddSubjectSectionTitle(
                              title: "كود المادة (اختياري)",
                            ),
                            //
                            verticalSpace(8),
                            //
                            CustomTextFormField(
                              controller: _subjectCodeController,
                              hintText: "مثال: CS101",
                            ),
                            //
                          ],
                        ),
                      ),
                      //
                      horizontalSpace(16),
                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            //
                            AddSubjectSectionTitle(title: "الدرجة الكلية"),
                            //
                            verticalSpace(8),
                            //
                            CustomTextFormField(
                              controller: _totalMarksController,
                              hintText: "مثال: 100",
                              fieldType: .number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يرجى إدخال الدرجة النهائية";
                                }
                                if (int.tryParse(value.trim()) == null) {
                                  return "يرجى إدخال رقم صحيح";
                                }
                                return null;
                              },
                            ),
                            //
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                  //
                  verticalSpace(24),
                  //
                  AddSubjectSectionTitle(title: "إسم الدكتور (اختياري)"),
                  //
                  verticalSpace(8),
                  CustomTextFormField(
                    controller: _instructorNameController,
                    hintText: "ادخل إسم الدكتور",
                  ),
                  //
                  verticalSpace(24),
                  //
                  AddSubjectSectionTitle(title: "التقدير المستهدف (اختياري)"),
                  //
                  verticalSpace(8),
                  //
                  DropdownButtonFormField<String>(
                    focusColor: AppColors.white,
                    borderRadius: .circular(5.r),
                    value: _selectedTargetGrade,
                    hint: Text(
                      "نفسك تجيب كام؟",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                    items: _gradesList.map((grade) {
                      return DropdownMenuItem(value: grade, child: Text(grade));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedTargetGrade = value),
                    decoration: addSubjectsInputDecoration(""),
                  ),
                  //
                  verticalSpace(24),
                  //
                  AddSubjectSectionTitle(title: "لون المادة"),
                  //
                  verticalSpace(12),
                  //
                  _buildColorPicker(),
                  //
                  verticalSpace(50),
                  //
                  SizedBox(
                    width: .infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: state is AddSubjectLoading
                          ? null
                          : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12.r),
                        ),
                      ),
                      child: state is AddSubjectLoading
                          ? CupertinoActivityIndicator(color: AppColors.white)
                          : Text(
                              "حفظ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: .bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Color Picker
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
              shape: .circle,
              border: isSelected
                  ? .all(color: Colors.black87, width: 2.5)
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
