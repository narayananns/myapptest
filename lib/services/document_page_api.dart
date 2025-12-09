import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/profile_page/document_model.dart';

class DocumentApiService {
  static const String baseUrl = "https://your-backend-url.com";

  // Fetch folders
  static Future<List<FolderModel>> getFolders() async {
    final response = await http.get(Uri.parse("$baseUrl/folders"));
    final List data = jsonDecode(response.body);
    return data.map((e) => FolderModel.fromJson(e)).toList();
  }

  // Create Folder
  static Future createFolder(String folderName) async {
    await http.post(
      Uri.parse("$baseUrl/create-folder"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": folderName}),
    );
  }

  // Upload File to Backend
  static Future uploadDocument(File file, String folderName) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/upload"),
    );

    request.fields["folder"] = folderName; // folder to store file
    request.files.add(
      await http.MultipartFile.fromPath("file", file.path),
    );

    var response = await request.send();
    return response.statusCode;
  }
}
