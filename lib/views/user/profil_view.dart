import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profil_controller.dart';
import 'package:flutter_application_1/models/user.dart' as model_user;
import 'package:flutter_application_1/views/user/navbar_bawah.dart';

class ProfilUser extends StatefulWidget {
  const ProfilUser({Key? key}) : super(key: key);

  @override
  _ProfilUserState createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  final ProfilController _profilController = ProfilController();
  model_user.User? _user; // Variabel _user diubah menjadi nullable
  late TextEditingController _usernameController;
  late TextEditingController _umurController;
  late String _selectedJenisKelamin = ''; // Menyimpan pilihan jenis kelamin
  final _formKey = GlobalKey<FormState>(); // Key untuk form
  bool _isLoading = true; // Variabel untuk status loading

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _umurController = TextEditingController();
    _loadUserData(); // Memuat data pengguna saat inisialisasi
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = await _profilController.getCurrentUserData();
    setState(() {
      _user = user;
      _usernameController.text = _user!.username;
      _umurController.text = _user!.umur;
      _selectedJenisKelamin = _user!.jenisKelamin; // Set jenis kelamin default
      _isLoading = false; // Data selesai dimuat
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarBawah()),
            );
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFFE87C5F),
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Menampilkan indikator loading saat data sedang dimuat
          : Center(
              child: Form(
                key: _formKey, // Menyambungkan form dengan GlobalKey
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _user!.imageUrl.isNotEmpty
                              ? NetworkImage(_user!.imageUrl)
                              : AssetImage('assets/images/Profile.png')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await _profilController.changeProfilePicture(
                                  context, _user!);
                              // Memanggil _loadUserData untuk memperbarui gambar profil setelah diubah
                              await _loadUserData();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _umurController,
                        decoration: const InputDecoration(labelText: 'Umur'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Umur tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Jenis Kelamin',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Laki-laki',
                              groupValue: _selectedJenisKelamin,
                              onChanged: (value) {
                                setState(() {
                                  _selectedJenisKelamin = value!;
                                });
                              },
                            ),
                            const Text('Laki-laki'),
                            Radio<String>(
                              value: 'Perempuan',
                              groupValue: _selectedJenisKelamin,
                              onChanged: (value) {
                                setState(() {
                                  _selectedJenisKelamin = value!;
                                });
                              },
                            ),
                            const Text('Perempuan'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Validasi sebelum menyimpan profil
                        if (_formKey.currentState!.validate()) {
                          _profilController.updateUserData(
                            _user!.id,
                            _usernameController.text,
                            _umurController.text,
                            _selectedJenisKelamin,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profil berhasil diperbarui')),
                          );
                        }
                      },
                      child: const Text('Simpan'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _profilController.logout(context);
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
