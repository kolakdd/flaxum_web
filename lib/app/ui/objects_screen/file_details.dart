import 'package:flutter/material.dart';

class FileDetails extends StatelessWidget {
  const FileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Some body wants told me.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Дополнительная информация о файле...'),
        ],
      ),
    );
  }
}
