categories = {
  "Daily Expenses" => "Keep track of your day-to-day expenses like groceries, transportation, and small purchases. This category helps you budget and control your spending.",
  "Bills & Utilities" => "Manage payments for electricity, water, internet, and other recurring bills. Set reminders to avoid missing due dates and late fees.",
  "Entertainment & Leisure" => "Track expenses related to entertainment, dining out, movies, hobbies, and recreational activities. This category allows you to monitor discretionary spending.",
  "Travel & Vacation" => "Plan and budget for trips, flights, accommodations, and sightseeing. This category helps you save and allocate funds for your travel goals.",
  "Savings & Investments" => "Monitor your savings progress and investments, including stocks, mutual funds, and retirement accounts. Set financial goals and track your investment performance.",
  "Debts & Loans" => "Keep tabs on outstanding debts, loans, and credit card balances. Set up payment schedules and be mindful of interest rates.",
  "Education & Learning" => "Record expenses related to courses, workshops, and educational materials. This category promotes lifelong learning and personal development.",
  "Gifts & Donations" => "Track gifts for family and friends, as well as donations to charities and causes. This category helps you plan for special occasions and support meaningful causes.",
  "Health & Wellness" => "Monitor expenses for healthcare, insurance premiums, gym memberships, and wellness products. Prioritize your well-being while managing costs.",
  "Miscellaneous" => "For any transactions that don't fit into the other categories, use this catch-all category. Regularly review this section to identify potential new categories."
}

categories.each { |k, v| Category.create(name: k, description: v) }