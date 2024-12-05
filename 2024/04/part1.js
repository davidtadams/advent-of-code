const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const grid = input.split('\n').map(line => line.split(''));

const MAX_Y = grid.length - 1
const MAX_X = grid[0].length - 1
let answer = 0;

const checkUp = (x, y) => {
  return y >= 3 && grid[y - 1][x] === 'M' && grid[y - 2][x] === 'A' && grid[y - 3][x] === 'S'
};

const checkUpRight = (x, y) => {
  return y >= 3 && x <= MAX_X - 3 && grid[y - 1][x + 1] === 'M' && grid[y - 2][x + 2] === 'A' && grid[y - 3][x + 3] === 'S'
};

const checkRight = (x, y) => {
  return x <= MAX_X - 3 && grid[y][x + 1] === 'M' && grid[y][x + 2] === 'A' && grid[y][x + 3] === 'S'
};

const checkDownRight = (x, y) => {
  return y <= MAX_Y - 3 && x <= MAX_X - 3 && grid[y + 1][x + 1] === 'M' && grid[y + 2][x + 2] === 'A' && grid[y + 3][x + 3] === 'S'
};

const checkDown = (x, y) => {
  return y <= MAX_Y - 3 && grid[y + 1][x] === 'M' && grid[y + 2][x] === 'A' && grid[y + 3][x] === 'S'
};

const checkDownLeft = (x, y) => {
  return y <= MAX_Y - 3 && x >= 3 && grid[y + 1][x - 1] === 'M' && grid[y + 2][x - 2] === 'A' && grid[y + 3][x - 3] === 'S'
};

const checkLeft = (x, y) => {
  return x >= 3 && grid[y][x - 1] === 'M' && grid[y][x - 2] === 'A' && grid[y][x - 3] === 'S'
};

const checkUpLeft = (x, y) => {
  return y >= 3 && x >= 3 && grid[y - 1][x - 1] === 'M' && grid[y - 2][x - 2] === 'A' && grid[y - 3][x - 3] === 'S'
};

for (let y = 0; y <= MAX_Y; y++) {
  for (let x = 0; x <= MAX_X; x++) {
    if (grid[y][x] === 'X') {
      if (checkUp(x, y)) {
        answer += 1;
      }

      if (checkUpRight(x, y)) {
        answer += 1;
      }

      if (checkRight(x, y)) {
        answer += 1;
      }

      if (checkDownRight(x, y)) {
        answer += 1;
      }

      if (checkDown(x, y)) {
        answer += 1;
      }

      if (checkDownLeft(x, y)) {
        answer += 1;
      }

      if (checkLeft(x, y)) {
        answer += 1;
      }

      if (checkUpLeft(x, y)) {
        answer += 1;
      }
    }
  }
}

console.log(answer);
