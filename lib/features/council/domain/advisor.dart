/// The AI Council roster (blueprint §2). These are original archetypes,
/// not copies of any specific fictional character.
enum Advisor {
  rebel(
    'The Rebel',
    'Challenges excuses, complacency and self-defeating habits.',
  ),
  strategist(
    'The Strategist',
    'Analyzes systems, plans, risk and long-term decisions.',
  ),
  boss('The Boss', "Leadership, responsibility and keeping one's word."),
  philosopher('The Philosopher', 'Wisdom, ethics, purpose and perspective.'),
  psychologist(
    'The Psychologist',
    'Understanding behavior, emotions and patterns.',
  ),
  financialMentor(
    'The Financial Mentor',
    'Budgeting, saving, investing fundamentals and financial responsibility.',
  ),
  commander(
    'The Commander',
    'Firm accountability and practical guidance during difficult periods.',
  ),
  negotiator(
    'The Negotiator',
    'Persuasion, negotiation, sales, confidence and communication.',
  );

  const Advisor(this.title, this.focus);

  final String title;
  final String focus;
}
