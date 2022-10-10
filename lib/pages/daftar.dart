import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Text(
            "Daftar",
            style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
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
                      controller: namaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nama',
                        filled: true,
                        labelText: 'Nama',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: asalKotaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Asal Kota',
                        filled: true,
                        labelText: 'Asal Kota',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: noTeleponController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            '+62 ',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'No Telepon',
                        filled: true,
                        labelText: 'No Telepon',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(246, 157, 123, 1.0),
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
