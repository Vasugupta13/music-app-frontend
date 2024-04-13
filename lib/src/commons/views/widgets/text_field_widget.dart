
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/theme_controller.dart';
import 'package:music_player/src/res/color.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? currNode;
  final bool? readOnly;
  final int? maxLength;
  final bool? isSubmitted;
  final bool isProtected;
  final String? hintText;
  final void Function(String)? onSubmit;
  final String? text;
  final TextInputType? textInputType;
  final Color? color;
  final Widget? prefix;
  final void Function(String)? onChanged;
  const TextFieldWidget(
      {super.key,
        required this.controller,
        this.currNode,
        this.isSubmitted,
        this.onSubmit,
        this.text,
        required this.isProtected,
        this.color = AppColors.kLightGrey,
        this.textInputType,
        this.readOnly,
        this.maxLength, this.prefix,
        this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Center(
      child: SizedBox(
        height: hintText != null ? null: height * 0.067,
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            bool isDark =  ref.watch(themeControllerProvider.notifier).isDark;
            return Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: TextFormField(
                    onChanged: onChanged,
                    maxLength: maxLength,
                    readOnly: readOnly ?? false,
                    keyboardType: textInputType,
                    obscureText: isProtected,
                    controller: controller,
                    focusNode: currNode,
                    cursorColor: !isDark ? Colors.black : AppColors.kPrimaryBackground,
                    onFieldSubmitted: onSubmit,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: prefix,
                      prefixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 50),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical:hintText != null ? 0 : 12),
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        fontSize: 14, height: 3
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                           BorderSide(color: !isDark ? Colors.black : AppColors.kPrimaryBackground , width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                           BorderSide(
                              color: !isDark ? Colors.black : AppColors.kPrimaryBackground,
                              width: 1.5)),
                    ),
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.only(left: 20,),
                  child: Row(
                    children: [
                      text == null ? const SizedBox.shrink(): Container(
                        color:isDark ? Colors.black : AppColors.kPrimaryBackground ,
                        child: Text(
                          ' $text ',
                          style: const TextStyle(

                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
