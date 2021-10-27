import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/bloc/cache_bloc/cache_bloc.dart';
import 'package:link_refurb/bloc/experties_bloc/experties_bloc.dart';
import 'package:link_refurb/bloc/user_bloc/user_bloc.dart';
import 'package:link_refurb/ui/experties_page.dart';
import 'package:link_refurb/ui/home_sub.dart';
import 'package:link_refurb/ui/job_listing.dart';
import 'package:link_refurb/ui/settings/settings.dart';
import 'package:link_refurb/ui/support.dart';
import 'package:link_refurb/ui/upload_pdf.dart';
import 'package:link_refurb/ui/widgets/loader.dart';
import 'package:link_refurb/ui/widgets/logout_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeSub(),
    SettingsPage(),
    // SupportPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          key: globalKey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_outlined),
              label: 'Settings',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.support_agent),
            //   label: 'Support',
            // ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return true;
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
