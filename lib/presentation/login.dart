import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roottest/application/login/login_bloc.dart';
import 'package:roottest/domain/login/Models/login/login.dart';
import 'package:roottest/domain/login/Models/login_request/login_request.dart';
import 'package:roottest/presentation/categories.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(""),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.status == true) {
                    _navigateToCategories(context);
                  } else if (state.hasError == true) {
                    _showErrorSnackBar(context, state.message);
                  }
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, handle the submission
                          final LoginRequest loginRequest = LoginRequest(
                              email: _usernameController.text,
                              password: _passwordController.text);
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginInitial(loginrequest: loginRequest));
                        }
                      },
                      child: Text(state.isLoading ? "Loading.." : "Login"));
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  void _navigateToCategories(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CategoriesWidget()),
      );
    });
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
