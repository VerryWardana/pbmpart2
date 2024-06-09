import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/mentor_controller.dart';
import 'package:flutter_application_1/views/admin/navbar_admin.dart';
import 'dart:io';

class TambahmentorView extends StatefulWidget {
  @override
  _TambahmentorViewState createState() => _TambahmentorViewState();
}

class _TambahmentorViewState extends State<TambahmentorView> {
  final Mentorcontroller mentorController = Mentorcontroller();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController asalController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? fotoUrl;
  File? _image;

  Future<void> _pickImage() async {
    File? pickedImage = await mentorController.pickImage();
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0E5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarAdmin()),
            );
          },
        ),
        title: const Text(
          'Tambah Mentor',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF88A65),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Isi form dibawah untuk menambah mentor dalam aplikasi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField('Nama', namaController),
              const SizedBox(height: 16),
              _buildTextField('Asal', asalController),
              const SizedBox(height: 16),
              _buildTextField('Deskripsi', deskripsiController),
              const SizedBox(height: 16),
              _buildTextField('Email', emailController),
              const SizedBox(height: 32),
              const Text(
                'Upload Foto Mentor (Wajib)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _image != null
                      ? Image.file(
                          _image!,
                          width: 50,
                          height: 50,
                        )
                      : const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF8A083),
                      textStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 358,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (namaController.text.isNotEmpty &&
                          asalController.text.isNotEmpty &&
                          deskripsiController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          _image != null) {
                        fotoUrl = await mentorController.uploadImage(
                            _image!, '${namaController.text}.png');
                        await mentorController.tambahMentor(
                          namaController.text,
                          asalController.text,
                          deskripsiController.text,
                          fotoUrl ?? '', // Use empty string if fotoUrl is null
                          emailController.text,
                        );
                        Navigator.of(context)
                            .pop(); // Navigate back after adding
                      } else {
                        // Handle the case where required fields are not filled
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Gagal'),
                              content: const Text('Mohon isi semua data'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NavbarAdmin()),
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF8A083),
                      textStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Selesai',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 382,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}
