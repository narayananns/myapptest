import 'package:flutter/material.dart';

class SignupController extends ChangeNotifier {
  // Text Controllers
  TextEditingController storeNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController storeGstCtrl = TextEditingController();
  TextEditingController storeDescriptionCtrl = TextEditingController();
  TextEditingController storeAddressCtrl = TextEditingController();

  // Dropdown Values
  String role = "Manager";
  String storeType = "Offline";

  // File Uploads
  String? storeLogoPath;
  String? cancelledChequePath;
  String? businessCertPath;

  void setRole(String value) {
    role = value;
    notifyListeners();
  }

  void setStoreType(String value) {
    storeType = value;
    notifyListeners();
  }

  void uploadStoreLogo(String path) {
    storeLogoPath = path;
    notifyListeners();
  }

  void uploadCancelledCheque(String path) {
    cancelledChequePath = path;
    notifyListeners();
  }

  void uploadBusinessCert(String path) {
    businessCertPath = path;
    notifyListeners();
  }

  void signUp(BuildContext context) {
    // Validate fields
    if (storeNameCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty ||
        confirmPasswordCtrl.text.isEmpty ||
        storeGstCtrl.text.isEmpty ||
        storeAddressCtrl.text.isEmpty ||
        storeDescriptionCtrl.text.isEmpty ||
        storeLogoPath == null ||
        cancelledChequePath == null ||
        businessCertPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields and upload documents"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print("--------------------------------------------------");
    print("Mock Signup Initiated");
    print("Store Name: ${storeNameCtrl.text}");
    print("Role: $role");
    print("Store Type: $storeType");
    print("GST: ${storeGstCtrl.text}");
    print("Address: ${storeAddressCtrl.text}");
    print("Description: ${storeDescriptionCtrl.text}");
    print("--------------------------------------------------");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Signup Data Sent to Backend"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
