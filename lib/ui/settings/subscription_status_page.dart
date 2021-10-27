import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:link_refurb/bloc/subscription_bloc/subscription_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/models/user_model/user_model.dart';
import 'package:link_refurb/ui/payments/make_subscription.dart';

class SubscriptionStatusPage extends StatefulWidget {
  const SubscriptionStatusPage({Key? key}) : super(key: key);

  @override
  _SubscriptionStatusPageState createState() => _SubscriptionStatusPageState();
}

class _SubscriptionStatusPageState extends State<SubscriptionStatusPage> {
  final f = new DateFormat.yMMMMd('en_US');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Status'),
        backgroundColor: Color(0xfff7892b),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadedState) {
              if (state.userModel.data!.subscription == null) {
                return noSubscription(context: context);
              }
              return body(context: context, userModel: state.userModel);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget body({required BuildContext context, required UserModel userModel}) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text(
                  'You Subscription expires on ${f.format(DateTime.parse(userModel.data!.subscription!.expiresAt.toString()))}'),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  BlocProvider.of<SubscriptionBloc>(context)
                      .add(GetPriceEvent());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubscriptionPage()),
                  );
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
                    'Top Up Days To Your Subscription',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget noSubscription({required BuildContext context}) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text('You Have No Subscription Yet'),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  BlocProvider.of<SubscriptionBloc>(context)
                      .add(GetPriceEvent());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubscriptionPage()),
                  );
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
                    'Click Here To Subscribe',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
