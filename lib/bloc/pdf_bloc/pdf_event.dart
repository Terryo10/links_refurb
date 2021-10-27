part of 'pdf_bloc.dart';

@immutable
abstract class PdfEvent {}

class UploadPDFEvent extends PdfEvent {
  final File pdfFile;

  UploadPDFEvent({required this.pdfFile});
}

class DeletePDFEvent extends PdfEvent {}

class GetUserPdfEvent extends PdfEvent {}

class ResetPdfEvent extends PdfEvent{}


