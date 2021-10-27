import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  bool _pass = false;
  bool _newPass = false;
  bool _emptyEmail = false;
  bool _emptyPass = false;
  bool _emptyNewPass = false;
  bool _passwordVisible = false;
  bool _hidePassword = true;

  bool _validatePassword() {
    if (passwordController.text.length > 5) {
      print('Valid pass');
      return true;
    } else if (passwordController.text.isEmpty) {
      return true;
    } else {
      print('Invalid pass');
      return false;
    }
  }

  bool _validateNewPassword() {
    if (newPasswordController.text.length > 5) {
      print('Valid pass');
      return true;
    } else if (newPasswordController.text.isEmpty) {
      return true;
    } else {
      print('Invalid pass');
      return false;
    }
  }

  _onChangePassword() {
    FocusScope.of(context).unfocus();
    if (_validateNewPassword() &&
        _validatePassword() &&
        (newPasswordController.text.isNotEmpty &&
            passwordController.text.isNotEmpty)) {
      //set new password
      BlocProvider.of<ChangePasswordBloc>(context).add(
        PostNewPassword(
          newPassword: newPasswordController.text,
          oldPassword: passwordController.text,
        ),
      );
    } else if (passwordController.text.isEmpty) {
      setState(() {
        _emptyPass = true;
      });
    } else {
      print('we did not expect the error ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor: Color(0xfff7892b),
        ),
        body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // ignore: unnecessary_null_comparison
                  content: Text(state.message.replaceAll('Exception', ''))));
            } else if (state is ChangeLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  // ignore: unnecessary_null_comparison
                  content: Text(state.messageModel.message.toString())));
            }
          },
          child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
            builder: (context, state) {
              if (state is ChangeLoadingState) {
                return Loader();
              }
              return Container(
                height: height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 5),
                            _passwordField('Old Password'),
                            SizedBox(height: 20),
                            _newPasswordField('New Password'),
                            SizedBox(height: 20),
                            _submitButton(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _onChangePassword();
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
          'Submit',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _passwordField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            obscureText: _hidePassword,
            decoration: InputDecoration(
                errorText: _pass
                    ? 'Password too short'
                    : _emptyPass
                        ? 'Please Fill Me In '
                        : null,
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                      _hidePassword = !_hidePassword;
                    });
                  },
                )),
            onChanged: (value) {
              _validatePassword();
              setState(() {
                _emptyPass = false;
              });
              if (value.isEmpty) {
                setState(() {
                  _pass = false;
                });
              } else {
                if (_validatePassword() == false) {
                  setState(() {
                    _pass = true;
                  });
                } else {
                  setState(() {
                    _pass = false;
                  });
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget _newPasswordField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: newPasswordController,
            obscureText: _hidePassword,
            decoration: InputDecoration(
                errorText: _newPass
                    ? 'Password too short'
                    : _emptyNewPass
                        ? 'Please Fill Me In '
                        : null,
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                      _hidePassword = !_hidePassword;
                    });
                  },
                )),
            onChanged: (value) {
              _validateNewPassword();
              setState(() {
                _emptyNewPass = false;
              });
              if (value.isEmpty) {
                setState(() {
                  _newPass = false;
                });
              } else {
                if (_validateNewPassword() == false) {
                  setState(() {
                    _newPass = true;
                  });
                } else {
                  setState(() {
                    _newPass = false;
                  });
                }
              }
            },
          )
        ],
      ),
    );
  }
}
