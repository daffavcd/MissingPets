import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kucingku_hilang/pages/daftar.dart';
import 'package:kucingku_hilang/pages/detail_laporan.dart';
import 'package:kucingku_hilang/pages/history_laporan.dart';
import 'package:kucingku_hilang/pages/laporkan_kehilangan.dart';
import 'package:kucingku_hilang/pages/laporkan_penemuan.dart';
import 'package:kucingku_hilang/pages/list_laporan.dart';
import 'package:kucingku_hilang/pages/masuk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late String docId;
  late Map<String, dynamic> pet;
  int _selectedIndex = 0;
  bool _isChild = false;
  bool _isChildChild = false;

  void onItemTapped(int index, bool choose, bool choose2) {
    setState(() {
      _selectedIndex = index;
      _isChild = choose;
      _isChildChild = choose2;
    });
  }

  void setDetailId(String docIdParam) {
    setState(() {
      docId = docIdParam;
    });
  }

  void setPet(Map<String, dynamic> petParam) {
    setState(() {
      pet = petParam;
    });
  }

  Widget childBody() {
    if (_selectedIndex == 0 && !_isChild && !_isChildChild) {
      return ListLaporan(onItemTapped, setDetailId);
    } else if (_selectedIndex == 0 && _isChild && !_isChildChild) {
      return DetailLaporan(onItemTapped, docId, setPet);
    } else if (_selectedIndex == 0 && _isChild && _isChildChild) {
      return LaporkanPenemuan(onItemTapped, docId, pet);
    } else if (_selectedIndex == 1 && !_isChild && !_isChildChild) {
      return HistoryLaporan(onItemTapped, setDetailId);
    } else if (_selectedIndex == 1 && _isChild && !_isChildChild) {
      return DetailLaporan(onItemTapped, docId, setPet);
    } else if (_selectedIndex == 2 && !_isChild && !_isChildChild) {
      return LaporkanKehilangan(onItemTapped);
    } else if (_selectedIndex == 3 && !_isChild && !_isChildChild) {
      return Masuk(onItemTapped);
    } else if (_selectedIndex == 3 && _isChild && !_isChildChild) {
      return Daftar(onItemTapped);
    }

    return const Text('Failed rendering.');
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: const Color.fromARGB(255, 253, 178, 148),
      useDefaultLoading: false,
      overlayOpacity: 0.4,
      overlayWidget: const Center(
        child: SpinKitWanderingCubes(
          color: Color.fromARGB(255, 255, 102, 41),
          size: 50.0,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: childBody(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
              backgroundColor: Color.fromRGBO(250, 153, 121, 1.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
              backgroundColor: Color.fromRGBO(250, 153, 121, 1.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note_outlined),
              label: 'Lapor',
              backgroundColor: Color.fromRGBO(250, 153, 121, 1.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color.fromRGBO(250, 153, 121, 1.0),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedLabelStyle: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          iconSize: 26,
          unselectedItemColor: const Color.fromRGBO(248, 217, 201, 1.0),
          selectedItemColor: const Color.fromRGBO(252, 252, 250, 1.0),
          onTap: (int index) {
            onItemTapped(index, false, false);
          },
        ),
      ),
    );
  }
}
