import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/pdf_bloc/pdf_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';


class UploadPdF extends StatefulWidget {
  const UploadPdF({Key? key}) : super(key: key);

  @override
  _UploadPdFState createState() => _UploadPdFState();
}

class _UploadPdFState extends State<UploadPdF> {
  String tit = 'Uploading....';

  String sub = 'Please wait a moment while we upload your files.';

  @override
  Widget build(BuildContext context) {
    return BlocListener<PdfBloc, PdfState>(
      listener: (context, state) {
        if (state is PDFErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // ignore: unnecessary_null_comparison
              content: Text(state.message.replaceAll('Exception', ''))));
        }

        if (state is PDFUploadedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // ignore: unnecessary_null_comparison
              content: Text('File Uploaded Successfully')));
          //reset bloc
          BlocProvider.of<PdfBloc>(context).add(ResetPdfEvent());
          BlocProvider.of<UserBloc>(context).add(GetUserDataEvent());
        }
      },
      child: BlocBuilder<PdfBloc, PdfState>(
        builder: (context, state) {
          if (state is PDFUploadingState) {
            return uploading();
          } else if (state is PdfInitial) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  onUploadPDF(context);
                },
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/uploads.jpeg'))),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    'Upload',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.5,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text(
                      'Browse and upload your cv to procceed Max Size (10MB) PDF Only',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            );
          } else if (state is PDFUploadedState) {
            print('pdf was uploaded');
            return uploadSuccess();
          } else if (state is PDFErrorState) {
            return buildError(
                message: state.message.replaceAll('Exception', ''));
          }
          return buildError();
        },
      ),
    );
  }

  void onUploadPDF(BuildContext context) async {
    print('uploading pdf');

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      print('picked a file');
      File file = File(result.files.single.path!);
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      //check file size
      if (sizeInMb > 10) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // ignore: unnecessary_null_comparison
            content: Text('File size is bigger than expected')));
      } else {
        BlocProvider.of<PdfBloc>(context).add(UploadPDFEvent(pdfFile: file));
      }
    } else {
      print('user cancelleed picking ');
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: unnecessary_null_comparison
          content: Text('You Cancelled file picking')));
    }
  }

  Widget uploading() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/uploads.jpeg'))),
          ),
          SizedBox(
            height: 60.0,
          ),
          Text(
            'Uploading',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.5,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Text(
              'Please wait while we upload your resume',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.5,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget buildError({String? message}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: RaisedButton(
          color: Color(0xfff7892b), // backgrounds
          textColor: Colors.white, // foreground
          onPressed: () {
            BlocProvider.of<PdfBloc>(context).add(ResetPdfEvent());
          },
          child: Text('Retry'),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message ?? ' Failed to upload please try again ',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget uploadSuccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/uploads.jpeg'))),
        ),
        SizedBox(
          height: 60.0,
        ),
        Text(
          'Please Wait..',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.5,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Text(
            'Pdf Uploaded Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.5,
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
