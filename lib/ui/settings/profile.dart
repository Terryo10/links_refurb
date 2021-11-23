import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/bloc/profile_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/data/strings.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          backgroundColor: Color(0xfff7892b),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // ignore: unnecessary_null_comparison
                  content: Text(state.message)));
            }

            if (state is ProfileLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // ignore: unnecessary_null_comparison
                  content: Text(state.messageModel.message.toString())));
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Loader();
              }
              return BlocListener<UserBloc, UserState>(
                listener: (context, state) {},
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoadedState) {
                      if (state.userModel.data!.profile == null) {
                        print('no profile');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: uploadProfile(context),
                        );
                      }
                      return Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  radius: 45,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${AppStrings.baseUrl}/storage/app/public/product_images/${state.userModel.data!.profile!.imagePath}",
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(state.userModel.data!.name.toString()),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(state.userModel.data!.email.toString()),
                                SizedBox(
                                  height: 5,
                                ),
                                deleteButton(context)
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Loader();
                  },
                ),
              );
            },
          ),
        ));
  }

  void onUploadPDF(BuildContext context) async {
    print('uploading image');

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg']);

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
      } else if (phoneNumberController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // ignore: unnecessary_null_comparison
            content: Text('Enter Phone Number')));
      } else {
        BlocProvider.of<ProfileBloc>(context).add(CreateProfileEvent(
            image: file, phoneNumber: phoneNumberController.text));
      }
    } else {
      print('user cancelleed picking ');
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: unnecessary_null_comparison
          content: Text('You Cancelled file picking')));
    }
  }

  Widget uploadProfile(BuildContext context) {
    return Column(
      children: <Widget>[
        _phoneNumberField('Enter Your Phone Number'),
        _submitButton(context)
      ],
    );
  }

  Widget _phoneNumberField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLength: 10,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            obscureText: isPassword,
            decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: 'Eg 077322...',
                fillColor: Color(0xfff7892b),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        onUploadPDF(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Select Image',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ProfileBloc>(context).add(DeleteProfileEvent());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Delete / Change Profile',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
