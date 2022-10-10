import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

const List<String> list = <String>['Kucing', 'Anjing', 'Burung', 'Lainnya'];

class LaporkanKehilangan extends StatefulWidget {
  const LaporkanKehilangan({super.key});

  @override
  State<LaporkanKehilangan> createState() => _LaporkanKehilanganState();
}

class _LaporkanKehilanganState extends State<LaporkanKehilangan> {
  final namaHewanController = TextEditingController();
  final tanggalHilangController = TextEditingController();
  final waktuHilangController = TextEditingController();
  final lokasiTerakhirController = TextEditingController();
  final gambarController = TextEditingController();
  final keteranganController = TextEditingController();

  String dropdownValue = list.first;

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
            "Laporkan Kehilangan",
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
              controller: namaHewanController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nama Hewan',
                filled: true,
                labelText: 'Nama Hewan',
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
              controller: lokasiTerakhirController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Lokasi Terakhir Dilihat',
                filled: true,
                labelText: 'Lokasi Terakhir Dilihat',
                suffixIcon: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.pin_drop_outlined),
                ),
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
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<String>(
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  hint: const Text('Jenis Hewan'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: 'Pilih Jenis Hewan',
                  ),
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: TextFormField(
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              readOnly: true,
              controller: tanggalHilangController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Pilih Tanggal Kehilangan',
                filled: true,
                labelText: 'Pilih Tanggal Kehilangan',
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
                    tanggalHilangController.text =
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
              controller: waktuHilangController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Pilih Waktu Kehilangan',
                filled: true,
                labelText: 'Pilih Waktu Kehilangan',
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
                    waktuHilangController.text =
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
                hintText: 'Pilih Gambar Hewan',
                filled: true,
                labelText: 'Pilih Gambar Hewan',
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
                if (namaHewanController.text == 'daffavcd') {
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
