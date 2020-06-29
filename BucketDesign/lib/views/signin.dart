// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Services
import '../services/auth.dart';

// Views
import '../views/home.dart';

class SignIn extends StatefulWidget {
  final Function callback;
  SignIn(this.callback);

  static const routeName = "/signin";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();

  bool _obscurePass = true;
  bool _isLoading = false;

  AuthMethods authMethods = AuthMethods();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  signMeIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((val) {
        Navigator.pushReplacementNamed(context, Home.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          "assets/images/little_logo_main_color.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 200,
                        child: Text(
                          "Log In to start share your work and chat with other designers.",
                          style: TextStyle(
                            color: CustomTheme.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 40),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email",
                              style: TextStyle(
                                color: CustomTheme.white,
                                fontSize: 27,
                              ),
                            ),
                            Container(
                              width: 350,
                              child: TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please enter a valid email";
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                style: TextStyle(
                                  color: CustomTheme.white,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF4D4D4D),
                                  hintText: "example@gmail.com",
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 15, bottom: 15),
                                  hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      color: CustomTheme.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {},
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                        color:
                                            CustomTheme.white.withOpacity(0.6),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 350,
                              child: TextFormField(
                                obscureText: _obscurePass,
                                validator: (val) {
                                  return val.isNotEmpty && val.length > 6
                                      ? null
                                      : "Enter a password 6+ characters";
                                },
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordController,
                                style: TextStyle(
                                  color: CustomTheme.white,
                                ),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscurePass = !_obscurePass;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF4D4D4D),
                                  hintText: "password123",
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 15, bottom: 15),
                                  hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            GestureDetector(
                              onTap: () => signMeIn(),
                              child: Container(
                                width: 350,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: CustomTheme.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: CustomTheme.white,
                                    fontSize: 26,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 350,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: CustomTheme.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Log In with Google",
                                style: TextStyle(
                                  color: CustomTheme.mainColor,
                                  fontSize: 26,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: CustomTheme.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.callback,
                              child: Container(
                                child: Text(
                                  "Regsiter",
                                  style: TextStyle(
                                    color: CustomTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      backgroundColor: CustomTheme.darkGray,
    );
  }
}
