
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/color.dart';
import 'package:roof_top_demo/common_file/common_widget.dart';
import 'package:roof_top_demo/common_file/style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final String? titleText;
  final String? hintText;
  final String? suffixIcon;
  final Widget? suffixIconWidget;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onFieldBtnTap;
  final VoidCallback? onTap;
  final bool? obSecure;
  final int? maxLine;
  final bool? enable;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    Key? key,
    required this.controller,
    this.errorText,
    this.titleText,
    this.hintText,
    this.suffixIcon,
    this.suffixIconWidget,
    this.onSuffixTap,
    this.obSecure,
    this.textInputType,
    this.textInputAction,
    this.onSubmitted,
    this.inputFormatters,
    this.enable,
    this.onChanged,
    this.maxLine,
    this.onFieldBtnTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (titleText ?? '').isEmpty
            ? const SizedBox()
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Text(
              titleText ?? '',
              style: styleW400S14.copyWith(
                color: AppColor.white,
              ),
            ),

            /// Space
            const SizedBox(height: 8),
          ],
        ),

        /// Text Field
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onFieldBtnTap,
              child: AbsorbPointer(
                absorbing: onFieldBtnTap != null,
                child: TextField(
                  controller: controller,
                  onTap: onTap,
                  style: styleW400S16,
                  enabled: enable,
                  maxLines: obSecure == true ? 1 : maxLine,
                  obscureText: obSecure ?? false,
                  keyboardType: textInputType,
                  textInputAction: textInputAction ?? TextInputAction.next,
                  obscuringCharacter: "•",
                  // obscuringCharacter: "●",
                  onSubmitted: onSubmitted,
                  // cursorHeight: 14,
                  cursorColor: AppColor.primaryColor000,
                  onChanged: onChanged,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    /*          fillColor: enable == false
                        ? ColorRes.black.withOpacity(0.07)
                        : ColorRes.white,
                    filled: true,*/
                    hintText: hintText,
                    hintStyle: styleW400S16,
                    border: border(),
                    focusedBorder: border().copyWith(
                      borderSide: const BorderSide(
                        color: AppColor.primaryColor000,
                        width: 1,
                      ),
                    ),
                    disabledBorder: border(),
                    enabledBorder: border(),
                    errorBorder: border(),
                    focusedErrorBorder: border(),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: Get.width * 0.0444,
                    ),
                    suffixIcon: suffixIconWidget ??
                        (suffixIcon != null
                            ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onSuffixTap,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Image.asset(
                                suffixIcon!,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        )
                            : null),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 24,
                      maxWidth: 24 + 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        /// Space
        (errorText ?? "").isEmpty
            ? const SizedBox()
            : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ErrorText(text: errorText),
          ],
        ),
      ],
    );
  }

  InputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: errorText?.isNotEmpty == true ? AppColor.red : AppColor.white,
        width: 1,
      ),
    );
  }
}
