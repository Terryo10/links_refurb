import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:link_refurb/bloc/welcome_bloc/welcome_bloc.dart';

class LogoutPopup extends StatefulWidget {
  LogoutPopup();

  @override
  _LogoutPopupState createState() => _LogoutPopupState();
}

class _LogoutPopupState extends State<LogoutPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign out of Links?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _alertButton(
                  color: Color(0xfff7892b),
                  text: 'Yes',
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AppLogoutEvent());
                    BlocProvider.of<WelcomeBloc>(context)
                        .add(WelcomeResetEvent());
                    Navigator.of(context).pop();
                  },
                ),
                _alertButton(
                  color: Colors.grey,
                  text: 'No',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertButton(
      {required String text, dynamic onPressed, required Color color}) {
    return FlatButton(
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
