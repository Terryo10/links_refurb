import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/bloc/cache_bloc/cache_bloc.dart';
import 'package:link_refurb/bloc/jobs_bloc/jobs_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/data/strings.dart';
import 'package:link_refurb/ui/experties_page.dart';
import 'package:link_refurb/ui/job_listing.dart';
import 'package:link_refurb/ui/settings/settings.dart';
import 'package:link_refurb/ui/upload_pdf.dart';
import 'package:link_refurb/ui/widgets/loader.dart';
import 'package:link_refurb/ui/widgets/logout_popup.dart';

class HomeSub extends StatefulWidget {
  const HomeSub({Key? key}) : super(key: key);

  @override
  _HomeSubState createState() => _HomeSubState();
}

class _HomeSubState extends State<HomeSub> {
  FlutterSecureStorage storage = new FlutterSecureStorage();
  String name = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color(0xfff7892b),
              title: Text('Links App'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<JobsBloc>(context).add(FetchUserJobs());
                      },
                      child: Container(
                          height: 50, width: 50, child: Icon(Icons.refresh)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: Container(
                          height: 50, width: 50, child: Icon(Icons.logout)),
                    ),
                  ),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: "All Jobs"),
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          return Text(state.userModel.data!.name!);
                        }
                        return Text('Loading Name');
                      },
                    ),
                    accountEmail: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          return Text(state.userModel.data!.email!);
                        }
                        return Text('Loading Email');
                      },
                    ),
                    currentAccountPicture: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          if (state.userModel.data!.profile == null) {
                            return CircleAvatar(
                              child: ClipOval(
                                child: Image(
                                  height: 90,
                                  width: 90,
                                  image: AssetImage('assets/placeholder.png'),
                                ),
                              ),
                            );
                          }
                          return CircleAvatar(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${AppStrings.baseUrl}/storage/product_images/${state.userModel.data!.profile!.imagePath}",
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          );
                        }
                        return CircleAvatar(
                          child: ClipOval(
                            child: Image(
                              height: 90,
                              width: 90,
                              image: AssetImage('assets/placeholder.png'),
                            ),
                          ),
                        );
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff7892b),
                    ),
                  ),
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Log Out'),
                    onTap: () {
                      Navigator.pop(context);
                      _showDialog();
                    },
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoadedState) {
                    if (state.userModel.data!.profile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          // ignore: unnecessary_null_comparison
                          content:
                              Text('Please Upload a photo on your profile ')));
                    }
                  }
                },
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoadingState) {
                      return Loader();
                    } else if (state is UserLoadedState) {
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
                      return JobsPage();
                    } else if (state is UserErrorState) {
                      return buildError(
                          message: state.message.replaceAll('Exception', ''));
                    }
                    return buildError();
                  },
                ),
              ),
            ])));
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return LogoutPopup();
        });
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
