SOURCE 'left-function.cql';

CAPTURE 'cyclist_name-select_left.results';
SELECT left(firstname, 1), lastname
FROM cycling.cyclist_name;
CAPTURE OFF;
