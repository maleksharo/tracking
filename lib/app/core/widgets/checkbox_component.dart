import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxComponent extends StatefulWidget {
  final String? text;
  final Widget? widget;
  final Function(bool) onChecked;
  final bool initialValue;

  CheckBoxComponent({
    super.key,
    this.text,
    this.widget,
    this.initialValue = false,
    required this.onChecked,
  }) {
    assert(
      (text != null) ^ (widget != null),
      'You should either provide the text or the widget, and not both of them',
    );
  }

  @override
  State<CheckBoxComponent> createState() => _CheckBoxComponentState();
}

class _CheckBoxComponentState extends State<CheckBoxComponent> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  final _refreshCubit = getIt<RefreshCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<RefreshCubit, RefreshState>(
          bloc: _refreshCubit,
          builder: (context, state) {
            return Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                isChecked = value ?? false;
                widget.onChecked(value ?? false);
                _refreshCubit.refresh();
              },
            );
          },
        ),
        Expanded(
            child: widget.text != null
                ? Text(
                    widget.text ?? "",
                    style: FontUtils.nexaTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  )
                : widget.widget ?? const SizedBox.shrink())
      ],
    );
  }
}
