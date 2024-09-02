import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipe_project/core/style/colors.dart';
import 'package:recipe_project/core/style/note_form_field.dart';
import 'package:recipe_project/core/style/recipe_button.dart';
import 'package:recipe_project/core/validator.dart';
import 'package:recipe_project/domain_layer/change_notifiers/registration_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clearTextFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: recipeColor.background,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/page/my-cookbook-cover.png', // Ensure this path is correct
              fit: BoxFit.cover,
            ),
          ),
          // Fade effect
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.8), // Adjust opacity as needed
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Consumer<RegistrationController>(
                    builder: (context, registrationController, _) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Bahtera Resipi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 48,
                                fontFamily: 'darlingCoffee',
                                fontWeight: FontWeight.w600,
                                color: recipeColor.primary,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                                'Daftar untuk pilihan resipi yang memikat hati'),
                            SizedBox(height: 48),
                            if (registrationController.isRegisterMode) ...[
                              NoteFormField(
                                controller: usernameController,
                                hintText: "Username",
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.next,
                                validator: Validator.nameValidator,
                                onChanged: (newValue) {
                                  registrationController.username = newValue;
                                },
                              ),
                              SizedBox(height: 8)
                            ],
                            NoteFormField(
                              controller: emailController,
                              hintText: "Email Address",
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validator.emailValidator,
                              onChanged: (newValue) {
                                registrationController.email = newValue;
                              },
                            ),
                            SizedBox(height: 8),
                            NoteFormField(
                              controller: passwordController,
                              hintText: "Password",
                              obscureText:
                                  registrationController.isPasswordHidden,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  registrationController.isPasswordHidden =
                                      !registrationController.isPasswordHidden;
                                },
                                child: Icon(
                                  registrationController.isPasswordHidden
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                ),
                              ),
                              validator: Validator.passwordValidator,
                              onChanged: (newValue) {
                                registrationController.password = newValue;
                              },
                            ),
                            SizedBox(height: 12),
                            if (!registrationController.isRegisterMode) ...[
                              Row(
                                children: [
                                  Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: recipeColor.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                            ],
                            Container(
                              width: double.infinity,
                              child: RecipeButtonElevated(
                                child: registrationController.isLoading
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        registrationController.isRegisterMode
                                            ? "Create My Account"
                                            : "Log me in",
                                      ),
                                onPressed: registrationController.isLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          registrationController
                                              .authenticateWithEmailAndPassword(
                                            context: context,
                                          );
                                        }
                                      },
                              ),
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    registrationController.isRegisterMode
                                        ? 'Or register with'
                                        : 'Or sign in with',
                                  ),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: RecipeButtonIcon(
                                    icon: FontAwesomeIcons.google,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: RecipeButtonIcon(
                                    icon: FontAwesomeIcons.facebook,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Text.rich(
                              TextSpan(
                                text: registrationController.isRegisterMode
                                    ? 'Already have an account? '
                                    : "Don't have an account? ",
                                children: [
                                  TextSpan(
                                    text: registrationController.isRegisterMode
                                        ? 'Sign in'
                                        : 'Register',
                                    style:
                                        TextStyle(color: recipeColor.primary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        clearTextFields();
                                        registrationController.isRegisterMode =
                                            !registrationController
                                                .isRegisterMode;
                                      },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
