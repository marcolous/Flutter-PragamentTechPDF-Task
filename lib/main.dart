import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const PragamentTechPDF());
}

class PragamentTechPDF extends StatelessWidget {
  const PragamentTechPDF({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String? pdfFilePath;

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
  }

  Future<void> _loadPdfFromAssets() async {
    final byteData =
        await rootBundle.load('assets/marco_louis_flutter_developer.pdf');
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/sample.pdf");
    await file.writeAsBytes(byteData.buffer.asUint8List());
    setState(() {
      pdfFilePath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marco Louis Flutter Developer'),
      ),
      body: pdfFilePath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: pdfFilePath,
            ),
    );
  }
}
