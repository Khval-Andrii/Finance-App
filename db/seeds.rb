categories = {
  'Daily Expenses' => 'Keep track of your day-to-day expenses like groceries, transportation, and small purchases.',
  'Bills & Utilities' => 'Manage payments for electricity, water, internet, and other recurring bills.',
  'Entertainment & Leisure' => 'Track expenses related to entertainment, dining out, movies, hobbies, and recreational activities.',
  'Travel & Vacation' => 'Plan and budget for trips, flights, accommodations, and sightseeing.',
  'Savings & Investments' => 'Monitor your savings progress and investments, including stocks, mutual funds, and retirement accounts.',
  'Debts & Loans' => 'Keep tabs on outstanding debts, loans, and credit card balances.',
  'Education & Learning' => 'Record expenses related to courses, workshops, and educational materials.',
  'Gifts & Donations' => 'Track gifts for family and friends, as well as donations to charities and causes.',
  'Health & Wellness' => 'Monitor expenses for healthcare, insurance premiums, gym memberships, and wellness products.',
  'Miscellaneous' => "For any transactions that don't fit into the other categories, use this catch-all category."
}

categories.each { |k, v| Category.create(name: k, description: v, user_id: nil) }
