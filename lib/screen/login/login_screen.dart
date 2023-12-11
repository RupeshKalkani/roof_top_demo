import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roof_top_demo/common_file/buttons.dart';
import 'package:roof_top_demo/common_file/color.dart';
import 'package:roof_top_demo/common_file/common_textfield.dart';
import 'package:roof_top_demo/common_file/loaders.dart';
import 'package:roof_top_demo/common_file/sizer.dart';
import 'package:roof_top_demo/common_file/style.dart';
import 'package:roof_top_demo/screen/home/home_screen.dart';
import 'package:roof_top_demo/screen/login/login_controller.dart';
import 'package:roof_top_demo/screen/register/register_screen.dart';
import 'package:roof_top_demo/utils/asset_res.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller =
      Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<LoginController>(
          id: 'loader',
          builder: (con) {
            return StackedLoader(
              loading: controller.loader,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.33.w),
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25.w,
                      ),
                      const Center(
                        child: Text(
                          "Welcome to Rooftop",
                          style: TextStyle(
                            fontSize: 35,
                            color: AppColor.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
                      SizedBox(height: 10.w),
                      SubmitButton(
                          title: "Login", onTap: controller.onLoginTap),
                      const Spacer(),
                      InkWell(
                        onTap: controller.onRegisterTap,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.w, right: 5.w),
                            child: Text(
                              "Sign Up",
                              style: styleW400S25.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
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
