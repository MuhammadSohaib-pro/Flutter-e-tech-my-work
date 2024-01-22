import 'dart:io';
import 'dart:ui';
import 'package:elabd_tms_app/models/pdf_atttendance_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';



class PdfHanlder {
  static Future<void> makeAttendanceHistoryReport(
      List<PdfAttendanceModel> attendance) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 4);
    final PdfGridRow headerRow = grid.headers.add(1)[0];

    headerRow.cells[0].value = 'Check In/Check Out';
    headerRow.cells[1].value = 'Date';
    headerRow.cells[2].value = 'Time';
    headerRow.cells[3].value = 'Description';
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    for (var element in attendance) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = element.type;
      row.cells[1].value = element.date;
      row.cells[2].value = element.time;
      row.cells[3].value = element.description;
      grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    }

    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    Directory dir = Directory('/storage/emulated/0/Download');
    String fileName = 'AttendanceReport.pdf';
    var localPath = dir.path;
    final savedDir = Directory(localPath);
    String fullPath = "";
    await savedDir.create(recursive: true).then((value) async {
      fullPath = '$localPath/$fileName';
      int fileNumber = 0;
      while (await File(fullPath).exists()) {
        fileNumber++;
        fullPath = '$localPath/${fileName.replaceAll('.', '($fileNumber).')}';
      }
    });
// Save the document.
    File(fullPath).writeAsBytes(await document.save());

// Dispose the document.
    document.dispose();
  }
}
