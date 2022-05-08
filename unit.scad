// Find the unitary vector with direction v. Fails if v=[0,0,0].
function unit(v) = norm(v)>0 ? v/norm(v) : undef;
