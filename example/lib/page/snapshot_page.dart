import 'dart:typed_data';

import 'package:flutter/material.dart';

class SnapshotPage extends StatelessWidget {
  const SnapshotPage({Key? key, required this.data}) : super(key: key);
  final Uint8List data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Image.memory(data),
      ),
    );
  }
}
