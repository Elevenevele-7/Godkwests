# Scoring Specification

Agreed with the product owner on 2026-11-02. All numbers live in one file, `lib/features/progression/domain/scoring_rules.dart`, so they can be tuned without touching the logic. Every rule below has unit tests in `test/features/progression/`.

General conventions:
- The week starts on **Monday**; days use the device's local date.
- Rounding means "to the nearest whole number, halves round up", unless stated otherwise.
- A **scheduled day** is a day a habit is planned for (for example, a Mon/Wed/Fri habit isn't scheduled on Tuesday).
- A **miss** is a scheduled day that has passed without completion and wasn't excused. Today doesn't count as a miss until it's over.

## 1. XP for completing a mission

```
xp = round(baseXp × multiplier)
multiplier = 1 + streakBonus + momentumBonus + visionBonus      (max 3.0)

baseXp         1–5, set by the habit's difficulty
streakBonus    0.04 per day of the habit's current streak, max 1.0 (reached at 25 days)
momentumBonus  0.5 × Momentum ÷ 100
visionBonus    0.5 if the habit is linked to an active vision, else 0
```

Anti-grinding:
- A habit earns XP **at most once per scheduled day**.
- **Soft cap:** from the 9th mission completed in a day, XP is halved.
- **New habits:** during the first 3 days after a habit is created, XP is halved.
- The halvings stack, but a completed mission always earns **at least 1 XP**.

**Example: "Read 20 pages" (base 2)**
| Situation | Multiplier | XP |
| --- | --- | --- |
| Day 1, not linked, Momentum 0 | 1.0 | 2 |
| 10-day streak, linked, Momentum 60 | 1 + 0.40 + 0.30 + 0.5 = 2.2 | 4 |
| 30-day streak, linked, Momentum 100 | 1 + 1.0 + 0.5 + 0.5 = 3.0 | 6 |

## 2. Levels

```
XP needed to go from level L to L+1 = round(20 × 1.12^(L−1))
```

Level 1 starts at 0 XP. **Levels can go down:** the level is always calculated from total XP, and total XP never goes below 0.

| Level | XP for the next level | Total XP to reach this level |
| --- | --- | --- |
| 1 | 20 | 0 |
| 2 | 22 | 20 |
| 5 | 31 | 95 |
| 10 | 55 | 294 |
| 20 | 172 | 1,267 |

(The tests check these values.)

## 3. Missed missions (penalties)

The penalty depends on the user's accountability mode:

| Mode | XP lost per miss | Momentum penalty per miss |
| --- | --- | --- |
| Gentle | 0 | 5 |
| Balanced (default) | ceil(base ÷ 2) | 10 |
| Strict | base | 15 |

- Every penalty is recorded with a plain-language explanation shown to the user.
- **Pattern:** 3 or more misses of the same habit in the last 7 days raises a pattern flag and offers a **recovery challenge**: complete that habit on 3 scheduled days in a row.
- **Recovery reward:** the pattern's misses stop counting against Momentum, and the user earns a **+2 XP** recovery bonus.

## 4. Excused days

Users can mark a day as **excused** (reason: sick, travel, emergency, other) with an optional note.

- An excused day has no XP or Momentum penalty, and **streaks pause instead of breaking**.
- Each user has **4 excuses per calendar month**. From the 5th, the streak still pauses, but the normal miss penalties apply.

## 5. Streak

A habit's streak is the number of consecutive **scheduled** days it was completed, counting back from today. Unscheduled days and excused days are skipped. A miss resets the streak to 0. If today is scheduled but not done yet, the streak counts from yesterday.

## 6. Momentum (0–100)

```
completionRate = Σ(weight × completed) ÷ Σ(weight × scheduled)    over the last 7 days
                 weight: today 7, yesterday 6, … 6 days ago 1
Momentum       = clamp(round(100 × completionRate) − Σ penaltyPerMiss, 0, 100)
```

Only unexcused misses in the last 7 days, not forgiven by a recovery, count toward the penalty sum. Excused days are left out entirely. A user with nothing scheduled in the window has Momentum 0.

## 7. Discipline Score (0–100)

The percentage of scheduled habit-days completed over the **last 30 days**, leaving out excused days.

*(The Integrity Score was removed: the app can't verify self-reported tasks, so a separate integrity measure would be misleading.)*

## 8. Discipline Points (DP)

DP are rare, and they're never taken away. They're awarded for:
- **Streak milestones:** +1 DP when any habit's streak reaches 7, 30, 100 or 365 days (once per habit per milestone).
- **Perfect week:** +1 DP for completing every scheduled mission from Monday to Sunday (excused days left out, at least one mission scheduled).
- **Evolve success:** +1 DP for holding an evolved target at 90% or higher completion for 14 days after evolving.

## 9. Challenge & Evolution

- **Offer:** a habit at least 14 days old, completed on 90% or more of its scheduled days in the last 14 days, is offered **Evolve**: target × 1.5 (rounded up) and base XP + 1 (max 5).
- **Declined:** the offer is shown again after 14 days.
- **Struggling:** if completion is below 60% in the 7 days after evolving, the app offers to step back to the previous target and XP, with no penalty.

## 10. Vision Points (VP)

```
visionVp = 10 × monthsPlanned (min 1) × ambition
ambition = 1.0  first vision in this category
           1.5  target above the best completed vision in the same category (same unit)
           0.5  target at or below a completed vision in the same category (a repeat)

each milestone        = round(visionVp ÷ (milestones + 1))
completing the vision = visionVp − milestone VP already awarded
on-time bonus         = round(25% × visionVp) if completed on or before the deadline
```

VP are permanent and never taken away. Categories: finance, health, learning, career, personal, other.

**Example:** emergency fund, KSh 100,000, 6 months, first finance vision: 10 × 6 × 1.0 = **60 VP**, +15 if on time. The next one, KSh 200,000 over 6 months: 10 × 6 × 1.5 = **90 VP**.

## 11. Finance

Settings (weekly, Monday to Sunday): essentials budget, fun budget, daily savings target, and finance penalties on or off (off by default).

```
daysLeft         = days remaining in the week, including today
dailyAllowance   = (essentials + fun budget − spent this week) ÷ daysLeft
funToday         = (fun budget − fun spent this week) ÷ daysLeft
status           = "On track" if spent ≤ budget × (days elapsed ÷ 7), "Over pace" if above,
                   "Over budget" if spent > budget
```

- **Daily outcome:** a day where spending stays within that day's allowance earns **+1 XP**. Only this outcome leaves the device; the amounts are encrypted (see [database.md](database.md)).
- **Overspend penalty (opt-in only):** fun overspend reduces next week's fun budget by the overspent amount, but never below 50% of the normal fun budget. Essentials and savings are never touched.
- **Recovery:** staying within the reduced budget for that whole week earns **+2 XP**, and the normal budget returns.

## 12. Identity Progress and Life Score

- The user picks growth areas (for example Discipline, Financial responsibility, Lifelong learning, Health). Each habit is tagged with one area.
- **Area progress** = completion rate of that area's habits over the last 30 days. **Financial responsibility** = the share of the last 30 days spent within the daily allowance.
- **Life Score** = the average of the user's chosen areas. There's no universal definition of success: only the areas the user chose count.
