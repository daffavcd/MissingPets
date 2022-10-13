import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kucingku_hilang/pages/laporkan_penemuan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DetailLaporan extends StatefulWidget {
  const DetailLaporan(this.onItemTapped, this.docId, this.setPet, {super.key});
  final void Function(int index, bool choose, bool choose2) onItemTapped;

  final String docId;

  final void Function(Map<String, dynamic> pet) setPet;

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  var _isuser = false;
  var _emailUser;

  CollectionReference lostPet =
      FirebaseFirestore.instance.collection('lostPets');

  final storageRef = FirebaseStorage.instance.ref();

  Future<String> _getImage(String imageName) async {
    final pathReference =
        await storageRef.child("petImages/$imageName").getDownloadURL();

    return pathReference;
  }

  Future<void> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _isuser = true;
        _emailUser = user.email;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
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
            "Detail Kehilangan",
            style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              children: <Widget>[
                FutureBuilder<DocumentSnapshot>(
                  future: lostPet.doc(widget.docId).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return Card(
                        margin: EdgeInsets.only(bottom: 25),
                        elevation: 8,
                        shadowColor: Color.fromRGBO(246, 157, 123, 1.0),
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
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          snapshot.data!,
                                        ),
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
                                  horizontal: 10, vertical: 5),
                              child: Align(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Align(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(
                                          Icons.pin_drop_outlined,
                                          size: 20,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " ${data['lokasiTerakhir']}",
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Align(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Align(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${data['keterangan']}",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "~ List Laporan Penemuan ~",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
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
                            ),
                            // IF ELSE IS THERE IS PENEMUAN?
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Container(
                                child: Text(
                                  'Sejauh ini belum ada penemuan.',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // IF ELSE IS USER = ID USER
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 30.0),
                              child: _emailUser == data['userEmail']
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            246, 157, 123, 1.0),
                                        minimumSize:
                                            const Size.fromHeight(50), // NEW
                                      ),
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                            'Konfirmasi Perubahan?',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          content: Text(
                                            'Apakah hewan anda benar-benar telah ditemukan?',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                widget.onItemTapped(
                                                    1, false, false);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Status berhasil dirubah.'),
                                                  ),
                                                );
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: Text(
                                                'Iya',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                    color: Color.fromRGBO(
                                                        246, 157, 123, 1.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: const Text(
                                          'Hewanku Telah Ditemukan!'),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            246, 157, 123, 1.0),
                                        minimumSize:
                                            const Size.fromHeight(50), // NEW
                                      ),
                                      onPressed: () {
                                        if (!_isuser) {
                                          widget.onItemTapped(3, false, false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Silahkan login terlebih dahulu.')),
                                          );
                                        } else {
                                          widget.setPet(data);
                                          widget.onItemTapped(0, true, true);
                                        }
                                      },
                                      child:
                                          const Text('Buat Laporan Penemuan!'),
                                    ),
                            ),
                            // IF ELSE IS USER = ID USER
                          ],
                        ),
                      );
                    }

                    return Text("loading");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
