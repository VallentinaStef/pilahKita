# PilahKita

## Deskripsi Project

**PilahKita** adalah aplikasi mobile berbasis Flutter untuk pelaporan dan pengelolaan sampah di lingkungan permukiman. Aplikasi ini menghubungkan tiga peran pengguna dalam satu alur kerja:

- **Warga** melaporkan tumpukan sampah lengkap dengan foto, kategori, estimasi volume, dan lokasi.
- **Pengelola** memeriksa laporan yang masuk, memutuskan valid atau tidaknya laporan, menugaskannya ke petugas, dan memantau seluruh laporan lewat peta serta dashboard.
- **Petugas Kebersihan** menerima penugasan, menuju lokasi, lalu menyelesaikan tugas dengan bukti foto setelah pembersihan.

Dengan alur ini, setiap laporan sampah dapat dilacak dari saat dikirim sampai selesai ditangani.

## Fitur Utama

1. **Autentikasi dan Hak Akses**: Menyediakan registrasi dan login serta membedakan akses Warga, Petugas Kebersihan, dan Pengelola.
2. **Pelaporan Sampah**: Memungkinkan warga mengirim foto, kategori, estimasi volume, deskripsi tambahan, dan lokasi sampah.
3. **Kamera dan Galeri**: Memungkinkan pengambilan foto melalui kamera atau pemilihan gambar dari galeri sesuai kebutuhan fitur.
4. **Peta dan Reverse Geocoding**: Menampilkan titik laporan dan informasi alamat atau nama jalan berdasarkan koordinat jika layanan tersedia.
5. **Validasi dan Penugasan**: Memungkinkan pengelola menerima atau menolak laporan serta menugaskan laporan valid kepada petugas.
6. **Daftar Tugas Petugas**: Menampilkan tugas yang ditugaskan kepada petugas beserta detail dan prioritasnya.
7. **Navigasi dan Validasi GPS**: Membantu petugas menuju lokasi serta memvalidasi kedekatan lokasi sebelum penyelesaian tugas diterima.
8. **Bukti Penyelesaian**: Mewajibkan foto kondisi setelah pembersihan melalui kamera aplikasi.
9. **Status dan Notifikasi**: Menampilkan perkembangan laporan serta mengirim notifikasi berdasarkan perubahan status dan penugasan.
10. **Peta Pemantauan**: Menampilkan laporan aktif dan selesai dengan filter status dan kategori.
11. **Dashboard Analitik**: Menampilkan jumlah laporan, komposisi kategori sampah, dan tren penyelesaian laporan.
12. **Ekspor Rekapitulasi**: Menghasilkan rekapitulasi laporan ke PDF atau CSV dan menyimpannya ke perangkat Pengelola.

## Anggota Kelompok

| No | Nama                | NIM                 | Peran               |
| -- | ------------------- | ------------------- | ------------------- |
| 1  | Azzhara Putri Puji Susanti    | 103022400015     | 	Mengembangkan fitur login, register, profil warga dan petugas, edit profil, riwayat aktivitas, serta pengelolaan akun petugas.   |
| 2  | Dwi Rizki Indriyanti    | 103022430013     | Mengembangkan fitur pelaporan sampah, upload foto, pengambilan lokasi GPS, pemilihan lokasi pada peta, serta peta pemantauan pengelola.   |
| 3  | Nadhifah Eka Chairunnisa    | 103022400028     | Mengembangkan beranda warga, riwayat laporan, detail laporan berdasarkan status, serta sistem notifikasi untuk warga dan petugas.   |
| 4  | Raka Putra Pratama    | 103022400077     | Mengembangkan fitur daftar tugas petugas, detail dan navigasi tugas, validasi lokasi GPS, upload foto bukti pengambilan, serta pembaruan status tugas.   |
| 5  | Stefhanie Valentina    | 103022400002     | Mengembangkan dashboard pengelola, daftar dan detail laporan, penugasan petugas, pengelolaan status laporan, pencarian, filter, serta ekspor rekapitulasi PDF/CSV.   |