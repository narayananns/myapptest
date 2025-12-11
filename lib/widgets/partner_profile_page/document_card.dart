import 'package:flutter/material.dart';
import 'package:thristoparnterapp/models/profile_page/document_model.dart';

class FolderCard extends StatelessWidget {
  final FolderModel folder;

  const FolderCard({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:const Color.fromRGBO(31, 31, 31, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 1)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.asset(folder.icon, fit: BoxFit.contain),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              folder.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
