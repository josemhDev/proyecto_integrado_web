import 'package:flutter/material.dart';
import 'package:proyecto_integrado_3/widgets/uploadImgWidget.dart';

class UploadFilePage extends StatelessWidget {
  const UploadFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:  UploadImgWidget(),
    );
  }
}