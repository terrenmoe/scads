// Find the transpose of a rectangular matrix
function transpose(m) = // m is any rectangular matrix of objects
[ for(j = [0:len(m[0]) - 1])
  [ for(i = [0:len(m) - 1])
    m[i][j]
  ]
];

// echo(
//   transpose(transpose([
//     [1, 2],
//     [3, 4],
//     [5, 6],
//     [7, 8],
//   ])),
// transpose([
//     [1, 2],
//     [3, 4],
//     [5, 6],
//     [7, 8],
//   ]),
// );
