import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kucingku_hilang/pages/detail_laporan.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ListLaporan extends StatefulWidget {
  const ListLaporan(this.onItemTapped, this.setDetailId, {super.key});
  final void Function(int index, bool choose, bool choose2) onItemTapped;
  final void Function(String docId) setDetailId;

  @override
  State<ListLaporan> createState() => _ListLaporanState();
}

class _ListLaporanState extends State<ListLaporan> {
  final _formKey = GlobalKey<FormState>();
  final cariController = TextEditingController();

  Stream<QuerySnapshot> _petsStream =
      FirebaseFirestore.instance.collection('lostPets').snapshots();
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> _getImage(String imageName) async {
    final pathReference =
        await storageRef.child("petImages/$imageName").getDownloadURL();

    return pathReference;
  }

  Future<void> findQueryPet(String query) async {
    // _petsStream = FirebaseFirestore.instance
    //     .collection('lostPets')
    //     .where('namaHewan', isGreaterThanOrEqualTo: query)
    //     .where('namaHewan', isLessThan: '${query}z')
    //     .snapshots();
    setState(() {
      _petsStream = FirebaseFirestore.instance
          .collection('lostPets')
          .orderBy('namaHewan')
          .startAt([query]).endAt(['$query\uf8ff']).snapshots();
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
            "Laporan Kehilangan",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              child: TextFormField(
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                onChanged: (value) {
                  findQueryPet(value);
                },
                enableSuggestions: false,
                autocorrect: false,
                controller: cariController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    iconSize: 28,
                    color: const Color.fromRGBO(246, 157, 123, 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Color.fromRGBO(246, 157, 123, 1.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 255, 100, 39),
                    ),
                  ),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _petsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 35),
                    child: Text(
                      "Currently no data is available.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        widget.setDetailId(document.id);
                        widget.onItemTapped(0, true, false);
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 25),
                        elevation: 8,
                        shadowColor: const Color.fromRGBO(246, 157, 123, 1.0),
                        child: Column(
                          children: <Widget>[
                            FutureBuilder(
                              future: _getImage(data['gambar']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  return Container(
                                    height: 280,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        topRight: Radius.circular(3),
                                      ),
                                      color: Color.fromARGB(255, 240, 240, 240),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 11),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        "${data['namaHewan']}",
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.calendar_today,
                                              size: 20,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " ${data['waktuHilang']}",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.pets,
                                              size: 20,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " ${data['jenisHewan']}",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.info_outline,
                                              size: 20,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " ${data['status']}",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
