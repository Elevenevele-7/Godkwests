# The Complete App Blueprint

We're building a personalized personal-growth app that combines habit tracking, financial discipline, goal achievement, education and AI coaching in one system.

> You choose who you want to become. The system helps you become that person and shows you how far you've come.

The app should be strict enough to encourage accountability, flexible enough to respect individual goals, and intelligent enough to adapt as users grow.

## 1. The core systems

### 1.1 Habit & Discipline System
Tracks daily routines, good habits, unwanted habits, streaks, consistency and task completion.
- Personalized daily missions.
- Difficulty levels that adapt as users improve.
- Discipline Score. *(Integrity Score removed 2026-11-02: self-reported tasks cannot be verified.)*
- Penalties for missed commitments, with recovery paths.

### 1.2 Financial Discipline System
A dedicated budgeting and savings engine that connects financial decisions to the user's goals.
- Weekly and daily budgets.
- Separate essential spending and entertainment allowances.
- Savings goals and progress tracking.
- Optional penalties that reduce future discretionary allowances.
- Rewards for reaching financial targets.
- Financial accountability settings controlled by the user.

### 1.3 Vision System
Tracks long-term goals and connects them to the habits, tasks, finances and learning activities that help achieve them.
- Goals with deadlines, target values and milestones.
- Vision Points (VP) for achievement.
- Bonus rewards for completing goals within their planned time.
- A permanent record of completed visions.
- Progression into increasingly ambitious goals.

### 1.4 Education & Knowledge System
Helps users develop practical skills and build a personal knowledge library.
- Reading and learning challenges.
- Importing PDFs, EPUBs and other supported documents from the device.
- Reading progress, bookmarks, highlights and notes.
- AI explanations, summaries and quizzes.
- Learning paths for psychology, philosophy, trading, negotiation, critical thinking and other subjects.

### 1.5 AI Council
A group of original AI advisors with distinct personalities, communication styles and areas of expertise. They coach users, explain concepts, challenge assumptions, analyze progress and suggest personalized actions.

## 2. The AI Council

The personalities are inspired by broad character archetypes from crime dramas, psychological films and business movies, without copying specific characters or their dialogue.

| Advisor              | Focus                                                                 |
| -------------------- | --------------------------------------------------------------------- |
| The Rebel            | Challenges excuses, complacency and self-defeating habits.            |
| The Strategist       | Analyzes systems, plans, risk and long-term decisions.                |
| The Boss             | Leadership, responsibility and keeping one's word.                    |
| The Philosopher      | Wisdom, ethics, purpose and perspective.                              |
| The Psychologist     | Understanding behavior, emotions and patterns.                        |
| The Financial Mentor | Budgeting, saving, investing fundamentals and financial responsibility. |
| The Commander        | Firm accountability and practical guidance during difficult periods.  |
| The Negotiator       | Persuasion, negotiation, sales, confidence and communication.         |

The Council supports one-to-one conversations and a shared **Council Chamber**, where several advisors analyze a decision from different perspectives. Users choose their preferred coaching personality and level of strictness.

## 3. Progression & scoring

Progress reflects both daily effort and long-term development.

- **XP (Experience Points):** earned through valid daily activities, habits and challenges. The initial design uses a base of 1–5 XP depending on difficulty.
- **Discipline Score:** consistency in following the user's chosen routines and commitments.
- ~~**Integrity Score**~~: removed 2026-11-02, because self-reported tasks cannot be verified. Legitimate emergencies are handled with excused days instead (see [scoring-spec.md](scoring-spec.md#4-excused-days)).
- **Momentum:** recent activity and the user's current rhythm of progress.
- **DP (Discipline Points):** a rarer reward for exceptional consistency, recovery and difficult achievements.
- **VP (Vision Points):** reward meaningful long-term achievements, milestones and the completion of ambitious visions.
- **Life Score & Identity Progress:** summarize growth across the areas the user chooses, without imposing one universal definition of success.

### The Ascension Algorithm

A progressive growth curve, using binomial expansion as the design direction:
- Early levels are attainable.
- Higher levels need progressively more XP.
- Consistency and improvement can increase the reward for valid actions.
- Harder tasks give greater opportunities for progression.
- Vision-aligned activities receive bonuses under transparent rules.
- Repeating trivial activities must not allow users to exploit the reward system.

Example: a reading task has 2 base XP. As the user's reading consistency, discipline, momentum and alignment with their vision improve, they may earn more.

The exact formula, maximum multiplier, level thresholds and rounding rules are still to be finalized and tested. Scores should not grow without limits. See [roadmap.md](roadmap.md#open-design-decisions).

## 4. The Vision System

The Vision System connects everything else. A user defines a goal, explains why it matters, chooses a target and deadline, and breaks it into milestones.

*Example:* **Build an emergency fund**, KSh 100,000 target, 40% complete. Connected systems: daily saving habit, budget tracking, financial milestones, AI progress recommendations.

VP follow a progressive reward model: later, more ambitious achievements earn more than repeated beginner goals. Completed visions, earned VP and achievements remain in the user's history.

## 5. Challenge & Evolution

When the system detects sustained improvement, it can offer an optional challenge.

*Example:* "You've built a strong reading routine. Would you like to increase the difficulty?"
- **Stay the course:** 20 pages, standard rewards.
- **Evolve:** 30 pages, a harder challenge for a larger reward.

(Illustrative targets. Actual difficulty and rewards are personalized.)

The challenge engine considers recent performance, consistency, available time and user preferences. If a user accepts a challenge and struggles, the system records what happened, offers a realistic recovery path, and can recommend returning to the previous level. An unsuccessful attempt is useful feedback, not proof that the user lacks ambition.

## 6. Deductions & penalties

Penalties are proportional to the behavior, the user's chosen accountability settings, and whether a pattern is developing.

| Situation                     | Possible consequence                                          |
| ----------------------------- | ------------------------------------------------------------- |
| Minor missed task             | Small XP or Momentum adjustment                               |
| Repeated missed commitments   | Reduced relevant score and a recovery challenge               |
| Financial overspending        | Budget review and optional discretionary allowance adjustment |
| Abandoned or unrealistic goal | Review the plan and revise it when appropriate                |
| Successful recovery           | Restore Momentum and earn recovery rewards where appropriate  |

Core principles:
- Never erase completed achievements or previously earned VP.
- Never punish a user for legitimate emergencies or revised circumstances.
- Every penalty has a clear explanation.
- Every penalty has a recovery path.
- Financial restrictions are user-controlled, transparent and limited to the agreed discretionary budget.

Users choose a coaching and accountability mode, from gentle to highly structured.

## 7. The Knowledge Hub

A personal e-book reader integrated with the rest of the app: device-file import for PDFs and other selected formats, reading progress, bookmarks, highlights, notes, search and AI tutoring.

Learning activities feed the XP and skill-progression systems. A user can turn a book into a learning plan, complete quizzes, and link lessons to a long-term vision.

## 8. Home screen: the Command Center

Financial discipline is a first-class feature on the home screen. Order:

1. Greeting header: "Good morning", level, streak.
2. **Financial Snapshot:** daily allowance, fun budget, savings progress, budget status.
3. **Today's Missions:** completed count, each mission with its XP.
4. **Who You're Becoming:** progress per chosen identity area (for example discipline, financial responsibility, lifelong learning).
5. **Active Visions:** progress toward each vision.
6. **Continue Learning:** resume the current book or course.
7. **Today's Council Insight:** a message from the chosen advisor.

Bottom navigation: Home, Missions, Finance, Knowledge, Profile. Detailed analytics and settings belong on their own screens.

## 9. Technical plan

Flutter for the app, Supabase for the backend. Development sequence:

1. Foundation: Flutter project, Git, folder layout, dependencies.
2. Database: user, habit, budget, vision, scoring, challenge and learning models.
3. Authentication: sign-up, login, sessions, profiles.
4. Onboarding: goals, preferences, budget settings, initial routines.
5. Dashboard: home screen connected to real data.
6. Core engines: habits, budgets, scoring, deductions, rewards, visions.
7. Learning: local file import, reading, bookmarks, learning progress.
8. AI Council: advisors, personalization, challenge recommendations.
9. Testing and release: calculations, permissions, security, accessibility, performance.

All financial calculations, reward rules and deductions are validated by trusted application logic, never calculated or awarded by the AI on its own. Personal data is protected, and users have clear control over their budgets and goals.

## 10. Design principles

- **User autonomy:** the user decides who they want to become.
- **Personalization:** goals, routines, challenges and coaching adapt to the individual.
- **Compound growth:** greater consistency and meaningful development unlock bigger rewards and harder challenges.
- **Accountability without humiliation:** consequences are transparent, proportionate and recoverable.
- **Achievement permanence:** completed visions and earned VP remain in the user's history.
- **Financial responsibility:** essential funds are protected; discretionary penalties are opt-in and clearly explained.
- **Quality over grinding:** meaningful progress matters more than repeating easy tasks.
- **One connected system:** habits, finance, learning, AI coaching and visions add up to one coherent picture of growth.
