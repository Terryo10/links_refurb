import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/jobs_bloc/jobs_bloc.dart';
import 'package:link_refurb/models/jobs_model/jobs_model.dart';
import 'package:link_refurb/ui/single_job_details.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class JobsPage extends StatefulWidget {
  JobsPage({Key? key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<JobsBloc, JobsState>(
      listener: (context, state) {},
      child: BlocBuilder<JobsBloc, JobsState>(
        builder: (context, state) {
          if (state is JobsLoadingState) {
            return Loader();
          } else if (state is JobsLoadedState) {
            return jobsList(jobsModel: state.jobsModel);
          } else if (state is JobsErrorState) {
            return buildError(context,
                message: state.message.replaceAll('Exception', ''));
          }
          return buildError(context);
        },
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
      child: Container(
        
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Card(
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.5),
            side: BorderSide(
              width: 0.5,
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
            ]),
          ),
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
            BlocProvider.of<JobsBloc>(context).add(FetchUserJobs());
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
