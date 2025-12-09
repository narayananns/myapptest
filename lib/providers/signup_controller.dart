import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

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

  final ImagePicker _picker = ImagePicker();

  void setRole(String value) {
    role = value;
    notifyListeners();
  }

  void setStoreType(String value) {
    storeType = value;
    notifyListeners();
  }

  Future<void> pickStoreLogo(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        int size = await image.length();
        if (size > 50 * 1024 * 1024) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("File size exceeds 50MB limit"),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
        storeLogoPath = image.path;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking store logo: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> pickCancelledCheque(BuildContext context) async {
    debugPrint("pickCancelledCheque called");
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size > 50 * 1024 * 1024) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("File size exceeds 50MB limit"),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
        if (file.path != null) {
          cancelledChequePath = file.path;
          notifyListeners();
        }
      } else {
        debugPrint("User canceled the picker");
      }
    } catch (e) {
      debugPrint("Error picking cancelled cheque: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> pickBusinessCert(BuildContext context) async {
    debugPrint("pickBusinessCert called");
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size > 50 * 1024 * 1024) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("File size exceeds 50MB limit"),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
        if (file.path != null) {
          businessCertPath = file.path;
          notifyListeners();
        }
      } else {
        debugPrint("User canceled the picker");
      }
    } catch (e) {
      debugPrint("Error picking business certificate: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  // Deprecated methods to maintain compatibility during refactor if needed,
  // but we will update the UI to use the new methods.
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
