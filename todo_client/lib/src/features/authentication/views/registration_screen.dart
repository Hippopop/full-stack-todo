import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_client/src/constants/assets/icons/icons.dart';
import 'package:todo_client/src/constants/assets/images/images.dart';
import 'package:todo_client/src/constants/design/paddings.dart';
import 'package:todo_client/src/global/widgets/custom_titled_textfield.dart';
import 'package:todo_client/src/global/widgets/image_button_avatar.dart';
import 'package:todo_client/src/system/themes/app_theme.dart';
import 'package:todo_client/src/utilities/dialogues/loading_overlay.dart';
import 'package:todo_client/src/utilities/extensions/size_utilities.dart';
import 'package:todo_client/src/utilities/forms/custom_form_validator.dart';
import 'package:todo_client/src/utilities/responsive/responsive_state_wrapper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const route = "/registration";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? profileImagePath;
  bool _showPassword = false;
  String selectedCountryCode = "+880";

  late final nameController = TextEditingController();
  late final emailController = TextEditingController();
  late final phoneController = TextEditingController();
  late final passwordController = TextEditingController();
  late final confirmPasswordController = TextEditingController();

  late final formKey = GlobalKey<FormState>();
  late final OverlayLoader overlayLoader;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    overlayLoader = OverlayLoader.instance;
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
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        32.height,
                        Text(
                          "Create an account!",
                          style: context.text.headlineMedium,
                        ),
                        Text(
                          "Start a organized life today.",
                          style: context.text.labelMedium?.copyWith(
                            color: context.color.borderGreyColor,
                          ),
                        ),
                        25.height,
                        Center(
                          child: ImageAvatarWithButton(
                            filePath: profileImagePath,
                            assetPath: AssetImages.boyProfile,
                            onAddClick: () async {
                              final picker = ImagePicker();
                              final res = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (res != null) {
                                setState(() {
                                  profileImagePath = res.path;
                                });
                              }
                            },
                          ),
                        ),
                        25.height,
                        CustomTitledTextFormField(
                          title: "Full Name",
                          hintText: "Please Enter Your Full Name",
                          controller: nameController,
                          validators: [isRequired],
                        ),
                        12.height,
                        CustomTitledTextFormField(
                          title: "Email",
                          hintText: "Please Enter Your Email Address",
                          controller: emailController,
                          validators: [isRequired, isEmail],
                        ),
                        12.height,
                        CustomTitledTextFormField(
                          title: "Phone",
                          hintText: "Enter Your Phone Number",
                          validators: [
                            isRequired,
                            tooShort11,
                          ],
                          controller: phoneController,
                          prefixIcon: IntrinsicWidth(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        showCountryPicker(
                                          context: context,
                                          useSafeArea: true,
                                          showPhoneCode: true,
                                          onSelect: (value) {
                                            setState(() {
                                              selectedCountryCode =
                                                  "+${value.phoneCode}";
                                            });
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          12.width,
                                          Text(selectedCountryCode),
                                          3.width,
                                        ],
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    indent: 6,
                                    endIndent: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        12.height,
                        CustomTitledTextFormField(
                          title: "Password",
                          hintText: "Please Enter Your Password",
                          isObscured: _showPassword,
                          controller: passwordController,
                          validators: [isRequired, tooShort6],
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
                        CustomTitledTextFormField(
                          title: "Confirm Password",
                          hintText: "Please Re-Enter Your Password",
                          controller: confirmPasswordController,
                          isObscured: _showPassword,
                          validators: [isRequired, tooShort6],
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
                        16.height,
                        Builder(builder: (context) {
                          return FilledButton(
                            onPressed: () {},
                            child: const Text(
                              "Sign Up",
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
                              text: "Already have an account? ",
                              style: context.text.titleMedium,
                              children: [
                                TextSpan(
                                  text: "Login.",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                  style: TextStyle(
                                    color: context.color.mainSecondBatch,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        32.height,
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
