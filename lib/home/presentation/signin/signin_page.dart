import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/bloc/bloc/signin_bloc.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import 'package:mmlearning_admin/model/user_name.dart';

import '../../../app_image.dart';
import '../../../constant.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return BlocConsumer<SigninBloc, SigninState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          //success
          showSuccessSnack(context: context, data: "Signin Successful!");
        } else if (state.status == FormzSubmissionStatus.failure) {
          //failure
          showErrorSnack(context: context, data: "Signin Fail!");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Image.asset(
                  AppImage.logo,
                  width: size.width * 0.4,
                  height: size.height * 0.4,
                  fit: BoxFit.contain,
                ),
                10.v(),
                //Email
                SizedBox(
                  width: size.width * 0.4,
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => context
                        .read<SigninBloc>()
                        .add(UserNameChangeEvent(value: v)),
                    decoration: InputDecoration(
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border,
                      labelText: "Email",
                      floatingLabelStyle: textTheme.displayLarge,
                    ),
                  ),
                ).withPadding(h: 40, v: 0),
                20.v(),
                //Password
                SizedBox(
                  width: size.width * 0.4,
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => context
                        .read<SigninBloc>()
                        .add(PasswordChangeEvent(value: v)),
                    decoration: InputDecoration(
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border,
                      labelText: "Password",
                      floatingLabelStyle: textTheme.displayLarge,
                    ),
                  ),
                ).withPadding(h: 40, v: 0),
                20.v(),
                //SigninButton
                ElevatedButton(
                  onPressed: () =>
                      context.read<SigninBloc>().add(SubmittedEvent()),
                  child: state.status == FormzSubmissionStatus.inProgress
                      ? const LoadingWidget(
                          color: Colors.white,
                        )
                      : Text(
                          "Sign In",
                          style: textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ).withDefault(
                  radius: 10,
                  height: 35,
                  width: size.width * 0.4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
