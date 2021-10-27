import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:link_refurb/bloc/pdf_bloc/pdf_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/data/strings.dart';
import 'package:link_refurb/models/user_model/user_model.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class PdfPreviewPage extends StatefulWidget {
  final token;
  final UserModel userModel;
  const PdfPreviewPage({Key? key, required this.token, required this.userModel})
      : super(key: key);

  @override
  _PdfPreviewPageState createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument(widget.token);
  }

  loadDocument(String token) async {
    print('fired');
    var headers = <String, String>{
      "Authorization": "Bearer $token",
      "content-type": "application/json"
    };
    var url =
        '${AppStrings.baseUrl}/storage/cv_file/${widget.userModel.data!.cvFile!.filePath}';
    document = await PDFDocument.fromURL(url, headers: headers);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Cv Preview'), backgroundColor: Color(0xfff7892b)),
      body: BlocListener<PdfBloc, PdfState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<PdfBloc, PdfState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Loader();
            } else if (state is PDFDeletedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: RaisedButton(
                    color: Color(0xfff7892b), // backgrounds
                    textColor: Colors.white, // foreground
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context)
                          .add(GetUserDataEvent());
                      BlocProvider.of<PdfBloc>(context).add(ResetPdfEvent());
                      Navigator.pop(context);
                    },
                    child: Text('Click here to upload cv'),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' Cv removed from the system successfully',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            } else if (state is PDFErrorState) {
              return buildError(context, message: state.message);
            }
            return SafeArea(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Current ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Text(
                        'Cv',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
                Flexible(
                    flex: 8,
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : PDFViewer(document: document)),
                Container(
                  width: 150,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FlatButton(
                      color: Color(0xfff7892b),
                      child: Text(
                        'Change Cv',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        BlocProvider.of<PdfBloc>(context).add(DeletePDFEvent());
                        print(widget.userModel.data!.name.toString());
                      },
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }

  Widget buildError(BuildContext context, {String? message}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: RaisedButton(
          color: Color(0xfff7892b), // backgrounds
          textColor: Colors.white, // foreground
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(GetUserDataEvent());
            BlocProvider.of<PdfBloc>(context).add(ResetPdfEvent());
            Navigator.pop(context);
          },
          child: Text('Retry'),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message ?? ' Oops Something went wrong please retry',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
