import 'package:flutter/material.dart';
import 'package:task_assignment/main.dart';
import 'package:task_assignment/screens/home_screen.dart';
import 'package:task_assignment/screens/login_screen.dart';
import 'package:task_assignment/services/shared_preferences.dart';
import 'package:task_assignment/utils/popup.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool passwordSecure = true;
  @override
  Widget build(BuildContext context) {
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
            height: mq.height * .7,
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
                    // Name
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('Name'),
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
                          return 'Please enter Name';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // Email name
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('Email'),
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
                          return 'Please enter Email';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // Phone Number
                    TextFormField(
                      controller: _phoneNoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('Phone No'),
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
                          return 'Please enter Phone Number';
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

                    // Confirm Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('Confirm Password'),
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
                          return 'Please enter Confirm Password';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // Signup button
                    SizedBox(
                      width: mq.width * 0.35,
                      height: mq.height * 0.05,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              print("Password and confirm password not patch");
                            } else {
                              print('Match');
                            }

                            if (_form.currentState!.validate()) {
                              String trimemail = _emailController.text;
                              String id = trimemail.substring(
                                  0, trimemail.indexOf('@'));
                              String name = _nameController.text;
                              String email = _emailController.text;
                              String phoneNo = _phoneNoController.text;
                              String password = _passwordController.text;
                              bool exist = await MySharedPreferences()
                                  .readSharedPreferences(id);

                              if (exist == true) {
                                PopUpMenu.showFlushBarBottom(
                                    context, "User Already Exist");
                              } else {
                                await MySharedPreferences()
                                    .setSharedPreferences(
                                        id, name, email, phoneNo, password)
                                    .then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                });
                              }
                            }
                          },
                          child:
                              Text('Signup', style: TextStyle(fontSize: 15))),
                    ),

                    // login page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have any Account!",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          child: Text(
                            " Login",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage())),
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
