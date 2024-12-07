const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const grid = input.split('\n').map(line => line.split(''));

const Guard = require('./Guard.js');

const getStartingLocation = (grid) => {
  let initialX = null;
  let initialY = null;

  for (let y = 0; y <= grid.length - 1; y++) {
    for (let x = 0; x <= grid[0].length - 1; x++) {
      if (grid[y][x] === '^') {
        initialX = x;
        initialY = y;
        break;
      }
    }

    if (initialX && initialY) {
      break;
    }
  }

  return [initialX, initialY];
}

const [x, y] = getStartingLocation(grid);
const guard = new Guard(x, y, '^');

while (guard.stillOnGrid) {
  guard.move(grid);
}

const answer = guard.visitedCount();
console.log(answer);
