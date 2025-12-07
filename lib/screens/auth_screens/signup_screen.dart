import 'package:flutter/material.dart';
import 'package:thristoparnterapp/providers/signup_controller.dart';
import 'package:thristoparnterapp/widgets/auth_widgets/file_upload.dart';
import 'package:thristoparnterapp/widgets/auth_widgets/text_field.dart';

import '../../config/app_color.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupController(),
      child: Scaffold(
        backgroundColor: AppColors.loginlightBackground,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Get Started"),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                "Sign Up To Your Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Create a new account with Thristo",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              Consumer<SignupController>(
                builder: (context, ctrl, _) {
                  return Column(
                    children: [
                      CustomTextField(
                        hint: "Store Name",
                        controller: ctrl.storeNameCtrl,
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hint: "Password",
                        obscureText: true,
                        controller: ctrl.passwordCtrl,
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hint: "Confirm Password",
                        obscureText: true,
                        controller: ctrl.confirmPasswordCtrl,
                      ),
                      const SizedBox(height: 15),

                      /// Role Dropdown
                      DropdownButtonFormField(
                        value: ctrl.role,
                        items: ["Manager", "Owner", "Staff"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) => ctrl.setRole(value!),
                        decoration: inputDeco("Select Role"),
                      ),
                      const SizedBox(height: 15),

                      DropdownButtonFormField(
                        value: ctrl.storeType,
                        items: ["Offline", "Online"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) => ctrl.setStoreType(value!),
                        decoration: inputDeco("Store Type"),
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hint: "Store GST Number",
                        controller: ctrl.storeGstCtrl,
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hint: "Store Address",
                        controller: ctrl.storeAddressCtrl,
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        hint: "Store Description",
                        controller: ctrl.storeDescriptionCtrl,
                        maxLines: 5,
                      ),

                      const SizedBox(height: 20),

                      FileUploadBox(
                        title: "Upload Store Logo",
                        fileName: ctrl.storeLogoPath,
                        onTap: () => ctrl.uploadStoreLogo("/storage/logo.png"),
                      ),
                      const SizedBox(height: 20),

                      FileUploadBox(
                        title: "Upload Bank Cancelled Cheque",
                        fileName: ctrl.cancelledChequePath,
                        onTap: () =>
                            ctrl.uploadCancelledCheque("/storage/cheque.png"),
                      ),
                      const SizedBox(height: 20),

                      FileUploadBox(
                        title: "Upload Business Registration Certificate",
                        fileName: ctrl.businessCertPath,
                        onTap: () =>
                            ctrl.uploadBusinessCert("/storage/cert.pdf"),
                      ),

                      const SizedBox(height: 30),

                      GestureDetector(
                        onTap: () => ctrl.signUp(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryBlue,
                                AppColors.logingradientBlue,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
