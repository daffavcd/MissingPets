import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './detail_laporan.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HistoryLaporan extends StatefulWidget {
  const HistoryLaporan(this.onItemTapped, this.setDetailId, {super.key});
  final void Function(int index, bool choose, bool choose2) onItemTapped;

  final void Function(String docId) setDetailId;
  @override
  State<HistoryLaporan> createState() => _HistoryLaporanState();
}

class _HistoryLaporanState extends State<HistoryLaporan> {
  final storageRef = FirebaseStorage.instance.ref();
  String _emailUser = "Unauthenticated";
  Future<String> _getImage(String imageName) async {
    final pathReference =
        await storageRef.child("petImages/$imageName").getDownloadURL();

    return pathReference;
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
        _emailUser = user.email.toString();
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
          Align(
            alignment: Alignment.center,
            child: Text(
              "History Kehilangan",
              style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('lostPets')
                  .where('userEmail', isEqualTo: _emailUser)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 35),
                    child: Text(
                      "Belum ada history kehilangan.",
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
                    Map<String, dynamic> history =
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
                              future: _getImage(history['gambar']),
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
                                  return const CircularProgressIndicator();
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
                                        "${history['namaHewan']}",
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
                                            text: " ${history['waktuHilang']}",
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
                                            text: " ${history['jenisHewan']}",
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
                                            text: " ${history['status']}",
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
