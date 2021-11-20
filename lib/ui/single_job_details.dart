import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/applications_bloc/applications_bloc.dart';

import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/ui/payments/make_subscription.dart';
import 'package:link_refurb/ui/payments/update_subscription.dart';
import 'package:link_refurb/ui/settings/subscription_status_page.dart';

class SingleJobDetails extends StatefulWidget {
  final Job job;
  const SingleJobDetails(this.job) : super();

  @override
  _SingleJobDetailsState createState() => _SingleJobDetailsState();
}

class _SingleJobDetailsState extends State<SingleJobDetails> {
  List ids = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            state.jobs.jobs!.forEach((element) {
              ids.add(element.id!);
            });
            if (state.userModel.data!.subscription == null) {
              //user does not have subscription
              return SubscriptionPage();
            } else {
              //check validity
              var expiresAt = DateTime.parse(state
                  .userModel.data!.subscription!.expiresAt!
                  .toIso8601String());
              var currentDate = DateTime.now();
              if (expiresAt.isBefore(currentDate)) {
                // the subscription is expired
                return SubscriptionStatusPage();
              } else {
                return jobDetails(job: widget.job);
              }
            }
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('${widget.job.name}'),
                backgroundColor: Color(0xfff7892b),
              ),
              body: loader());
        },
      ),
    );
  }

  Widget jobDetails({required Job job}) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {},
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadedState) {
          return Scaffold(
              appBar: AppBar(
                title: Text('${widget.job.name}'),
                backgroundColor: Color(0xfff7892b),
              ),
              body: BlocListener<ApplicationsBloc, ApplicationsState>(
                  listener: (context, state) {
                if (state is JobAppliedState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      // ignore: unnecessary_null_comparison
                      content: Text(state.messageModel.message!)));
                  BlocProvider.of<UserBloc>(context).add(GetUserDataEvent());
                }
              }, child: BlocBuilder<ApplicationsBloc, ApplicationsState>(
                builder: (context, state) {
                  if (state is ApplicationLoadingState) {
                    return loader();
                  } else if (state is ApplicationErrorState) {
                    return buildError(context, message: state.message);
                  }
                  return _body(context, position: widget.job);
                },
              )));
        } else {
          return buildError(context);
        }
      }),
    );
  }

  Widget _body(BuildContext context, {required Job position}) {
    if (ids.contains(position.id)) {
      print('lllll');
    }
    return Center(
      key: Key('Content'),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              position.name!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            title: Text(position.organisation!.name!),
            subtitle: Text(position.organisation!.location!),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              position.type!,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
          Divider(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Description',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16.0,
                  ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(position.description!)),
          Divider(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Tasks',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16.0,
                  ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(position.tasks!)),
          Divider(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'How to apply',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16.0,
                  ),
            ),
          ),
          SizedBox(height: 16.0),
          Card(
            elevation: 0.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                  'Click the apply button to apply the job with the cv that you uploaded, you will be notified about the job / interviews via Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                if (ids.contains(position.id)) {
                  //do nothing
                } else {
                  //make application
                  BlocProvider.of<ApplicationsBloc>(context)
                      .add(JobApplication(jobId: position.id));
                }
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
                child: ids.contains(position.id)
                    ? Text(
                        'You Have Already Applied',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : Text(
                        'Apply',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
              ),
            ),
          )
        ],
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
            BlocProvider.of<ApplicationsBloc>(context).add(Reset());
            BlocProvider.of<UserBloc>(context).add(GetUserDataEvent());
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

  Widget loader() {
    return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: new CircularProgressIndicator(
                        backgroundColor: Color(0xfff7892b),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    "Processing Please wait...",
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
