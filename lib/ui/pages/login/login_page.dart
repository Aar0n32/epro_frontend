import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/text_input_field.dart';
import '../../../configs/app_styles.dart';
import '../../../constants/asset_image_paths.dart';
import '../../../constants/enums/e_loading_state.dart';
import '../../../util/extensions/context_lang_extension.dart';
import '../../../view_models/login/i_login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    final AppStyles appStyles = context.watch();
    final ILoginViewModel loginViewModel = context.watch();
    var maxWidth = MediaQuery.of(context).size.width * (1 / 3);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 300, maxWidth: maxWidth > 300 ? maxWidth : 300),
          child: Card(
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(AssetImagePaths.okrLogo),
                    const SizedBox(height: 8.0),
                    TextInputField(
                      label: lang.email,
                      value: loginViewModel.email,
                      validator: loginViewModel.emailValidator,
                      onChanged: (value) => loginViewModel.email = value,
                      keyboardType: TextInputType.emailAddress,
                      readOnly:
                          loginViewModel.loadingState == ELoadingState.loading,
                    ),
                    const SizedBox(height: 8.0),
                    TextInputField(
                      label: lang.passwort,
                      value: loginViewModel.password,
                      validator: loginViewModel.passwordValidator,
                      onChanged: (value) => loginViewModel.password = value,
                      readOnly:
                          loginViewModel.loadingState == ELoadingState.loading,
                      obscureText: _obscureText,
                      suffixIcon: IconButton(
                        onPressed:
                            loginViewModel.loadingState == ELoadingState.loading
                                ? null
                                : () => setState(() {
                                      _obscureText = !_obscureText;
                                    }),
                        icon: _obscureText
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: max(300.0, maxWidth) / 4),
                      height: 60,
                      child: ElevatedButton(
                        onPressed:
                            loginViewModel.loadingState == ELoadingState.loading
                                ? null
                                : () async {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      await loginViewModel.login();
                                    }
                                  },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ))),
                        child: loginViewModel.loadingState ==
                                ELoadingState.loading
                            ? const Center(child: CircularProgressIndicator())
                            : Text(
                                lang.anmelden,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        color: appStyles.colors.textOnColor),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Checkbox(
                          value: loginViewModel.remember,
                          onChanged: loginViewModel.loadingState ==
                                  ELoadingState.loading
                              ? null
                              : (value) => setState(() {
                                    loginViewModel.remember = value == true;
                                  }),
                        ),
                        Text(lang.angemeldetBleiben),
                      ],
                    )
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
