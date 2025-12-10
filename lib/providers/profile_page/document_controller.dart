import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/profile_page/document_model.dart';
import '../../services/document_page_api.dart';

class DocumentController extends ChangeNotifier {
  List<FolderModel> folders = [];

  Future fetchFolders() async {
    // Fixed folders as per requirement
    if (folders.isEmpty) {
      folders = [
        FolderModel(
          name: "Cancelled Bank Check",
          size: "2.5 MB",
          date: "Dec 09, 2025",
          icon: "assets/images/document logo.png",
        ),
        FolderModel(
          name: "Gst Certificate",
          size: "850 KB",
          date: "Dec 09, 2025",
          icon: "assets/images/document logo.png",
        ),
        FolderModel(
          name: "Business Registeration Certificate",
          size: "1.2 MB",
          date: "Dec 09, 2025",
          icon: "assets/images/document logo.png",
        ),
        FolderModel(
          name: "Pan card",
          size: "500 KB",
          date: "Dec 09, 2025",
          icon: "assets/images/document logo.png",
        ),
        // To add an extra container, simply add another FolderModel here
        FolderModel(
          name: "FSSAI License",
          size: "1.0 MB",
          date: "Dec 09, 2025",
          icon: "assets/images/document logo.png",
        ),
      ];
    }
    notifyListeners();
  }

  Future<void> uploadDocument(File file, String docName) async {
    try {
      // 1. Upload to backend
      try {
        final statusCode = await DocumentApiService.uploadDocument(
          file,
          docName,
        );
        if (statusCode != 200 && statusCode != 201) {
          debugPrint(
            "Backend upload failed with status: $statusCode. Proceeding with local update for demo.",
          );
        }
      } catch (e) {
        debugPrint(
          "Backend connection failed: $e. Proceeding with local update for demo.",
        );
      }

      // Simulating network delay
      await Future.delayed(const Duration(seconds: 1));

      // 2. Update local state
      final int index = folders.indexWhere((f) => f.name == docName);
      if (index != -1) {
        final String fileSize = _formatFileSize(await file.length());
        final String currentDate = _formatDate(DateTime.now());

        folders[index] = folders[index].copyWith(
          size: fileSize,
          date: currentDate,
          filePath: file.path,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Upload failed: $e");
      // rethrow; // Don't rethrow for demo purposes
    }
  }

  String _formatFileSize(int size) {
    if (size < 1024) {
      return '$size B';
    } else if (size < 1024 * 1024) {
      return '${(size / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}";
  }

  // createFolder is removed as users cannot create new folders
  Future createFolder(String folderName) async {
    // No-op
  }
}
