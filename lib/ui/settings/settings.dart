import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/applied_jobs_bloc/appliedjobs_bloc.dart';
import 'package:link_refurb/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:link_refurb/bloc/cache_bloc/cache_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/models/user_model/user_model.dart';
import 'package:link_refurb/ui/experties_page.dart';
import 'package:link_refurb/ui/settings/change_password.dart';

import 'package:link_refurb/ui/settings/preview_pdf.dart';
import 'package:link_refurb/ui/settings/subscription_status_page.dart';
import 'package:link_refurb/ui/settings/profile.dart';
import 'package:link_refurb/ui/update_expertise.dart';
import 'package:link_refurb/ui/upload_pdf.dart';
import 'package:link_refurb/ui/user_applied_jobs.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    UserModel user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xfff7892b),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Loader();
            } else if (state is UserLoadedState) {
              user = state.userModel;
              if (state.userModel.data!.expertise == null) {
                //return expertise first
                print('hapana expertise');
                return ExpertiesPage();
              }
              if (state.userModel.data!.expertise != null &&
                  state.userModel.data!.cvFile == null) {
                print('hapana cv');
                return UploadPdF();
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ));
                      },
                      child: Container(
                        height: 70,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                              width: 0.5,
                              color: Color(0xfff7892b),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.purple,
                                    ),
                                  )),
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Change Password',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: 'CenturyGothicBold',
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Colors.purple,
                                      )),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is AuthenticationAuthenticatedState) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfPreviewPage(
                                        token: state.authenticationModel.token,
                                        userModel: user),
                                  ));
                            },
                            child: Container(
                              height: 70,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  side: BorderSide(
                                    width: 0.5,
                                    color: Color(0xfff7892b),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.purple,
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Preview/Change Cv',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'CenturyGothicBold',
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.navigate_next,
                                              color: Colors.purple,
                                            )),
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocBuilder<CacheBloc, CacheBlocState>(
                      builder: (context, state) {
                        if (state is CacheFoundState) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfPreviewPage(
                                      token: state.token,
                                      userModel: user,
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 70,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  side: BorderSide(
                                    width: 0.5,
                                    color: Color(0xfff7892b),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.description,
                                              color: Colors.purple,
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Preview/Change Cv',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'CenturyGothicBold',
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.navigate_next,
                                              color: Colors.purple,
                                            )),
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        // UodateExpertisePage
                        BlocProvider.of<AppliedjobsBloc>(context)
                            .add(GetAppliedJobsEvent());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserAppliedJobs(),
                            ));
                      },
                      child: Container(
                        height: 70,
                        child: Container(
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(
                                width: 0.5,
                                color: Color(0xfff7892b),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.important_devices,
                                          color: Colors.purple,
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'My Applied Jobs',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontFamily: 'CenturyGothicBold',
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.navigate_next,
                                          color: Colors.purple,
                                        )),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // UodateExpertisePage
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubscriptionStatusPage(),
                            ));
                      },
                      child: Container(
                        height: 70,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                              width: 0.5,
                              color: Color(0xfff7892b),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.attach_money,
                                        color: Colors.purple,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Subscription Status',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: 'CenturyGothicBold',
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Colors.purple,
                                      )),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // UodateExpertisePage
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ));
                      },
                      child: Container(
                        height: 70,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                              width: 0.5,
                              color: Color(0xfff7892b),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.face_retouching_natural,
                                        color: Colors.purple,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'View | Update Profile',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontFamily: 'CenturyGothicBold',
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Colors.purple,
                                      )),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserErrorState) {
              return buildError(
                  message: state.message.replaceAll('Exception', ''));
            }
            return buildError();
          },
        ),
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
            BlocProvider.of<CacheBloc>(context).add(AppStartedEvent());
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
