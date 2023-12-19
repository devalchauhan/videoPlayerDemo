import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_demo/app/modules/auth/views/widget/custom_button.dart';
import 'package:video_player_demo/app/modules/auth/views/widget/custom_textfield.dart';
import 'package:video_player_demo/app/routes/app_pages.dart';
import '../controllers/auth_controller.dart';
import 'package:aveoauth/aveoauth.dart';

class AuthView extends GetView<AuthController>
    with GoogleLogin, FirebaseEmailLogin {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - (kToolbarHeight),
          child: Center(
            child: Obx(
              () => Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 20.0, right: 20.0, bottom: 10.0),
                          child: Text(
                              controller.isForgetPasswordMode.value
                                  ? 'Reset Password'
                                  : controller.isSignUpMode.value
                                      ? 'Create Account'
                                      : 'Welcome',
                              style: const TextStyle(fontSize: 25.0)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 20.0, bottom: 20.0),
                            child: Text(
                              controller.isForgetPasswordMode.value
                                  ? 'Enter email address to reset password'
                                  : controller.isSignUpMode.value
                                      ? 'Enter your email address to signin'
                                      : 'Enter your email and password for signup',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        if (!controller.isForgetPasswordMode.value)
                          if (controller.isSignUpMode.value)
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  controller.isSignUpMode.value = false;
                                },
                                child: Text(
                                  'Already have account?',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary),
                                ),
                              ),
                            )
                      ],
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      fieldController: controller.emailController,
                      onFiledSubmitted: (m) {},
                      focusNode: controller.emailFocusNode,
                      labelText: 'Email',
                      hintText: 'Enter Email address',
                      validator: (value) => Validator.emailValidator(value),
                    ),
                    if (!controller.isForgetPasswordMode.value)
                      CustomTextField(
                        fieldController: controller.passwordController,
                        obscureText: true,
                        onFiledSubmitted: (m) {},
                        focusNode: controller.passwordFocusNode,
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        validator: (value) => controller.isSignUpMode.value
                            ? Validator.passwordValidator(
                                isNewPassword: true, value: value)
                            : Validator.passwordValidator(
                                isGeneralPassword: true, value: value),
                      ),
                    if (!controller.isForgetPasswordMode.value)
                      Visibility(
                        visible: controller.isSignUpMode.value,
                        child: CustomTextField(
                          fieldController: controller.confirmPasswordController,
                          obscureText: true,
                          onFiledSubmitted: (m) {},
                          focusNode: controller.confirmPasswordFocusNode,
                          labelText: 'Confirm Password',
                          hintText: 'Enter Confirm Password',
                          validator: (value) => Validator.passwordValidator(
                              isConfirmPassword: true,
                              value: value,
                              confirmPasswdText:
                                  controller.confirmPasswordController.text),
                        ),
                      ),
                    if (!controller.isForgetPasswordMode.value)
                      Visibility(
                        visible: !controller.isSignUpMode.value,
                        replacement: const SizedBox(height: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                controller.isForgetPasswordMode.value = true;
                              },
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary),
                              ),
                            )
                          ],
                        ),
                      ),
                    CustomButton(
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonHeight: 40,
                      buttonWidth: (MediaQuery.of(context).size.width) - 20.0,
                      logoUrl:
                          "https://img.icons8.com/ios/344/login-rounded-right--v1.png",
                      text: controller.isForgetPasswordMode.value
                          ? 'RESET'
                          : controller.isSignUpMode.value
                              ? 'SIGN UP'
                              : 'SIGN IN',
                      isImageVisible: false,
                      onPressed: () => controller.isForgetPasswordMode.value
                          ? {
                              if (controller.formKey.currentState!.validate())
                                {
                                  ///Your reset password code here
                                  controller.resetPassword()
                                }
                            }
                          : controller.isSignUpMode.value
                              ? {
                                  if (controller.formKey.currentState!.validate())
                                    {
                                      ///Your signup code here
                                      controller.signUp()
                                    }
                                }
                              : {
                                  if (controller.formKey.currentState!.validate())
                                    {
                                      ///Your signIn code here
                                     controller.signInWithEmailPassword()
                                    }
                                },
                    ),
                    if (controller.isForgetPasswordMode.value)
                      TextButton(
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () =>
                            controller.isForgetPasswordMode.value = false,
                      ),
                    if (!controller.isForgetPasswordMode.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      controller.isSignUpMode.value ? 15.0 : 0.0,
                                  vertical:
                                      controller.isSignUpMode.value ? 15.0 : 0.0),
                              child: Text(
                                controller.isSignUpMode.value
                                    ? "By Signing up you agree to our Terms & Conditions and Privacy Policy."
                                    : "Don't have account?",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          if (!controller.isSignUpMode.value)
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  controller.isSignUpMode.value = true;
                                },
                                child: Text(
                                  'Create new account.',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary),
                                ),
                              ),
                            )
                        ],
                      ),
                    if (!controller.isForgetPasswordMode.value) const Text('Or'),
                    if (!controller.isForgetPasswordMode.value)
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CustomButton(
                              isLabelVisible: false,
                              logoUrl:
                                  "https://img.icons8.com/color/96/000000/google-logo.png",
                              text: 'Google Login',
                              onPressed: () => controller.googleSignIn(),
                            ),
                          ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
