import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/buttons.dart';
import 'package:roof_top_demo/common_file/color.dart';
import 'package:roof_top_demo/common_file/common_textfield.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/screen/home/home_screen.dart';
import 'package:roof_top_demo/screen/register/register_controller.dart';
import 'package:roof_top_demo/utils/asset_res.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller =
      Get.put(RegisterController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<RegisterController>(
          id: 'loader',
          builder: (con) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 5.33.w),
              child: SizedBox(
                height: 100.h,
                child: StackedLoader(
                  loading: controller.loader,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25.w,
                      ),
                      const Center(
                        child: Text(
                          "Register to Rooftop",
                          style: TextStyle(
                            fontSize: 35,
                            color: AppColor.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.w),
                      AppTextField(
                        controller: controller.nameController,
                        errorText: controller.nameError,
                        hintText: 'Please Enter Your Name',
                      ),
                      SizedBox(height: 5.w),
                      AppTextField(
                        controller: controller.emailController,
                        errorText: controller.emailError,
                        hintText: 'Please Enter Your Email',
                      ),
                      SizedBox(height: 5.w),
                      AppTextField(
                        controller: controller.passwordController,
                        errorText: controller.passwordError,
                        hintText: 'Please Enter Your Password',
                        onSuffixTap: controller.onPwdVisibilityChange,
                        obSecure: controller.hidePassword,
                        suffixIcon: controller.hidePassword
                            ? AssetRes.passwordVisibleIcon
                            : AssetRes.passwordInvisibleIcon,
                      ),
                      SizedBox(height: 5.w),
                      AppTextField(
                        controller: controller.confirmPwdController,
                        errorText: controller.confirmPwdError,
                        hintText: 'Please Enter Your Confirm Password',
                        onSuffixTap: controller.onConfirmPwdVisibilityChange,
                        obSecure: controller.hideConfirmPwd,
                        suffixIcon: controller.hideConfirmPwd
                            ? AssetRes.passwordVisibleIcon
                            : AssetRes.passwordInvisibleIcon,
                      ),
                      SizedBox(height: 10.w),
                      SubmitButton(
                          title: "Register", onTap: controller.onRegisterTap),
                      const Spacer(),
                      InkWell(
                        onTap: controller.onLoginTap,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.w, right: 5.w),
                            child: Text(
                              "Login",
                              style: styleW400S25.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
