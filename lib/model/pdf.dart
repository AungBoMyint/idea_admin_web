import 'package:freezed_annotation/freezed_annotation.dart';

part 'pdf.freezed.dart';
part 'pdf.g.dart';

@freezed
class Pdf with _$Pdf {
  factory Pdf({
    Map<String, dynamic>? data,
    required int id,
    @JsonKey(name: "pdf_url") required String pdfUrl,
    required int duration,
  }) = _Pdf;
  factory Pdf.fromJson(Map<String, dynamic> json) => _$PdfFromJson(json);
}
