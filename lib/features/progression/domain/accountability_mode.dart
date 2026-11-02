/// How strictly misses are penalized (spec §3). Chosen by the user.
enum AccountabilityMode {
  gentle('Gentle', 'No XP lost for misses; Momentum still dips.'),
  balanced('Balanced', 'Misses cost half the mission\'s base XP.'),
  strict('Strict', 'Misses cost the mission\'s full base XP.');

  const AccountabilityMode(this.label, this.description);

  final String label;
  final String description;

  int xpLossForMiss(int baseXp) => switch (this) {
    gentle => 0,
    balanced => (baseXp / 2).ceil(),
    strict => baseXp,
  };

  int get momentumPenaltyPerMiss => switch (this) {
    gentle => 5,
    balanced => 10,
    strict => 15,
  };
}
