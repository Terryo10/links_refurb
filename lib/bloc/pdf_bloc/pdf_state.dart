part of 'pdf_bloc.dart';

@immutable
abstract class PdfState {}

class PdfInitial extends PdfState {}

class PDFUploadingState extends PdfState {}

class PDFUploadedState extends PdfState {
  final MessageModel messageModel;
  
  PDFUploadedState({required this.messageModel});
}

class PDFErrorState extends PdfState {
  final String message;

  PDFErrorState(this.message);
}

class LoadingState extends PdfState {}

class PDFDeletedState extends PdfState{
  final MessageModel messageModel;
  
  PDFDeletedState({required this.messageModel});
}
