import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

class LaporkanPenemuan extends StatefulWidget {
  const LaporkanPenemuan({super.key});

  @override
  State<LaporkanPenemuan> createState() => _LaporkanPenemuanState();
}

class _LaporkanPenemuanState extends State<LaporkanPenemuan> {
  final lokasiTerakhirController = TextEditingController();
  final tanggalDilihatController = TextEditingController();
  final waktuDilihatController = TextEditingController();
  final gambarController = TextEditingController();
  final keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Text(
            "Laporkan Penemuan",
            style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextFormField(
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              enableSuggestions: false,
              autocorrect: false,
              controller: lokasiTerakhirController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Lokasi Terakhir Dilihat',
                filled: true,
                labelText: 'Lokasi Terakhir Dilihat',
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextFormField(
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              readOnly: true,
              controller: tanggalDilihatController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Pilih Tanggal Dilihat',
                filled: true,
                labelText: 'Pilih Tanggal Dilihat',
                suffixIcon: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.calendar_today),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  log(pickedDate
                      .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  log(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    tanggalDilihatController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  log("Date is not selected");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextFormField(
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              readOnly: true,
              controller: waktuDilihatController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Pilih Waktu Dilihat',
                filled: true,
                labelText: 'Pilih Waktu Dilihat',
                suffixIcon: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.access_time),
                ),
              ),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (!mounted) return;

                if (pickedTime != null) {
                  log(pickedTime.toString());

                  String formatedTime = pickedTime.format(context);

                  setState(() {
                    waktuDilihatController.text =
                        formatedTime; //set output date to TextField value.
                  });
                } else {
                  log("Time is not selected");
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextFormField(
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              readOnly: true,
              controller: gambarController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Pilih Gambar Penemuan',
                filled: true,
                labelText: 'Pilih Gambar Penemuan',
                suffixIcon: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.image),
                ),
              ),
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image);

                if (result != null) {
                  PlatformFile file = result.files.first;
                  setState(() {
                    gambarController.text = file.name;
                  });

                  // File file = File(result.files.single.path);
                } else {
                  // User canceled the picker
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextFormField(
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: keteranganController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Keterangan',
                filled: true,
                labelText: 'Keterangan',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(246, 157, 123, 1.0),
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {
                if (lokasiTerakhirController.text == 'daffavcd') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You are Autorized.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect Pin.')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
