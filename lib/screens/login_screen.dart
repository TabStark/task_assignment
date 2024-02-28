import 'package:flutter/material.dart';
import 'package:task_assignment/main.dart';
import 'package:task_assignment/screens/home_screen.dart';
import 'package:task_assignment/screens/signup_screen.dart';
import 'package:task_assignment/services/shared_preferences.dart';
import 'package:task_assignment/utils/popup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool passwordSecure = true;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/seamless-pattern-with-cinema-elements_225004-1154.jpg?size=626&ext=jpg&ga=GA1.1.1377924036.1705991386&semt=ais'),
                fit: BoxFit.cover)),
        child: Center(
          child: Container(
            height: mq.height * .4,
            width: mq.width * .8,
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Login Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    // User name
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('Email Id'),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: passwordSecure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            setState(() {
                              passwordSecure = !passwordSecure;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        label: Text('Password'),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // Login button
                    SizedBox(
                      width: mq.width * 0.35,
                      height: mq.height * 0.05,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              String trimemail = _emailController.text;
                              String id = trimemail.substring(
                                  0, trimemail.indexOf('@'));
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              bool loginStatus = await MySharedPreferences()
                                  .getSharedPreferences(id, email, password);
                              if (loginStatus == true) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              } else {
                                PopUpMenu.showFlushBarBottom(
                                    context, "Invalid user name or password!");
                              }
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 15),
                          )),
                    ),

                    // Signup page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          child: Text(
                            " Sign Up",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage())),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
