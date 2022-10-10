import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailLaporan extends StatefulWidget {
  const DetailLaporan({super.key});

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  final _formKey = GlobalKey<FormState>();

  final cariController = TextEditingController();

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
                Card(
                  margin: EdgeInsets.only(bottom: 25),
                  elevation: 8,
                  shadowColor: Color.fromRGBO(246, 157, 123, 1.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Sultan Pangkumlorot 1',
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
                                  text: " 18 Juni 2023",
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
                                  text: " Disebelah ayunan, Malang",
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
                                  text: " Anjing",
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
                                  text: " Belum Ditemukan",
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
                            "He'll want to use your yacht, and I don't want this thing smelling like fish  lorem11.",
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(246, 157, 123, 1.0),
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
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
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Status berhasil dirubah.'),
                                      ),
                                    );
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: Text(
                                    'Iya',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(246, 157, 123, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: const Text('Hewanku Telah Ditemukan!'),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 30.0),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor:
                      //           const Color.fromRGBO(246, 157, 123, 1.0),
                      //       minimumSize: const Size.fromHeight(50), // NEW
                      //     ),
                      //     onPressed: () => showDialog<String>(
                      //       context: context,
                      //       builder: (BuildContext context) => AlertDialog(
                      //         title: Text(
                      //           'Konfirmasi Perubahan?',
                      //           style: GoogleFonts.poppins(
                      //             textStyle: const TextStyle(
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 22,
                      //               color: Colors.black87,
                      //             ),
                      //           ),
                      //         ),
                      //         content: Text(
                      //           'Apakah hewan anda benar-benar telah ditemukan?',
                      //           style: GoogleFonts.poppins(
                      //             textStyle: const TextStyle(
                      //               fontWeight: FontWeight.normal,
                      //               fontSize: 18,
                      //               color: Colors.black87,
                      //             ),
                      //           ),
                      //         ),
                      //         actions: <Widget>[
                      //           TextButton(
                      //             onPressed: () =>
                      //                 Navigator.pop(context, 'Cancel'),
                      //             child: Text(
                      //               'Cancel',
                      //               style: GoogleFonts.poppins(
                      //                 textStyle: const TextStyle(
                      //                   fontWeight: FontWeight.normal,
                      //                   fontSize: 15,
                      //                   color: Colors.black87,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           TextButton(
                      //             onPressed: () {
                      //               ScaffoldMessenger.of(context).showSnackBar(
                      //                 const SnackBar(
                      //                   content:
                      //                       Text('Status berhasil dirubah.'),
                      //                 ),
                      //               );
                      //               Navigator.pop(context, 'OK');
                      //             },
                      //             child: Text(
                      //               'OK',
                      //               style: GoogleFonts.poppins(
                      //                 textStyle: const TextStyle(
                      //                   fontWeight: FontWeight.normal,
                      //                   fontSize: 15,
                      //                   color:
                      //                       Color.fromRGBO(246, 157, 123, 1.0),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     child: const Text('Buat Laporan Penemuan!'),
                      //   ),
                      // ),
                      // IF ELSE IS USER = ID USER
                    ],
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
