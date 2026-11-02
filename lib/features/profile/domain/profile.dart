import '../../council/domain/advisor.dart';
import '../../progression/domain/accountability_mode.dart';

class Profile {
  const Profile({
    this.displayName = '',
    this.mode = AccountabilityMode.balanced,
    this.areas = const [],
    this.advisor = Advisor.strategist,
    this.strictness = 2,
    this.onboarded = false,
  });

  final String displayName;
  final AccountabilityMode mode;

  /// Growth areas the user chose to develop.
  final List<String> areas;
  final Advisor advisor;

  /// Coaching strictness: 1 supportive, 2 balanced, 3 direct.
  final int strictness;
  final bool onboarded;

  Profile copyWith({
    String? displayName,
    AccountabilityMode? mode,
    List<String>? areas,
    Advisor? advisor,
    int? strictness,
    bool? onboarded,
  }) => Profile(
    displayName: displayName ?? this.displayName,
    mode: mode ?? this.mode,
    areas: areas ?? this.areas,
    advisor: advisor ?? this.advisor,
    strictness: strictness ?? this.strictness,
    onboarded: onboarded ?? this.onboarded,
  );
}
