import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/experties_bloc/experties_bloc.dart';
import 'package:link_refurb/models/experties_model/expertise_model.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class UodateExpertisePage extends StatefulWidget {
  const UodateExpertisePage({Key? key}) : super(key: key);

  @override
  _UodateExpertisePageState createState() => _UodateExpertisePageState();
}

class _UodateExpertisePageState extends State<UodateExpertisePage> {
  Expertise selectedRadio = Expertise(id: 0);
  setSelectedRadio(Expertise val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Expertise'),
        backgroundColor: Color(0xfff7892b),
      ),
      body: BlocListener<ExpertiesBloc, ExpertiesBlocState>(
        listener: (context, state) {
          if (state is ExpertiseUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                // ignore: unnecessary_null_comparison
                content: Text(state.messageModel.message ??
                    'Account Status Updated Successfully')));
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ExpertiesBloc, ExpertiesBlocState>(
          builder: (context, state) {
            if (state is ExpertiseLoadingState) {
              return Loader();
            } else if (state is ExpertiseLoadedState) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      if (selectedRadio.id == 0) {
                        print('attempted to submit while nothing was selected');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            // ignore: unnecessary_null_comparison
                            content: Text('Please Select A Field')));
                      } else {
                        BlocProvider.of<ExpertiesBloc>(context).add(
                            ChangeExperties(expertiesId: selectedRadio.id));
                        print('the selected expertise is ${selectedRadio.id}');
                      }
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: Color(0xfff7892b),
                  ),
                  body:
                      buildList(expertiseListModel: state.expertiseListModel));
            } else if (state is ExpertiseErrorState) {
              return buildError(context,
                  message: state.message.replaceAll('Exception', ''));
            }
            return buildError(context);
          },
        ),
      ),
    );
  }

  Widget buildList({required ExpertiseListModel expertiseListModel}) {
    var list = expertiseListModel.expertise;
    return ListView.builder(
        //filter categories for pages tochange dynamically
        itemCount: list!.length,
        itemBuilder: (BuildContext context, int index) {
          return expertiseCard(list[index]);
        });
  }

  Widget expertiseCard(Expertise expertise) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        expertise.name.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Radio<Expertise>(
                    value: expertise,
                    groupValue: selectedRadio,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val!);
                      print('the selected radio is ' +
                          selectedRadio.id.toString());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
          BlocProvider.of<ExpertiesBloc>(context).add(FetchExpertiesList());
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
