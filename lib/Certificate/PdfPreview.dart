// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart ' as pw;
// import 'package:printing/printing.dart';

// import 'package:jmc/Certificate/CertificateField.dart';


// class PdfPreviewPage extends StatelessWidget {
//   Uint8List? screenshot;

//   PdfPreviewPage({
//     Key? key,
//     required this.screenshot,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF22E183),

//         //for back arrow option
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),

//         title: const Center(
//           child: Text(
//             'Certificate        ',
//             style: TextStyle(color: Colors.black, fontFamily: 'Gotham'),
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: PdfPreview(
//         // build: (context) => makePdf(certificate),
//         build: (context) => getPdf(screenshot!),
//       ),
//     );
//   }
// }


// //genrate pdf
// Future<Uint8List> getPdf(Uint8List screenShot) async {
//   pw.Document pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (context) {
//         return pw.Expanded(
//           // change this line to this:
//           child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
//         );
//       },
//     ),
//   );
//   // File pdfFile = File('Your path + File name');
//   // pdfFile.writeAsBytesSync(await pdf.save());
//   return pdf.save();
// }
