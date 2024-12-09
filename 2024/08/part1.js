const fs = require('node:fs');
const getCombinations = require('./combinations');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const grid = input.split('\n').map(line => line.split(''));

const MAX_Y = grid.length - 1;
const MAX_X = grid[0].length - 1;

const antennas = {}
for (let y = 0; y <= MAX_Y; y++) {
  for (let x = 0; x <= MAX_X; x++) {
    const frequency = grid[y][x];

    if (frequency === '.' || frequency === '#') {
      continue;
    }

    if (frequency in antennas) {
      antennas[frequency].push([x, y]);
    } else {
      antennas[frequency] = [[x, y]];
    }
  }
}

const combinations = {};
for (let frequency in antennas) {
  combinations[frequency] = getCombinations(antennas[frequency], 2);
}

function getDistance(x1, y1, x2, y2) {
  return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
}

function addPointsOnLine(x1, y1, x2, y2, distance) {
  // Direction vector
  const dx = x2 - x1;
  const dy = y2 - y1;

  // Magnitude of the direction vector
  const magnitude = Math.sqrt(dx ** 2 + dy ** 2);

  // Normalized direction vector
  const nx = dx / magnitude;
  const ny = dy / magnitude;

  // New point at the given distance from (x2, y2)
  const x3 = x2 + distance * nx;
  const y3 = y2 + distance * ny;

  // New point at the given distance from (x1, y1)
  const x4 = x1 - distance * nx;
  const y4 = y1 - distance * ny;


  return [[x3, y3], [x4, y4]];
}

const antinodes = new Set();
for (let frequency in combinations) {
  for (let combination of combinations[frequency.toString()]) {
    const [[x1, y1], [x2, y2]] = combination;
    const distance = getDistance(x1, y1, x2, y2);
    const [[new_x1, new_y1], [new_x2, new_y2]] = addPointsOnLine(x1, y1, x2, y2, distance);

    if (new_x1 >= 0 && new_x1 <= MAX_X && new_y1 >= 0 && new_y1 <= MAX_Y) {
      antinodes.add(JSON.stringify([new_x1, new_y1]));
    }

    if (new_x2 >= 0 && new_x2 <= MAX_X && new_y2 >= 0 && new_y2 <= MAX_Y) {
      antinodes.add(JSON.stringify([new_x2, new_y2]));
    }
  }
}

console.log('answer:', antinodes.size);
