import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kucingku_hilang/pages/daftar.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Masuk extends StatefulWidget {
  const Masuk(this.onItemTapped, {super.key});
  final void Function(int index, bool choose, bool choose2) onItemTapped;

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  final _formKey = GlobalKey<FormState>();
  var _isuser = false;
  var _emailUser;
  var myUser;
  var pagesName = 'Masuk';

  final namaController = TextEditingController();
  final asalKotaController = TextEditingController();
  final noTeleponController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        myUser = user;
        _emailUser = user.email;
        _isuser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          // IF ELSE IS AUTHENTICATED
          _isuser
              ? Text(
                  "Authenticated",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                )
              : Text(
                  pagesName,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          // IF ELSE IS AUTHENTICATED
          _isuser
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                // text: 'Selamat Datang, ',
                                text: 'Selamat Datang, $_emailUser',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 102, 41),
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () async {
                          context.loaderOverlay.show();
                          await FirebaseAuth.instance.signOut();
                          context.loaderOverlay.hide();
                          if (!mounted) return;

                          setState(() {
                            _isuser = false;
                            _emailUser = null;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Signing Out Success')),
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 11),
                        child: TextFormField(
                          style: GoogleFonts.poppins(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.normal),
                          ),
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            filled: true,
                            labelText: 'Email',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => validateEmail(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 11),
                        child: TextFormField(
                          style: GoogleFonts.poppins(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.normal),
                          ),
                          obscureText: _obscureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                _toggle();
                              },
                              icon: const Icon(Icons.remove_red_eye),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            filled: true,
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (pagesName == 'Masuk')
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pagesName = 'Daftar';
                            });
                            emailController.text = '';
                            passwordController.text = '';
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Belum punya akun? Daftar',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.blue[500],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(246, 157, 123, 1.0),
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (pagesName == 'Masuk') {
                                try {
                                  context.loaderOverlay.show();
                                  final UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);

                                  setState(() {
                                    myUser = userCredential.user;
                                    _emailUser = emailController.text;
                                    _isuser = true;
                                  });

                                  if (!mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Login Success')),
                                  );

                                  context.loaderOverlay.hide();
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'No user found for that email.')));
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Wrong password provided for that user.')));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                try {
                                  context.loaderOverlay.show();
                                  final UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);

                                  context.loaderOverlay.hide();
                                  log(userCredential.toString());

                                  setState(() {
                                    myUser = userCredential;
                                    _emailUser = emailController.text;
                                    _isuser = true;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Register Success')),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'The password provided is too weak.')));
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'The account already exists for that email.')));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
