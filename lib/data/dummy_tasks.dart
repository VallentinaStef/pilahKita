import '../domain/entities/task.dart';

class DummyTasks {
  DummyTasks._();

  static final List<Task> aktif = [
    Task(
      id: 'PK-0412',
      address: 'Jl. Dipatiukur No. 35',
      wasteType: 'Anorganik',
      volume: 'Besar',
      distance: '1,2 km',
      description: 'Sampah anorganik dengan volume besar perlu dibersihkan.',
      status: TaskStatus.dalamProses,
    ),
    Task(
      id: 'PK-0415',
      address: 'Jl. Cihampelas No. 8',
      wasteType: 'Campuran',
      volume: 'Sedang',
      distance: '2,6 km',
      description: 'Tumpukan sampah campuran dengan volume sedang.',
      status: TaskStatus.ditugaskan,
    ),
    Task(
      id: 'PK-0417',
      address: 'Taman Lansia',
      wasteType: 'Organik',
      volume: 'Kecil',
      distance: '3,1 km',
      description: 'Sampah organik dengan volume kecil di area taman.',
      status: TaskStatus.ditugaskan,
    ),
  ];

  static final List<Task> riwayat = [
    Task(
      id: 'PK-0398',
      address: 'Pasar Kosambi',
      wasteType: 'Organik',
      volume: 'Kecil',
      distance: '18 m',
      description: 'Pembersihan area Pasar Kosambi telah selesai.',
      status: TaskStatus.selesai,
      completedAtLabel: '28 Okt, 16.02',
      completedDistanceLabel: '18 m dari titik laporan',
    ),
    Task(
      id: 'PK-0391',
      address: 'Jl. Riau No. 40',
      wasteType: 'Anorganik',
      volume: 'Sedang',
      distance: '22 m',
      description: 'Pembersihan sampah anorganik telah selesai.',
      status: TaskStatus.selesai,
      completedAtLabel: '26 Okt',
      completedDistanceLabel: '22 m dari titik laporan',
    ),
    Task(
      id: 'PK-0384',
      address: 'Gg. Mawar',
      wasteType: 'Campuran',
      volume: 'Sedang',
      distance: '15 m',
      description: 'Pembersihan area Gang Mawar telah selesai.',
      status: TaskStatus.selesai,
      completedAtLabel: '24 Okt',
      completedDistanceLabel: '15 m dari titik laporan',
    ),
    Task(
      id: 'PK-0377',
      address: 'Taman Lansia',
      wasteType: 'Organik',
      volume: 'Kecil',
      distance: '20 m',
      description: 'Pembersihan sampah organik di Taman Lansia telah selesai.',
      status: TaskStatus.selesai,
      completedAtLabel: '22 Okt',
      completedDistanceLabel: '20 m dari titik laporan',
    ),
  ];
}