enum VisionCategory {
  finance('Finance'),
  health('Health'),
  learning('Learning'),
  career('Career'),
  personal('Personal'),
  other('Other');

  const VisionCategory(this.label);
  final String label;
}

class Milestone {
  const Milestone({
    required this.id,
    required this.title,
    this.targetValue,
    this.completedOn,
  });

  final String id;
  final String title;
  final double? targetValue;
  final DateTime? completedOn;

  bool get isDone => completedOn != null;
}

/// A long-term goal (blueprint §4).
class Vision {
  const Vision({
    required this.id,
    required this.title,
    required this.category,
    required this.startedOn,
    required this.deadline,
    this.why,
    this.targetValue,
    this.unit,
    this.currentValue = 0,
    this.milestones = const [],
    this.ambition,
    this.completedOn,
  });

  final String id;
  final String title;
  final String? why;
  final VisionCategory category;
  final double? targetValue;
  final String? unit;
  final double currentValue;
  final DateTime startedOn;
  final DateTime deadline;
  final List<Milestone> milestones;

  /// Fixed when the vision is created so later visions can't change it.
  final double? ambition;
  final DateTime? completedOn;

  bool get isCompleted => completedOn != null;

  double get progress {
    if (isCompleted) return 1;
    if (targetValue != null && targetValue! > 0) {
      return (currentValue / targetValue!).clamp(0, 1);
    }
    if (milestones.isEmpty) return 0;
    return milestones.where((m) => m.isDone).length / milestones.length;
  }
}
