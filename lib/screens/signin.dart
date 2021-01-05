import 'package:flutter/material.dart';
import 'package:socgo/screens/create_account.dart';
import 'package:socgo/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: Placeholder(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Hey!", style: Theme.of(context).textTheme.headline4),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Sign in or create an account to begin your journey around the world!",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email Address"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: pwController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _obscureText
                                ? MediaQuery.platformBrightnessOf(context) == Brightness.dark
                                    ? Color(0x99FFFFFF)
                                    : Color(0x99000000)
                                : Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            _toggle();
                          },
                        )),
                    obscureText: _obscureText,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot password?"),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              context.read<AuthenticationService>().signInGoogle().then((m) => {
                                    if (m != "Success")
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Text("Error while logging in"),
                                                  content: Text(m),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.pop(context, true);
                                                      },
                                                    )
                                                  ],
                                                )),
                                        pwController.text = ""
                                      }
                                  });
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              SvgPicture.asset(
                                "res/img/google_g.svg",
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Google"),
                            ]),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.background),
                              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).textTheme.headline1.color),
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Image.asset(
                              "res/img/facebook_f.png",
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Facebook"),
                          ]),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1877F2)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Route r = MaterialPageRoute(builder: (context) => CreateAccountScreen());
                          Navigator.push(context, r);
                        },
                        child: Text("Create account"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signIn(
                                email: emailController.text.trim(),
                                password: pwController.text.trim(),
                              )
                              .then((m) => {
                                    if (m != "Success")
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Text("Error while logging in"),
                                                  content: Text(m),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.pop(context, true);
                                                      },
                                                    )
                                                  ],
                                                )),
                                        pwController.text = ""
                                      }
                                  });
                        },
                        child: Text("Sign in"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
