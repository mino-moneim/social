import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/shared/components/toast.dart';
import 'package:social/shared/services/local/cache_helper.dart';
import '/screens/login/cubit/cubit.dart';
import '/screens/login/cubit/state.dart';
import '/screens/screens.dart';
import '/theme.dart';
import '/shared/components/text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginError) {
            showToast(
              text: 'error',
              state: ToastStates.error,
            );
          } else {
            if (state is LoginSuccess) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.userModel.uId,
              ).then((value) {
                CacheHelper.getData(key: 'uId');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SocialScreen(),
                  ),
                );
              });
            }
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.teal,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: SocialTheme.darkText.headline2,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'lorem text',
                        style: SocialTheme.darkText.bodyText1!.copyWith(
                          color: Colors.tealAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      myTextFromField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        hint: 'Email',
                        prefixIcon: Icons.alternate_email,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      myTextFromField(
                        controller: _passwordController,
                        type: TextInputType.visiblePassword,
                        hint: 'Password',
                        scurePassword: LoginCubit.get(context).isPassword,
                        prefixIcon: Icons.lock_outlined,
                        suffixIcon: LoginCubit.get(context).passwordIcon,
                        suffixPressed: () {
                          LoginCubit.get(context).changeIcon();
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            const Text(
                              'Don\'t have an account',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.tealAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            LoginCubit.get(context).userLogin(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
