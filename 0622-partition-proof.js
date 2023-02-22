const R = (a, b) => [(a && !b), (b && !a), (a && b), (!a && !b)].filter(x => x).length === 1;

const bool = [true, false];

bool.forEach(a => bool.forEach(b => {
   console.log({a: ~~a, b: ~~b, R: ~~R(a, b)});
}));
