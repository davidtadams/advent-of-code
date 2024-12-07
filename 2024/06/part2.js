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

const [startingX, startingY] = getStartingLocation(grid);
const guard1 = new Guard(startingX, startingY, '^');

while (guard1.stillOnGrid) {
  guard1.move(grid);
}

// for each visited point - test if placing a blocker there would result in a loop
// for the loop, keep track of the number of moves
// compare the number of moves with the number of distinct places visited
// if the difference between the number of moves and the unique places visited starts growing by a lot, then we are in a loop
// the difference growing means that we keep repeating the same spots
let loopCount = 0;
for (const [newObstructionX, newObstructionY] of guard1.visited) {
  if (newObstructionX === startingX && newObstructionY === startingY) {
    continue;
  }

  let moves = 0;
  const guard2 = new Guard(startingX, startingY, '^');
  grid[newObstructionY][newObstructionX] = '#';

  while (guard2.stillOnGrid && (moves - guard2.visitedCount()) < 1000) {
    guard2.move(grid)
    moves++;
  }

  if (guard2.stillOnGrid) {
    loopCount++;
  }

  grid[newObstructionY][newObstructionX] = '.';
}

console.log('answer:', loopCount);
