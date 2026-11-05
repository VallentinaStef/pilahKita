import 'package:flutter/material.dart';

class KelolaPetugasPage extends StatefulWidget {
  const KelolaPetugasPage({super.key});

  @override
  State<KelolaPetugasPage> createState() => _KelolaPetugasPageState();
}

class _KelolaPetugasPageState extends State<KelolaPetugasPage> {
  final List<Map<String, dynamic>> petugas = [
    {
      'nama': 'Budi Santoso',
      'email': 'budi@petugas.pilahkita.com',
      'hp': '081234567890',
      'aktif': true,
    },
    {
      'nama': 'Siti Rahma',
      'email': 'siti@petugas.pilahkita.com',
      'hp': '082345678901',
      'aktif': true,
    },
  ];

  void tambahPetugas() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormPetugasPage()),
    );

    if (hasil != null) {
      setState(() {
        petugas.add(hasil);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Petugas berhasil ditambahkan')),
      );
    }
  }

  void editPetugas(int index) async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPetugasPage(data: petugas[index]),
      ),
    );

    if (hasil != null) {
      setState(() {
        petugas[index] = hasil;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data petugas berhasil diperbarui')),
      );
    }
  }

  void nonaktifkan(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nonaktifkan Petugas?'),
          content: Text(
            'Apakah Anda yakin ingin menonaktifkan ${petugas[index]['nama']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  petugas[index]['aktif'] = false;
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Petugas berhasil dinonaktifkan'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF104B37),
                foregroundColor: Colors.white,
              ),
              child: const Text('Nonaktifkan'),
            ),
          ],
        );
      },
    );
  }

  void aktifkan(int index) {
    setState(() {
      petugas[index]['aktif'] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Petugas berhasil diaktifkan kembali')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Kelola Petugas'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: petugas.length,
        itemBuilder: (context, index) {
          final data = petugas[index];
          final aktif = data['aktif'] as bool;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFB7F34A),
                        child: Icon(Icons.person, color: Color(0xFF104B37)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['nama'],
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data['email'],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              aktif
                                  ? const Color(0xFFEAF4E4)
                                  : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          aktif ? 'Aktif' : 'Nonaktif',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                aktif
                                    ? const Color(0xFF104B37)
                                    : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    'No. HP: ${data['hp']}',
                    style: const TextStyle(fontSize: 13),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => editPetugas(index),
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              aktif
                                  ? () => nonaktifkan(index)
                                  : () => aktifkan(index),
                          icon: Icon(
                            aktif
                                ? Icons.block_outlined
                                : Icons.check_circle_outline,
                          ),
                          label: Text(aktif ? 'Nonaktifkan' : 'Aktifkan'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF104B37),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tambahPetugas,
        backgroundColor: const Color(0xFFB7F34A),
        foregroundColor: const Color(0xFF104B37),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormPetugasPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const FormPetugasPage({super.key, this.data});

  @override
  State<FormPetugasPage> createState() => _FormPetugasPageState();
}

class _FormPetugasPageState extends State<FormPetugasPage> {
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController hpController;

  @override
  void initState() {
    super.initState();

    namaController = TextEditingController(text: widget.data?['nama'] ?? '');

    emailController = TextEditingController(text: widget.data?['email'] ?? '');

    hpController = TextEditingController(text: widget.data?['hp'] ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    super.dispose();
  }

  void simpan() {
    if (namaController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        hpController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua data wajib diisi')));
      return;
    }

    Navigator.pop(context, {
      'nama': namaController.text.trim(),
      'email': emailController.text.trim(),
      'hp': hpController.text.trim(),
      'aktif': widget.data?['aktif'] ?? true,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.data != null;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: Text(isEdit ? 'Edit Petugas' : 'Tambah Petugas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 18),

            TextField(
              controller: hpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7F34A),
                  foregroundColor: const Color(0xFF104B37),
                ),
                child: Text(
                  isEdit ? 'Simpan Perubahan' : 'Tambah Petugas',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
