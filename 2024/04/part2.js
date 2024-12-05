const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const grid = input.split('\n').map(line => line.split(''));

const MAX_Y = grid.length - 1
const MAX_X = grid[0].length - 1
let answer = 0;

const checkForXmas = (x, y) => {
  const withinBounds = y >= 1 && y <= MAX_Y - 1 && x >= 1 && x <= MAX_X - 1;

  if (withinBounds) {
    const upperLeft = grid[y - 1][x - 1];
    const upperRight = grid[y - 1][x + 1];
    const lowerLeft = grid[y + 1][x - 1];
    const lowerRight = grid[y + 1][x + 1];
    const diagonal1 = upperLeft + lowerRight;
    const diagonal2 = upperRight + lowerLeft;

    return (diagonal1 === 'MS' || diagonal1 === 'SM') &&  (diagonal2 === 'MS' || diagonal2 === 'SM');
  }

  return false;
};

for (let y = 0; y <= MAX_Y; y++) {
  for (let x = 0; x <= MAX_X; x++) {
    if (grid[y][x] === 'A' && checkForXmas(x, y)) {
      answer += 1;
    }
  }
}

console.log(answer);
