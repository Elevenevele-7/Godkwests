import 'advisor.dart';

/// Facts the daily insight is chosen from. Contains no money amounts.
class InsightFacts {
  const InsightFacts({
    required this.momentum,
    required this.missionsLeft,
    required this.missionsTotal,
    required this.bestStreak,
    this.budgetOver = false,
    this.recoveringHabit,
    this.evolveHabit,
  });

  final int momentum;
  final int missionsLeft;
  final int missionsTotal;
  final int bestStreak;
  final bool budgetOver;
  final String? recoveringHabit;
  final String? evolveHabit;
}

/// Today's Council insight: a short, original line in the advisor's voice,
/// picked by rules from the user's own data. Works offline.
String dailyInsight(Advisor advisor, InsightFacts f) {
  final topic = f.budgetOver
      ? _Topic.budget
      : f.recoveringHabit != null
      ? _Topic.recovery
      : f.evolveHabit != null
      ? _Topic.evolve
      : f.missionsTotal == 0
      ? _Topic.start
      : f.missionsLeft == 0
      ? _Topic.done
      : f.momentum < 40
      ? _Topic.low
      : _Topic.steady;

  final habit = f.recoveringHabit ?? f.evolveHabit ?? '';
  return switch ((advisor, topic)) {
    (Advisor.rebel, _Topic.low) =>
      'Excuses are comfortable. Pick one mission and finish it before you '
          'scroll anything.',
    (Advisor.rebel, _Topic.recovery) =>
      '"$habit" slipped. So what. Three days in a row and it\'s yours again.',
    (Advisor.rebel, _Topic.evolve) =>
      'You\'ve outgrown "$habit". Staying comfortable is a choice too.',
    (Advisor.strategist, _Topic.low) =>
      'Shrink the system until it\'s easy to repeat, then grow it.',
    (Advisor.strategist, _Topic.budget) =>
      'Spending ran ahead of plan. Find the one category that leaked and '
          'fix that, not everything.',
    (Advisor.strategist, _Topic.evolve) =>
      'Your "$habit" data shows a stable base. A measured step up is low '
          'risk now.',
    (Advisor.boss, _Topic.steady) =>
      'You made ${f.missionsTotal} promises to yourself today. Keep them.',
    (Advisor.boss, _Topic.done) =>
      'Every mission done. That\'s what keeping your word looks like.',
    (Advisor.philosopher, _Topic.done) =>
      'You are what you repeatedly do. Today you did the work.',
    (Advisor.philosopher, _Topic.low) =>
      'A slow season is still a season. Begin again, gently, today.',
    (Advisor.psychologist, _Topic.recovery) =>
      'A miss isn\'t a verdict on you. Notice what got in the way of '
          '"$habit", then make it easier.',
    (Advisor.psychologist, _Topic.low) =>
      'Low momentum often means the plan is too big for your current '
          'energy. Make tomorrow smaller.',
    (Advisor.financialMentor, _Topic.budget) =>
      'Over budget this week. Pause the fun spending and let essentials '
          'carry you to Sunday.',
    (Advisor.financialMentor, _) =>
      'Small, steady saving beats occasional big gestures. Log today\'s '
          'spending before bed.',
    (Advisor.commander, _Topic.low) =>
      'Hard stretch. Do the smallest mission now. Report back tomorrow.',
    (Advisor.commander, _Topic.steady) =>
      '${f.missionsLeft} mission${f.missionsLeft == 1 ? '' : 's'} left. '
          'Finish them before the day finishes you.',
    (Advisor.negotiator, _Topic.evolve) =>
      'Every negotiation starts with yourself. Ask for a little more from '
          '"$habit".',
    (Advisor.negotiator, _) =>
      'Confidence is built from kept agreements, and today\'s missions are '
          'agreements.',
    (_, _Topic.start) =>
      'Add your first habit. A system you can repeat beats a perfect plan.',
    (_, _Topic.done) => 'Missions complete. Rest is part of the system too.',
    (_, _Topic.budget) =>
      'Spending is ahead of plan this week. Check your allowance before '
          'the next purchase.',
    (_, _Topic.recovery) =>
      'Recovery challenge on "$habit": three days in a row restores your '
          'momentum.',
    (_, _Topic.evolve) =>
      'You\'re ready for a harder "$habit". Check the Missions tab.',
    (_, _) => 'Build a system that makes the right decision easier to repeat.',
  };
}

enum _Topic { start, done, low, steady, budget, recovery, evolve }
