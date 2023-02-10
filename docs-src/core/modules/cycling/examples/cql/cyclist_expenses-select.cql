SOURCE 'cyclist_expenses-table.cql';

EXPAND ON

CAPTURE 'cyclist_expenses-select.results';
// tag::query[]
SELECT
  cyclist_name, expense_id,
  amount, WRITETIME(amount),
  description, WRITETIME(description),
  paid, WRITETIME(paid)
FROM cycling.cyclist_expenses
WHERE cyclist_name = 'Vera ADRIAN';
// end::query[]
CAPTURE OFF

EXPAND OFF
