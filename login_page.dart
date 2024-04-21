import 'package:flutter/material.dart';
import 'package:animation/ui/HomePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _loginAnimation;
  Animation _loginFieldsAnimation;
  Animation _loginButtonAnimation;
  final _formKey = GlobalKey<FormState>();
  String _email = ' ';
  String _password = ' ';
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _loginAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.bounceIn)));

    _loginFieldsAnimation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: Curves.easeIn)));

    _loginButtonAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn)));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 80.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _loginAnimation,
              child: _buildLoginLogo(),
              builder: (context, child) {
                return Transform(
                    child: child,
                    transform: Matrix4.translationValues(
                        0.0, _loginAnimation.value * width, 0.0));
              },
            ),
            AnimatedBuilder(
              animation: _loginFieldsAnimation,
              child: _buildLoginTextFields(),
              builder: (context, child) {
                return Transform(
                    child: child,
                    transform: Matrix4.translationValues(
                        _loginFieldsAnimation.value * width, 0.0, 0.0));
              },
            ),
            AnimatedBuilder(
              animation: _loginButtonAnimation,
              child: _buildLoginButton(),
              builder: (context, child) {
                return Transform(
                    child: child,
                    transform: Matrix4.translationValues(
                        0.0, _loginButtonAnimation.value * width, 0.0));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
            width: 150.0,
            height: 150.0,
          ),
          Text(
            'Company Name',
            style: Theme.of(context).textTheme.headline,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTextFields() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (String currentValue) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(currentValue))
                  return 'Enter Valid Email';
                else
                  return null;
              },
              onSaved: (String value) {
                _email = value;
              },
              decoration: InputDecoration(
                  hintText: "example@gmvail.com",
                  labelText: "Email Address",
                  fillColor: Theme.of(context).accentColor.withOpacity(0.05),
                  filled: true),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
                validator: (String currentValue) {
                  Pattern pattern = r'^[a-z0-9_-]{4,18}$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(currentValue))
                    return 'Only letters,digits and hyphen are allowed';
                  else
                    return null;
                },
                onSaved: (String value) {
                  _password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Theme.of(context).accentColor.withOpacity(0.05),
                    filled: true)),
          ],
        ),
      ),
    );
  }
