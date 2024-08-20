import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/config/di.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/strings_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:fire_guard_app/core/widgets/app_logo_and_name_widget.dart';
import 'package:fire_guard_app/main.dart';
import 'package:fire_guard_app/src/features/auth/data/model/sign_in_model.dart';
import 'package:fire_guard_app/src/features/auth/data/repository/sign_in_repository.dart';
import 'package:fire_guard_app/src/features/auth/data/service/sign_in_service.dart';
import 'package:fire_guard_app/src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/sign_in_header.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        signInRepo: SignInRepoImpl(
          internetConnectionInfo: InternetConnectionInfo(
              internetConnectionChecker: InternetConnectionChecker()),
          signInService: SignInService(
            dio: Dio(),
          ),
          sharedPreferences: sharedPreferences,
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                const Center(
                  child: AppLogoAndNameWidget(),
                ),
                const Gap(69.28),
                const WelcomeHeader(
                  fontSize: 26,
                  imageSize: 26,
                ),
                const Gap(53),
                Text(
                  StringsManager.signInText,
                  style: StylesManager.interFontFamilyBold(
                    fontSize: 20,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                const Gap(19),
                Text(
                  StringsManager.usernameText,
                  style: StylesManager.interFontFamilyRegular(
                    fontSize: 14,
                    color: ColorsManager.darkBlueColor,
                  ),
                ),
                const Gap(8),
                AppTextField(
                  hinText: StringsManager.enterYourUsernameText,
                  controller: username,
                ),
                const Gap(24),
                Text(
                  StringsManager.passwordText,
                  style: StylesManager.interFontFamilyRegular(
                    fontSize: 14,
                    color: ColorsManager.darkBlueColor,
                  ),
                ),
                const Gap(8),
                AppTextField(
                  hinText: StringsManager.enterYourPasswordText,
                  hasPrefix: true,
                  controller: password,
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        StringsManager.forgotPasswordText,
                        style: StylesManager.interFontFamilyMedium(
                          fontSize: 13,
                          color: ColorsManager.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(53),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SignInSuccessState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppBottomNavigationBar(),
                        ),
                      );
                    } else if (state is SignInFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: ColorsManager.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
                              ),
                            ),
                          ),
                          content: Text(
                            state.errorMessage,
                            style: StylesManager.interFontFamilyMedium(
                              fontSize: 16,
                              color: ColorsManager.whiteColor,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SignInLoadingState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorsManager.primaryColor,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return AppButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                signInModel: SignInModel(
                                  username: username.text,
                                  password: password.text,
                                ),
                              ),
                            );
                      },
                      buttonText: StringsManager.signInText,
                    );
                  },
                ),
                const Gap(30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
