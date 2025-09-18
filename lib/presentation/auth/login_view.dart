import 'package:flutter/material.dart';
import 'package:news/presentation/auth/widgets/header.dart';
import 'package:news/presentation/auth/widgets/login_button.dart';
import 'package:news/presentation/auth/widgets/auth_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true; // retained if needed later
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final edgePadding = width * 0.05;
    final verticalGapLarge = height * 0.05;
    final verticalGapSmall = height * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: edgePadding,
                    vertical: verticalGapSmall,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          const WelcomeText(),
                          SizedBox(
                            height: isWide
                                ? verticalGapLarge
                                : verticalGapSmall * 3.5,
                          ),

                          // Username
                          AuthTextField(
                            labelText: "Username",
                            fieldNameForValidation: "Username",
                            isPassword: false,
                            isWide: isWide,
                          ),
                          SizedBox(
                            height: isWide
                                ? verticalGapSmall * 1.2
                                : verticalGapSmall,
                          ),

                          // Password
                          AuthTextField(
                            label: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Password"),
                                Text("*", style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            fieldNameForValidation: "Password",
                            isPassword: true,
                            isWide: isWide,
                          ),
                          SizedBox(height: 35),
                          LoginButton(
                            isLoading: _isLoading,
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              setState(() => _isLoading = true);
                              await Future.delayed(const Duration(seconds: 1));
                              if (!mounted) return;
                              setState(() => _isLoading = false);
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/home');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
