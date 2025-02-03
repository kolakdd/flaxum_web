import 'package:flutter/material.dart';

class FileDetails extends StatelessWidget {
  final String fileName;

  const FileDetails({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fileName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Дополнительная информация о файле...'),
        ],
      ),
    );
  }
}
