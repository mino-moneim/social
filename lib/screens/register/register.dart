import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/login/cubit/cubit.dart';
import '/screens/login/cubit/state.dart';
import '/shared/components/text_form_field.dart';
import '/theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  static final _nameController = TextEditingController();
  static final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.teal,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
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
                        controller: _nameController,
                        type: TextInputType.text,
                        hint: 'Name',
                        prefixIcon: Icons.person_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      myTextFromField(
                        controller: _phoneController,
                        type: TextInputType.phone,
                        hint: 'Phone',
                        prefixIcon: Icons.phone_outlined,
                        textInputAction: TextInputAction.next,
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
                        prefixIcon: Icons.lock_outlined,
                        scurePassword: LoginCubit.get(context).isPassword,
                        suffixIcon: LoginCubit.get(context).passwordIcon,
                        suffixPressed: () {
                          LoginCubit.get(context).changeIcon();
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'REGISTER',
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
