import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.controller,
    this.isFieldObscure = false,
    this.hint,
    this.validator,
    this.onTab,
    this.keyboardType,
    this.textInputAction,
    this.expands = false,
    this.readOnly = false,
    this.autoValidateMode,
    this.labelText,
    this.errorText,
    this.focusNode,
    this.prefixIcon,this.onChanged,
    super.key,
  });
  final TextEditingController? controller;
  final bool isFieldObscure;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool expands;
  final bool readOnly;
  final AutovalidateMode? autoValidateMode;
  final String? labelText;
  final FocusNode? focusNode;
  final String? errorText;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTab;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _borderRadius = 8.0;
  final _borderWidth = 1.0;
  var _obscure = false;
  final _refreshCubit = RefreshCubit();

  @override
  void initState() {
    super.initState();
    _obscure = widget.isFieldObscure;
  }

  void _toggleObscure() {
    if (!widget.isFieldObscure) {
      return;
    }
    _obscure = !_obscure;
    _refreshCubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller?.text,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      builder: (state) {
        final isLabelProvided =
            widget.labelText != null && widget.labelText!.trim().isNotEmpty;
        final errorBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: _borderWidth,
            color: ColorManager.blackSwatch[5] ?? ColorManager.primaryBlack,
          ),
        );
        final enabledBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: _borderWidth,
            color: ColorManager.blackSwatch[5] ?? ColorManager.primaryBlack,
          ),
        );
        final focusedBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(
            width: _borderWidth,
            color: ColorManager.blackSwatch[5] ?? ColorManager.primaryBlack,
          ),
        );
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLabelProvided)
              Text(
                widget.labelText ?? '',
                style: FontUtils.nexaTextStyle.copyWith(
                  color: ColorManager.blackSwatch[10],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (isLabelProvided) SizedBox(height: 8.h),
            Flexible(
              child: BlocBuilder<RefreshCubit, RefreshState>(
                bloc: _refreshCubit,
                builder: (context, refreshState) {
                  return TextFormField(
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    obscureText: _obscure,
                    expands: widget.expands,
                    onTap: widget.onTab,
                    readOnly: widget.readOnly,
                    obscuringCharacter: '*',
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    textAlignVertical: widget.expands
                        ? TextAlignVertical.top
                        : TextAlignVertical.center,
                    style: FontUtils.nexaTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorManager.blackSwatch[10],
                      fontSize: 16,
                    ),

                    maxLines: widget.expands ? null : 1,
                    onChanged: (value) {
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                      state.didChange(value);
                    },
                    cursorColor: ColorManager.blackSwatch[10],
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: FontUtils.nexaTextStyle.copyWith(
                        fontSize: 16,
                        color: ColorManager.blackSwatch[8],
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: widget.prefixIcon,
                      prefixIconColor: ColorManager.blackSwatch[7],
                      prefixIconConstraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14
                      ),
                      errorStyle: FontUtils.nexaTextStyle.copyWith(
                        color: ColorManager.red,
                      ),
                      error: widget.errorText != null
                          ? Text(
                        widget.errorText ?? '',
                        style: FontUtils.nexaTextStyle.copyWith(
                          fontSize: 14,
                          color: ColorManager.red,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                          : state.hasError && state.errorText != null
                          ? Text(
                        state.errorText ?? '',
                        style: FontUtils.nexaTextStyle.copyWith(
                          fontSize: 14,
                          color: ColorManager.red,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                          : null,
                      contentPadding:
                      _obscure && (state.value?.isNotEmpty ?? false)
                          ? EdgeInsets.only(
                        top: 23.h,
                        bottom: 9.h,
                        left: 14.w,
                        right: 14.w,
                      )
                          : EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 14.w,
                      ),
                      enabledBorder:
                      state.hasError ? errorBorder : enabledBorder,
                      border: state.hasError ? errorBorder : enabledBorder,
                      focusedBorder:
                      state.hasError ? errorBorder : focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: errorBorder,
                      isCollapsed: true,
                      suffixIcon: widget.isFieldObscure
                          ? Padding(
                        padding: EdgeInsetsDirectional.only(end: 16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _toggleObscure,
                              child: GestureDetector(
                                onTap: _toggleObscure,
                                child: SvgPicture.asset(
                                  _obscure
                                      ? SvgManager.passwordEyeHidden
                                      : SvgManager.passwordEyeShown,
                                  height: 24.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
