import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PDFViewerScreen extends StatefulWidget {
  final String? filePath;
  final Uint8List? fileBytes;
  final String fileName;

  const PDFViewerScreen({
    super.key,
    this.filePath,
    this.fileBytes,
    required this.fileName,
  });

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? _localPath;
  bool _isLoading = true;
  String? _errorMessage;
  Uint8List? _bytesToRender;

  @override
  void initState() {
    super.initState();
    _prepareDocument();
  }

  Future<void> _prepareDocument() async {
    try {
      // Case 1: We already have bytes (e.g. from FilePicker withData: true)
      if (widget.fileBytes != null) {
        debugPrint(
          "Loading from provided bytes. Size: ${widget.fileBytes!.length}",
        );
        if (mounted) {
          setState(() {
            _bytesToRender = widget.fileBytes;
            _isLoading = false;
          });
        }
        // Also try to save to a temp file for "Open Externally" to work
        _saveBytesToTempFile(widget.fileBytes!);
        return;
      }

      // Case 2: We have a file path
      if (widget.filePath != null) {
        final sourceFile = File(widget.filePath!);
        if (!await sourceFile.exists()) {
          throw Exception("Source file not found: ${widget.filePath}");
        }

        // Read bytes directly from file
        final bytes = await sourceFile.readAsBytes();
        debugPrint("Read bytes from file. Size: ${bytes.length}");

        if (mounted) {
          setState(() {
            _bytesToRender = bytes;
            _localPath =
                widget.filePath; // Keep original path for external open
            _isLoading = false;
          });
        }
        return;
      }

      throw Exception("No file data provided");
    } catch (e) {
      debugPrint("Error preparing PDF: $e");
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveBytesToTempFile(Uint8List bytes) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final safeName = widget.fileName.replaceAll(RegExp(r'[^\w\.-]'), '_');
      final safePath = path.join(dir.path, safeName);
      final file = File(safePath);
      await file.writeAsBytes(bytes);
      if (mounted) {
        setState(() {
          _localPath = safePath;
        });
      }
    } catch (e) {
      debugPrint("Failed to save temp file: $e");
    }
  }

  Future<void> _openExternally() async {
    final targetPath = _localPath ?? widget.filePath;
    if (targetPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File not saved locally yet.")),
      );
      return;
    }

    try {
      final result = await OpenFile.open(targetPath);
      if (result.type != ResultType.done) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Could not open: ${result.message}")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  Future<void> _shareFile() async {
    final targetPath = _localPath ?? widget.filePath;
    if (targetPath == null) return;

    try {
      await Share.shareXFiles([XFile(targetPath)], text: widget.fileName);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error sharing: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
        backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareFile,
            tooltip: 'Share',
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: _openExternally,
            tooltip: 'Open in External App',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error loading document:\n$_errorMessage',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _openExternally,
                        icon: const Icon(Icons.open_in_new),
                        label: const Text("Open Externally"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: _shareFile,
                        icon: const Icon(Icons.share),
                        label: const Text("Share File"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SfPdfViewer.memory(
              _bytesToRender!,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                debugPrint('Document loaded successfully');
              },
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                debugPrint('Document failed to load: ${details.error}');
                setState(() {
                  _errorMessage = details.description;
                });
              },
            ),
    );
  }
}
