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

// ChatGPT helped out with these two functions
function gcd(a, b) {
  return b === 0 ? Math.abs(a) : gcd(b, a % b);
}
function getLinePointsFromTwoPoints(x1, y1, x2, y2) {
  const points = [];
  const dx = x2 - x1;
  const dy = y2 - y1;

  // Get the GCD to simplify the direction vector
  const divisor = gcd(dx, dy);
  const stepX = dx / divisor;
  const stepY = dy / divisor;

  // Move backward along the line
  let x = x1, y = y1;
  while (x >= 0 && x <= MAX_X && y >= 0 && y <= MAX_Y) {
    points.unshift([x, y]); // Add to the beginning
    x -= stepX;
    y -= stepY;
  }

  // Move forward along the line
  x = x1 + stepX;
  y = y1 + stepY;
  while (x >= 0 && x <= MAX_X && y >= 0 && y <= MAX_Y) {
    points.push([x, y]); // Add to the end
    x += stepX;
    y += stepY;
  }

  return points;
}

const antinodes = new Set();
for (let frequency in combinations) {
  for (let combination of combinations[frequency.toString()]) {
    const [[x1, y1], [x2, y2]] = combination;
    const points = getLinePointsFromTwoPoints(x1, y1, x2, y2);
    points.forEach(point => antinodes.add(JSON.stringify(point)));
  }
}

console.log('answer:', antinodes.size);
