import 'package:flutter/material.dart';
import '../../../data/dummy_tasks.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/petugas_bottom_nav.dart';
import '../../widgets/petugas/petugas_page_frame.dart';
import 'petugas_notifications_page.dart';
import 'petugas_profile_page.dart';
import 'task_detail_page.dart';
import 'task_history_page.dart';
import 'task_list_page.dart';

class PetugasHomePage extends StatefulWidget {
  const PetugasHomePage({super.key});
  @override
  State<PetugasHomePage> createState() => _PetugasHomePageState();
}

class _PetugasHomePageState extends State<PetugasHomePage> {
  int _selectedIndex = 0;
  late List<Task> _activeTasks;
  late List<Task> _historyTasks;

  @override
  void initState() {
    super.initState();
    _activeTasks = DummyTasks.aktif.map((task) => task.copy()).toList();
    _historyTasks = DummyTasks.riwayat.map((task) => task.copy()).toList();
  }

  int get _completedTodayCount =>
      _historyTasks
          .where((task) => task.completedAtLabel == 'Hari ini, 08.02')
          .length;
  int get _remainingTaskCount => _activeTasks.length;

  void _startTask(Task task) {
    setState(() => task.status = TaskStatus.dalamProses);
  }

  void _completeTask(Task task) {
    setState(() {
      task.status = TaskStatus.selesai;
      task.completedAtLabel = 'Hari ini, 08.02';
      task.completedDistanceLabel = '18 m dari titik laporan';
      _activeTasks.removeWhere((item) => item.id == task.id);
      _historyTasks.insert(0, task);
    });
  }

  void _openTaskDetail(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => TaskDetailPage(
              task: task,
              onTaskStarted: _startTask,
              onTaskCompleted: _completeTask,
              getCompletedTodayCount: () => _completedTodayCount,
              getRemainingTaskCount: () => _remainingTaskCount,
            ),
      ),
    ).then((_) => setState(() {}));
  }

  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => TaskHistoryPage(
              tasks: _historyTasks,
              onBottomNavTap: (index) {
                Navigator.pop(context);
                setState(() => _selectedIndex = index);
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      TaskListPage(
        namaPetugas: 'Dedi',
        tasks: _activeTasks,
        onTaskTap: _openTaskDetail,
        onHistoryTap: _openHistory,
      ),
      const PetugasNotificationsPage(),
      const PetugasProfilePage(),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: PetugasPageFrame(
        child: SafeArea(
          bottom: false,
          child: IndexedStack(index: _selectedIndex, children: pages),
        ),
      ),
      bottomNavigationBar: PetugasPageFrame(
        child: PetugasBottomNav(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}