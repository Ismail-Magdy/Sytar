import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/app_regex.dart";
import "package:sytar/core/themes/app_colors.dart";

/// Defines the type of the input field.
/// This controls validation, keyboard type, and password behavior.
enum FieldType {
  firstName,
  lastName,
  phoneNumber,
  userName,
  email,
  password,
  normal,
  number, // التعديل هنا: ضفنا نوع الأرقام
}

class CustomTextFormField extends StatefulWidget {
  /// Controller used to manage the input text.
  final TextEditingController controller;

  /// Hint text displayed inside the field.
  final String hintText;

  /// Defines the field behavior.
  final FieldType fieldType;

  /// Optional icon displayed at the start of the field.
  final IconData? prefixIcon;

  /// Optional custom validator if you want to override default validation.
  final String? Function(String?)? validator;

  /// Called whenever the text changes.
  final void Function(String)? onChanged;

  /// Keyboard type override (optional).
  final TextInputType? keyboardType;

  /// Maximum number of characters allowed.
  final int? maxLength;

  /// Input formatters (useful for phone numbers, digits, etc).
  final List<TextInputFormatter>? inputFormatters;

  /// Controls auto validation behavior.
  final AutovalidateMode autovalidateMode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.fieldType = .normal,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.autovalidateMode = .onUserInteraction,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  /// Controls password visibility for password fields.
  late bool obscureText;

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.fieldType != widget.fieldType) {
      setState(() {
        obscureText = widget.fieldType == .password;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    /// Initialize password visibility only if the field is a password.
    obscureText = widget.fieldType == .password;
  }

  /// Default validation logic based on field type.
  String? _defaultValidator(String? value) {
    final trimmedValue = value?.trim() ?? "";

    switch (widget.fieldType) {
      case .firstName:
        if (trimmedValue.isEmpty) {
          return "برجاء إدخال الاسم الأول";
        }
        break;

      case .lastName:
        if (trimmedValue.isEmpty) {
          return "برجاء إدخال اسم العائلة";
        }
        break;

      case .phoneNumber:
        if (trimmedValue.isEmpty ||
            !AppRegex.isPhoneNumberValid(trimmedValue)) {
          return "برجاء إدخال رقم هاتف صحيح";
        }
        break;

      case .userName:
        if (trimmedValue.isEmpty) {
          return "برجاء إدخال اسم المستخدم";
        }
        if (trimmedValue.contains(" ")) {
          return "اسم المستخدم يجب ألا يحتوي على مسافات";
        }
        break;

      case .email:
        if (trimmedValue.isEmpty || !AppRegex.isEmailValid(trimmedValue)) {
          return "برجاء إدخال بريد إلكتروني صحيح";
        }
        break;

      case .password:
        if (trimmedValue.isEmpty) {
          return "برجاء إدخال كلمة المرور";
        }
        if (!AppRegex.isPasswordValid(trimmedValue)) {
          return "يجب أن تحتوي على 8 أحرف، وحرف كبير وصغير ورقم ورمز";
        }
        break;

      case .number: // التعديل هنا: فالديشن افتراضي يمنع الحقل يتبعت فاضي
        if (trimmedValue.isEmpty) {
          return "برجاء إدخال قيمة";
        }
        break;

      case .normal:
        return null;
    }

    return null;
  }

  /// Returns keyboard type based on field type.
  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType!;
    }

    switch (widget.fieldType) {
      case .phoneNumber:
        return .phone;

      case .email:
        return .emailAddress;

      case .number: // التعديل هنا: فتح كيبورد الأرقام مع دعم العلامة العشرية
        return const TextInputType.numberWithOptions(decimal: true);

      default:
        return .text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      /// Use custom validator if provided, otherwise fallback to default validator.
      validator: widget.validator ?? _defaultValidator,

      /// Triggered whenever the user types.
      onChanged: widget.onChanged,

      /// Keyboard type configuration.
      keyboardType: _getKeyboardType(),

      /// Optional max length constraint.
      maxLength: widget.maxLength,

      /// Input formatters support.
      inputFormatters: widget.inputFormatters,

      /// Hide text only for password fields.
      obscureText: obscureText,

      /// Controls when validation runs.
      autovalidateMode: widget.autovalidateMode,

      /// Text style inside the field.
      style: TextStyle(color: AppColors.primaryColor, fontSize: 14.sp),

      textAlign: .right,
      textDirection: .rtl,

      /// --------------------------------------------------
      decoration: InputDecoration(
        hintText: widget.hintText,

        hintStyle: const TextStyle(color: Color(0x7F4A628A)),

        /// Optional prefix icon.
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.grey)
            : null,

        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.08),
        //
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        //
        errorBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        //
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),

        /// Password visibility toggle button.
        suffixIcon: widget.fieldType == .password
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}
