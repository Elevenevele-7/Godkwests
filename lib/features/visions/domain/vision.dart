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

  Vision copyWith({
    String? title,
    String? why,
    VisionCategory? category,
    double? targetValue,
    String? unit,
    double? currentValue,
    DateTime? startedOn,
    DateTime? deadline,
    List<Milestone>? milestones,
    double? ambition,
    DateTime? completedOn,
  }) => Vision(
    id: id,
    title: title ?? this.title,
    why: why ?? this.why,
    category: category ?? this.category,
    targetValue: targetValue ?? this.targetValue,
    unit: unit ?? this.unit,
    currentValue: currentValue ?? this.currentValue,
    startedOn: startedOn ?? this.startedOn,
    deadline: deadline ?? this.deadline,
    milestones: milestones ?? this.milestones,
    ambition: ambition ?? this.ambition,
    completedOn: completedOn ?? this.completedOn,
  );

  double get progress {
    if (isCompleted) return 1;
    if (targetValue != null && targetValue! > 0) {
      return (currentValue / targetValue!).clamp(0, 1);
    }
    if (milestones.isEmpty) return 0;
    return milestones.where((m) => m.isDone).length / milestones.length;
  }
}
