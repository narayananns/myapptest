import 'package:flutter/material.dart';
import 'package:thristoparnterapp/providers/signup_controller.dart';
import 'package:thristoparnterapp/widgets/auth_widgets/file_upload.dart';
import 'package:thristoparnterapp/widgets/auth_widgets/text_field.dart';

import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => SignupController(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // 1. Fixed Background Gradient
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFD0EDFF), Color(0xFF8CCFF8)],
                ),
              ),
            ),

            // Decorative Circle 1
            Positioned(
              top: -86,
              left: -77,
              child: Container(
                width: 360,
                height: 360,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(109, 199, 255, 0.35),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Decorative Circle 2
            Positioned(
              top: -36,
              left: -44,
              child: Container(
                width: 249,
                height: 249,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(233, 247, 255, 0.35),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 2. Scrollable Content
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  SizedBox(height: height * 0.02),
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 230,
                          child: const Text(
                            "Sign Up To Your Account",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              height: 32 / 30,
                              color: Color.fromRGBO(24, 24, 24, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 190,
                          height: 15,
                          child: const Text(
                            "create a new account with thristo",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.0,
                              color: Color.fromRGBO(74, 74, 74, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // White Form Container
                  Container(
                    width: width,
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),

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
                                SizedBox(
                                  height: 58,
                                  child: DropdownButtonFormField(
                                    dropdownColor: Colors.white,
                                    value: ctrl.role,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(166, 166, 166, 1),
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.0,
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromRGBO(166, 166, 166, 1),
                                    ),
                                    items: ["Manager", "Owner", "Staff"]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) => ctrl.setRole(value!),
                                    decoration: inputDeco("Select Role"),
                                  ),
                                ),
                                const SizedBox(height: 15),

                                SizedBox(
                                  height: 58,
                                  child: DropdownButtonFormField(
                                    dropdownColor: Colors.white,
                                    value: ctrl.storeType,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(166, 166, 166, 1),
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.0,
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromRGBO(166, 166, 166, 1),
                                    ),
                                    items: ["Offline", "Online"]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) =>
                                        ctrl.setStoreType(value!),
                                    decoration: inputDeco("Store Type"),
                                  ),
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
                                  onTap: () => ctrl.pickStoreLogo(context),
                                ),
                                const SizedBox(height: 20),

                                FileUploadBox(
                                  title: "Upload Bank Cancelled Cheque",
                                  fileName: ctrl.cancelledChequePath,
                                  onTap: () =>
                                      ctrl.pickCancelledCheque(context),
                                ),
                                const SizedBox(height: 20),

                                FileUploadBox(
                                  title:
                                      "Upload Business Registration Certificate",
                                  fileName: ctrl.businessCertPath,
                                  onTap: () => ctrl.pickBusinessCert(context),
                                ),

                                const SizedBox(height: 30),

                                GestureDetector(
                                  onTap: () => ctrl.signUp(context),
                                  child: Container(
                                    width: double.infinity,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [
                                          Color(0xFF36B1FF),
                                          Color(0xFF95D5FF),
                                        ],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 15.9,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          height: 1.0,
                                          color: Colors.black,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDeco(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.0,
        color: Color.fromRGBO(166, 166, 166, 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromRGBO(180, 180, 180, 1),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromRGBO(180, 180, 180, 1),
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromRGBO(180, 180, 180, 1),
          width: 1.5,
        ),
      ),
    );
  }
}
