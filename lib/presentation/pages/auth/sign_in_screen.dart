import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:healthify/bloc/auth_bloc/signin_bloc/signin_bloc.dart';
import 'package:healthify/bloc/auth_bloc/signin_bloc/signin_bloc_event.dart';
import 'package:healthify/bloc/auth_bloc/signin_bloc/signin_bloc_state.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/core/constants/api_constants.dart';
import 'package:healthify/models/user_model.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:healthify/service/ApiService.dart';
import 'package:healthify/themes/app_decoration.dart';

import '../../../../themes/app_styles.dart';
import '../../widgets/export_widgets.dart';

class SignInScreen extends StatefulWidget {
  final apiService = ApiService();
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _passwordVisible = true;

  late SignInBloc _signInBloc;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isKeyboardActive = false;
  bool isLoading = false;

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

    _signInBloc = SignInBloc(apiService: widget.apiService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignInBloc, SignInBlocState>(
        bloc: _signInBloc,
        builder: (context, state) {
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
                        ? MediaQuery.of(context).size.height / 2.5
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
                        ? 70
                        : MediaQuery.of(context).size.height / 3,
                    left: 20,
                    right: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      decoration:
                          AppDecoration.fillWhiteWithBorderRadiusAndBoxShadow,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Sign In",
                              style: AppStyle.txtPoppinsSemiBold24Dark,
                            ),
                          ),
                          _emailCustomTextField(),
                          _passwordCustomTextField(),
                          CustomTextButton(
                            isLoading: isLoading,
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });

                              final userModel = UserModel(
                                fullName: '',
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              if (userModel.email.isNotEmpty &&
                                  userModel.password.isNotEmpty) {
                                _signInBloc.add(
                                    SignInButtonPressed(userModel: userModel));

                                if (state is SignInFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(state.errorMessage),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 800),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.home);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(
                                      child:
                                          Text("Please enter all the fields"),
                                    ),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                              }
                              stopLoadingAnimation();
                            },
                            label: "Sign In",
                            labelColor: Colors.white,
                            buttonBgColor: ColorConstant.bluedark,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 15,
                            ),
                          ),
                          TextWithGestureDetector(
                            text: "Forget Password?",
                            onTap: () {},
                            textStyle: AppStyle.txtPoppinsSemiBold17Light,
                          )
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
                            "Don’t have an account?",
                            style: AppStyle.txtPoppinsMedium17Bluegray9006c,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextWithGestureDetector(
                            text: "Register",
                            onTap: () {
                              Get.toNamed(AppRoutes.signUpScreen);
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

  void stopLoadingAnimation() {
    Future.delayed(
      const Duration(milliseconds: 2000),
    ).then(
      (value) => setState(
        () {
          isLoading = false;
        },
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
