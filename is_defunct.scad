// legacy undef and nan predicates for use in is_defunct.

function is_undef(a) = (undef == a);

function is_nan(a) = (a != a);

function is_defunct(a) = (is_nan(a)) ? true : is_undef(a);
