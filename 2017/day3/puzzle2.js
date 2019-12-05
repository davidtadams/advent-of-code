/*
  --- Part Two ---

  As a stress test on the system, the programs here clear the grid and then store the value 1 in square 1. Then, in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

  So, the first few squares' values are chosen as follows:

  Square 1 starts with the value 1.
  Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
  Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
  Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
  Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.
  Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

  147  142  133  122   59
  304    5    4    2   57
  330   10    1    1   54
  351   11   23   25   26
  362  747  806--->   ...
  What is the first value written that is larger than your puzzle input?

  Your puzzle input is still 347991.
*/
const N = 11;
const matrix = new Array(N).fill(0).map(row => new Array(N).fill(0));
const half = Math.floor(N/2);
let x = half;
let y = half;
matrix[x][y] = 1;

const createMatrix = () => {
  for (let i = 1; i < half; i++) {
    let steps = i * 2;
    x++;
    matrix[y][x] = calculateCell(x, y);

    //go up ring
    for (let i = 1; i < steps; i++) {
      y--;
      matrix[y][x] = calculateCell(x, y);
    }

    //go left ring
    for (let i = 1; i <= steps; i++) {
      x--;
      matrix[y][x] = calculateCell(x, y);
    }

    //go down ring
    for (let i = 1; i <= steps; i++) {
      y++;
      matrix[y][x] = calculateCell(x, y);
    }

    //go right ring
    for (let i = 1; i <= steps; i++) {
      x++;
      matrix[y][x] = calculateCell(x, y);
    }
  }
};

const calculateCell = (x, y) => {
  const neighbors = [
    matrix[y - 1][x], //up
    matrix[y - 1][x - 1], //top left
    matrix[y][x - 1], //left
    matrix[y + 1][x - 1], //bottom left
    matrix[y + 1][x], //bottom
    matrix[y + 1][x + 1], //bottom right
    matrix[y][x + 1], //right
    matrix[y - 1][x + 1], //top right
  ];

  return neighbors.reduce((acc, curr) => { return acc + curr }, 0);
};

createMatrix();

console.log(matrix);
