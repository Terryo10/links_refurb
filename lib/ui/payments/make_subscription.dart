import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/subscription_bloc/subscription_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/models/payments_model/payment_check_model.dart';
import 'package:link_refurb/models/payments_model/payments_model.dart';
import 'package:link_refurb/ui/widgets/loader.dart';
import 'package:intl/intl.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final _formKey = GlobalKey<FormState>();

  final formatCurrency = new NumberFormat.simpleCurrency();
  String? dropDownValue;
  List<String> cityList = [
    'ecocash',
    'onemoney',
    'telecash',
  ];
  final phoneNumberController = TextEditingController();

  _onPayButtonPressed(BuildContext context) {
    if (dropDownValue == null) {
      //do nothing
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: unnecessary_null_comparison
          content: Text('Select Payment Method')));
    } else if (phoneNumberController.text.isEmpty) {
      //do nothing
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: unnecessary_null_comparison
          content: Text('Enter Phone number')));
    } else if (phoneNumberController.text.isEmpty && dropDownValue == null) {
      //do nothing
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: unnecessary_null_comparison
          content: Text('Please fill the empty fields')));
    } else if (phoneNumberController.text.length != 10) {
      print('some somw');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: unnecessary_null_comparison
          content: Text('Invalid Phone Number')));
    } else if (phoneNumberController.text.isNotEmpty &&
        dropDownValue != null &&
        phoneNumberController.text.length == 10) {
      //do something
      BlocProvider.of<SubscriptionBloc>(context).add(SubscribeEvent(
          phoneNumber: phoneNumberController.text, method: dropDownValue!));
    } else {
      print('ttk');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (state is PaymentCheckedState) {
          if (state.paymentCheckModel.status == "Paid") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                // ignore: unnecessary_null_comparison
                content: Text('Thank you for subscribing')));
            BlocProvider.of<UserBloc>(context).add(GetUserDataEvent());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Subscriptions'),
          backgroundColor: Color(0xfff7892b),
        ),
        body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
            if (state is SubscriptionPriceLoadingState) {
              return Loader();
            } else if (state is SubscriptionPriceLoadedState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.6,
                          width: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/credit.png'))),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                            'Subscription price  is ZWL ${formatCurrency.format(state.priceModel!.price!.subscriptionPrice)} '),
                        SizedBox(
                          height: 10.0,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //   borderRadius: const BorderRadius.all(
                                    //     const Radius.circular(30.0),
                                    //   ),
                                    // ),
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "Select Payment Method",
                                    fillColor: Color(0xfff7892b)),
                                value: dropDownValue,
                                onChanged: (String? Value) {
                                  setState(() {
                                    dropDownValue = Value;
                                  });
                                },
                                items: cityList
                                    .map((cityTitle) => DropdownMenuItem(
                                        value: cityTitle,
                                        child: Text("$cityTitle")))
                                    .toList(),
                              ),
                              _phoneNumberField('Payment Phone Number'),
                              _submitButton(context)
                            ],
                          ),
                        )
                      ]),
                ),
              );
            } else if (state is SubscriptionPayingState) {
              //loading payment
              return makingPayment();
            } else if (state is SubscriptionPaidState) {
              //paid payment and check transaction
              return transactionSent(
                  model: state.paynowResponseModel, context: context);
            } else if (state is SubscriptionErrorState) {
              //some Error happened
              return buildError(message: state.message);
            } else if (state is CheckingPaymentState) {
              return checkingTransaction();
            } else if (state is PaymentCheckedState) {
              if (state.paymentCheckModel.status == 'Paid') {
                //payment was done
                print('transaction was paid');
                return Container(
                  child: Center(
                    child: Text('Subscription was made successfully'),
                  ),
                );
              } else if (state.paymentCheckModel.status == 'Sent') {
                print('transaction was sent');
                //check again
                return reCheckSent(
                    context: context, model: state.paymentCheckModel);
              } else if (state.paymentCheckModel.status == 'Cancelled') {
                //payment was cancelled
                print('transaction was cancelled');
                return paymentCancelled(
                    context: context, model: state.paymentCheckModel);
              } else {
                print(state.paymentCheckModel.status);
                return transactionChecked();
              }
            }
            return buildError();
          },
        ),
      ),
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
        _onPayButtonPressed(context);
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
          'Pay Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget makingPayment() {
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
                    "Placing Transaction...",
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ],
        ));
  }

  Widget transactionSent(
      {PaynowResponseModel? model, required BuildContext context}) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text(model!.message!),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  BlocProvider.of<SubscriptionBloc>(context)
                      .add(CheckPaymentEvent(model.order!.id!));
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
                    'Check Payment',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget reCheckSent(
      {PaymentCheckModel? model, required BuildContext context}) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text('Payment Status is reflecting as sent'),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  BlocProvider.of<SubscriptionBloc>(context)
                      .add(CheckPaymentEvent(model!.order!.id!.toInt()));
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
                    'Check Payment Again',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<SubscriptionBloc>(context)
                      .add(GetPriceEvent());
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
                    'Cancel Payment Check',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget paymentCancelled(
      {PaymentCheckModel? model, required BuildContext context}) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text('Oops Payment was cancelled'),
              SizedBox(height: 15),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<SubscriptionBloc>(context)
                      .add(GetPriceEvent());
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
                    'Cancel Payment Check',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget checkingTransaction() {
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
                    "Confirming Transaction...",
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ],
        ));
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
            //reset bloc
            BlocProvider.of<SubscriptionBloc>(context).add(GetPriceEvent());
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

  Widget transactionChecked() {
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
                    "Transaction Checked...",
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
