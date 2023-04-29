import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:healthify/bloc/auth_bloc/signup_bloc/signup_bloc.dart';
import 'package:healthify/bloc/auth_bloc/signup_bloc/signup_bloc_event.dart';
import 'package:healthify/bloc/auth_bloc/signup_bloc/signup_bloc_state.dart';
import 'package:healthify/models/user_model.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:healthify/service/ApiService.dart';
import 'package:healthify/themes/app_decoration.dart';
import 'package:healthify/themes/app_styles.dart';

import '../../../core/app_exports.dart';
import '../../widgets/export_widgets.dart';

class SignUpScreen extends StatefulWidget {
  final apiService = ApiService();
  SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = true;
  bool isKeyboardActive = false;

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        isKeyboardActive = !isKeyboardActive;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        isKeyboardActive = !isKeyboardActive;
      });
    });

    _fullNameFocusNode.addListener(() {
      setState(() {
        isKeyboardActive = !isKeyboardActive;
      });
    });

    _signUpBloc = SignUpBloc(apiService: widget.apiService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignUpBloc, SignUpState>(
        bloc: _signUpBloc,
        builder: (context, state) {
          if (state is SignUpLoading) {
            return Container(
              color: ColorConstant.bluedark,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.whiteBackground,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: ColorConstant.fromHex("F8F8FA"),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: isKeyboardActive
                        ? MediaQuery.of(context).size.height / 3
                        : MediaQuery.of(context).size.height / 2,
                    decoration:
                        AppDecoration.fillIndigoWithBorderRadiusBottomLR22,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Image.asset(
                        ImageConstant.imgLogoDark,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    top: isKeyboardActive
                        ? 50
                        : MediaQuery.of(context).size.height / 3,
                    left: 20,
                    right: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 450,
                      decoration:
                          AppDecoration.fillWhiteWithBorderRadiusAndBoxShadow,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Sign Up",
                              style: AppStyle.txtPoppinsSemiBold24Dark,
                            ),
                          ),
                          _fullNameCustomTextField(),
                          _emailCustomTextField(),
                          _passwordCustomTextField(),
                          CustomTextButton(
                            onTap: () {
                              final userModel = UserModel(
                                fullName: _fullNameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              if (userModel.email.isNotEmpty &&
                                  userModel.fullName.isNotEmpty &&
                                  userModel.password.isNotEmpty) {
                                _signUpBloc.add(
                                    SignUpButtonPressed(userModel: userModel));

                                if (state is SignUpFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errorMessage),
                                      duration:
                                          const Duration(milliseconds: 800),
                                    ),
                                  );
                                } else {
                                  // after user get authenticated navigate to next screen
                                  Get.toNamed(AppRoutes.userDetailsScreen);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please enter all the fields"),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                              }
                            },
                            label: "Sign Up",
                            labelColor: Colors.white,
                            buttonBgColor: ColorConstant.bluedark,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 20,
                    left: 22,
                    right: 22,
                    child: FocusScope(
                      autofocus: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: AppStyle.txtPoppinsMedium17Bluegray9006c,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextWithGestureDetector(
                            text: "Sign In",
                            onTap: () {
                              Get.toNamed(AppRoutes.signInScreen);
                            },
                            textStyle: AppStyle.txtPoppinsSemiBold17Light,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fullNameCustomTextField() {
    return CustomTextFormField(
      controller: _fullNameController,
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      keyboardType: TextInputType.text,
      hintText: "Full Name",
      focusNode: _fullNameFocusNode,
      prefixIcon: const Icon(
        Icons.person,
      ),
    );
  }

  Widget _emailCustomTextField() {
    return CustomTextFormField(
      controller: _emailController,
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      keyboardType: TextInputType.emailAddress,
      hintText: "Email",
      focusNode: _emailFocusNode,
      prefixIcon: const Icon(
        Icons.email,
      ),
    );
  }

  Widget _passwordCustomTextField() {
    return CustomTextFormField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      hintText: "Password",
      prefixIcon: const Icon(
        Icons.lock,
      ),
      isObscureText: _passwordVisible,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
        icon: Icon(
          _passwordVisible ? Icons.visibility_off : Icons.visibility,
          size: 22,
          color: _passwordVisible
              ? ColorConstant.bluedark.withOpacity(0.3)
              : ColorConstant.bluedark,
        ),
      ),
    );
  }
}
