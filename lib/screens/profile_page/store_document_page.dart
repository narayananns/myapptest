import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_page/document_controller.dart';
import 'package:thristoparnterapp/widgets/partner_profile_page/document_card.dart';
import 'document_detail_screen.dart';

class DocumentStoreScreen extends StatefulWidget {
  const DocumentStoreScreen({super.key});

  @override
  State<DocumentStoreScreen> createState() => _DocumentStoreScreenState();
}

class _DocumentStoreScreenState extends State<DocumentStoreScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DocumentController>(context, listen: false).fetchFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Store Documents",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<DocumentController>(
        builder: (context, controller, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: controller.folders.length,
                    itemBuilder: (context, index) {
                      final folder = controller.folders[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DocumentDetailScreen(title: folder.name),
                            ),
                          );
                        },
                        child: FolderCard(folder: folder),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
