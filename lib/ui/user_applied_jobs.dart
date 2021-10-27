import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/applied_jobs_bloc/appliedjobs_bloc.dart';
import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/ui/single_job_details.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class UserAppliedJobs extends StatefulWidget {
  const UserAppliedJobs({Key? key}) : super(key: key);

  @override
  _UserAppliedJobsState createState() => _UserAppliedJobsState();
}

class _UserAppliedJobsState extends State<UserAppliedJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Jobs'),
        backgroundColor: Color(0xfff7892b),
      ),
      body: BlocListener<AppliedjobsBloc, AppliedjobsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<AppliedjobsBloc, AppliedjobsState>(
          builder: (context, state) {
            if (state is AppliedjobsLoadingState) {
              return Loader();
            } else if (state is AppliedjobsILoadedState) {
              if (state.jobsModel.jobs!.isEmpty) {
                print('hapana mabasa');
                return noJobs(context: context);
              }
              return jobsList(jobsModel: state.jobsModel);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget jobsList({required JobsModel jobsModel}) {
    var list = jobsModel.jobs;
    return ListView.builder(
        itemCount: list!.length,
        itemBuilder: (BuildContext context, int index) {
          return jobCard(job: list[index]);
        });
  }

  Widget jobCard({Job? job}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleJobDetails(job!)),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            width: 2,
            color: Color(0xfff7892b),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job!.name ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'CenturyGothicBold',
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                Expanded(flex: 1, child: Icon(Icons.navigate_next)),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Icon(Icons.query_builder)),
                Expanded(
                  flex: 4,
                  child: Text(
                    job.type ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'CenturyGothicBold',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Icon(Icons.location_on)),
                Expanded(
                  flex: 4,
                  child: Text(
                    job.organisation!.location ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'CenturyGothicBold',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ]),
        ),
      ),
    );
  }

  Widget noJobs({required BuildContext context}) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text('You Have Not applied for any jobs yet'),
              SizedBox(height: 15),
              // InkWell(
              //   onTap: () {
              //     BlocProvider.of<SubscriptionBloc>(context)
              //         .add(GetPriceEvent());
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => SubscriptionPage()),
              //     );
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     padding: EdgeInsets.symmetric(vertical: 15),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //         boxShadow: <BoxShadow>[
              //           BoxShadow(
              //               color: Colors.grey.shade200,
              //               offset: Offset(2, 4),
              //               blurRadius: 5,
              //               spreadRadius: 2)
              //         ],
              //         gradient: LinearGradient(
              //             begin: Alignment.centerLeft,
              //             end: Alignment.centerRight,
              //             colors: [Color(0xfffbb448), Color(0xfff7892b)])),
              //     child: Text(
              //       'Click Here To Subscribe',
              //       style: TextStyle(fontSize: 20, color: Colors.white),
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
