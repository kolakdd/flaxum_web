import 'package:flaxum_fileshare/app/providers/uxo_provider.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/right_side_details/uxo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightSideDetails extends StatelessWidget {
  const RightSideDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var uxoItems = Provider.of<UxoProvider>(context, listen: true).data;
    return Container(
      width: 300,
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "О файле:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
              height: 500,
              child: uxoItems.isEmpty
                  ? const Text('Нажмите на файл.')
                  : UxoListStateful(uxoItems: uxoItems))
        ],
      ),
    );
  }
}
