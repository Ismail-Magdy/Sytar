import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/tasks/manager/add_task_cubit.dart';
import 'package:sytar/features/tasks/manager/add_task_state.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  SubjectModel? _selectedSubject;
  DateTime? _selectedDate;
  String _selectedPriority = 'medium';

  final List<String> _priorities = ['low', 'medium', 'high'];

  @override
  void initState() {
    super.initState();
    context.read<AddTaskCubit>().getSubjects();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى اختيار تاريخ التسليم'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      context.read<AddTaskCubit>().addTask(
        title: _titleController.text.trim(),
        subjectName: _selectedSubject!.subjectName,
        deadline: _selectedDate!,
        priority: _selectedPriority,
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'low':
        return 'منخفضة';
      case 'medium':
        return 'متوسطة';
      case 'high':
        return 'عالية';
      default:
        return priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة مهمة',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      body: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is AddTaskSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إضافة المهمة بنجاح'),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.pop(context);
          } else if (state is AddTaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddTaskCubit>();

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('عنوان المهمة'),
                  verticalSpace(8),
                  TextFormField(
                    controller: _titleController,
                    decoration: _buildInputDecoration(
                      'ادخل عنوان المهمة (مثل: شيت الماث)',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يرجى إدخال عنوان المهمة';
                      }
                      return null;
                    },
                  ),

                  verticalSpace(24),
                  _buildSectionTitle('المادة'),
                  verticalSpace(8),

                  if (state is AddTaskSubjectsLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  else if (cubit.subjects.isEmpty)
                    Text(
                      'لا توجد مواد مضافة، يرجى إضافة مادة أولاً',
                      style: TextStyle(color: AppColors.error, fontSize: 14.sp),
                    )
                  else
                    DropdownButtonFormField<SubjectModel>(
                      initialValue: _selectedSubject,
                      items: cubit.subjects.map((subject) {
                        return DropdownMenuItem(
                          value: subject,
                          child: Text(subject.subjectName),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => _selectedSubject = value),
                      decoration: _buildInputDecoration('اختر المادة'),
                      validator: (value) =>
                          value == null ? 'يرجى اختيار المادة' : null,
                    ),

                  verticalSpace(24),
                  _buildSectionTitle('تاريخ التسليم (Deadline)'),
                  verticalSpace(8),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'اختر تاريخ التسليم'
                                : DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(_selectedDate!),
                            style: TextStyle(
                              color: _selectedDate == null
                                  ? AppColors.grey
                                  : AppColors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.primaryColor,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  verticalSpace(24),
                  _buildSectionTitle('الأولوية'),
                  verticalSpace(8),
                  Wrap(
                    spacing: 12.w,
                    children: _priorities.map((priority) {
                      final isSelected = _selectedPriority == priority;
                      return ChoiceChip(
                        label: Text(
                          _getPriorityLabel(priority),
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: AppColors.lightGrey,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedPriority = priority);
                          }
                        },
                      );
                    }).toList(),
                  ),

                  verticalSpace(40),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed:
                          (state is AddTaskLoading || cubit.subjects.isEmpty)
                          ? null
                          : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: state is AddTaskLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                          : Text(
                              'إضافة مهمة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
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
      hintStyle: TextStyle(color: AppColors.grey, fontSize: 14.sp),
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }
}
