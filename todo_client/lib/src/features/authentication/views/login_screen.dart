import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/constants/assets/icons/icons.dart';
import 'package:todo_client/src/constants/design/border_radius.dart';
import 'package:todo_client/src/constants/design/paddings.dart';
import 'package:todo_client/src/features/authentication/controllers/auth_controller.dart';
import 'package:todo_client/src/features/authentication/views/registration_screen.dart';
import 'package:todo_client/src/global/widgets/custom_titled_textfield.dart';
import 'package:todo_client/src/system/themes/app_theme.dart';
import 'package:todo_client/src/utilities/dribble_snackbar/scaffold_utilities.dart';
import 'package:todo_client/src/utilities/extensions/size_utilities.dart';
import 'package:todo_client/src/utilities/forms/custom_form_validator.dart';
import 'package:todo_client/src/utilities/responsive/responsive_state_wrapper.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const route = "/login";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _showPassword = false;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(authControllerProvider);
    return Scaffold(
      body: ResponsiveParentWrapper(builder: (context, c) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: horizontal24,
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Hi, Welcome Back! 👋",
                          style: context.text.headlineMedium,
                        ),
                        Text(
                          "Hello again, you've been missed!",
                          style: context.text.labelMedium?.copyWith(
                            color: context.color.borderGreyColor,
                          ),
                        ),
                        50.height,
                        CustomTitledTextFormField(
                          title: "Email",
                          hintText: "Please Enter Your Email Address",
                          validators: [isRequired, isEmail],
                          onChange: (value) {
                            final controller = ref.read(
                              authControllerProvider.notifier,
                            );
                            controller.setLoginMail(value);
                          },
                        ),
                        12.height,
                        CustomTitledTextFormField(
                          title: "Password",
                          hintText: "Please Enter Your Password",
                          isObscured: _showPassword,
                          validators: [isRequired, tooShort6],
                          onChange: (value) {
                            final controller = ref.read(
                              authControllerProvider.notifier,
                            );
                            controller.setLoginPassword(value);
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(
                              (_showPassword)
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        12.height,
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: provider.loginState.remember,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                    onChanged: (value) {
                                      final controller = ref.read(
                                        authControllerProvider.notifier,
                                      );
                                      controller.switchRememberMe();
                                    },
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          final controller = ref.read(
                                            authControllerProvider.notifier,
                                          );
                                          controller.switchRememberMe();
                                        },
                                        child: const Padding(
                                          padding: all6,
                                          child: Text(
                                            "Remember me",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  borderRadius: br8,
                                  onTap: () {},
                                  child: Padding(
                                    padding: all6,
                                    child: Text(
                                      "Forget password",
                                      style: context.text.labelMedium?.copyWith(
                                        color: context.color.errorState,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        16.height,
                        Builder(builder: (context) {
                          return FilledButton(
                            onPressed: () async {
                              final formState = Form.of(context).validate();
                              if (formState) {
                                final controller = ref.read(
                                  authControllerProvider.notifier,
                                );
                                final res = await controller.attemptLogin();
                                if (res.$1) {
                                  showToastSuccess(res.$2);
                                } else {
                                  showToastError(res.$2);
                                }
                              }
                            },
                            child: const Text(
                              "Login",
                            ),
                          );
                        }),
                        18.height,
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(),
                            ),
                            Padding(
                              padding: horizontal18,
                              child: Text(
                                "Or With",
                                style: context.text.labelMedium?.copyWith(
                                  color: context.color.secondaryText,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),
                        18.height,
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: SizedBox.square(
                                  dimension: 24,
                                  child: Padding(
                                    padding: all3,
                                    child: Image.asset(AssetIcons.facebookIcon),
                                  ),
                                ),
                                label: const Text("Facebook"),
                              ),
                            ),
                            24.width,
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: SizedBox.square(
                                  dimension: 24,
                                  child: Padding(
                                    padding: all3,
                                    child: Image.asset(AssetIcons.googleIcon),
                                  ),
                                ),
                                label: const Text("Google"),
                              ),
                            ),
                          ],
                        ),
                        32.height,
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: context.text.titleMedium,
                              children: [
                                TextSpan(
                                  text: "Register.",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push(RegistrationScreen.route);
                                    },
                                  style: TextStyle(
                                    color: context.color.mainSecondBatch,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
        );
      }),
    );
  }
}
/* 
class AuthLockRiveWidget extends StatefulWidget {
  const AuthLockRiveWidget({
    super.key,
  });

  @override
  State<AuthLockRiveWidget> createState() => _AuthLockRiveWidgetState();
}

class _AuthLockRiveWidgetState extends State<AuthLockRiveWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthIntroPart(),
              TextFormField(),
              const SizedBox(height: 8),
              TextFormField(),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthIntroPart extends StatelessWidget {
  const AuthIntroPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthLottie(),
          Text(
            "Hey there!",
            style: context.text.headlineMedium?.copyWith(
              color: context.color?.primary,
            ),
          ),
          Text(
            "Hey there!",
            style: context.text.headlineMedium?.copyWith(
              color: context.color?.primary,
            ),
          ),
        ],
      ),
    );
  }
}
 */