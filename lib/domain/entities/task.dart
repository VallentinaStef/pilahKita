enum TaskStatus { ditugaskan, dalamProses, selesai }

class Task {
  final String id;
  final String address;
  final String wasteType;
  final String volume;
  final String distance;
  final String description;
  TaskStatus status;
  String? completedAtLabel;
  String? completedDistanceLabel;

  Task({
    required this.id,
    required this.address,
    required this.wasteType,
    required this.volume,
    required this.distance,
    required this.description,
    required this.status,
    this.completedAtLabel,
    this.completedDistanceLabel,
  });

  bool get isCompleted => status == TaskStatus.selesai;
  bool get isInProgress => status == TaskStatus.dalamProses;

  String get statusLabel {
    switch (status) {
      case TaskStatus.ditugaskan:
        return 'Ditugaskan';
      case TaskStatus.dalamProses:
        return 'Dalam proses';
      case TaskStatus.selesai:
        return 'Selesai';
    }
  }

  Task copy() {
    return Task(
      id: id,
      address: address,
      wasteType: wasteType,
      volume: volume,
      distance: distance,
      description: description,
      status: status,
      completedAtLabel: completedAtLabel,
      completedDistanceLabel: completedDistanceLabel,
    );
  }
}