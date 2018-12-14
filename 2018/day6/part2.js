/*
  Problem:
*/

// const { simpleInput: input } = require('./input');
const { input } = require('./input');

const { formatGrid } = require('../helpers');

const GRID_LENGTH = 1000;
const GRID_WIDTH = 1000;
const THRESHOLD = 10000;
// const GRID_LENGTH = 10;
// const GRID_WIDTH = 10;
// const THRESHOLD = 32;

const coordinates = input.map((row, index) => {
  const [x, y] = row.split(', ');

  return { x: Number(x), y: Number(y), value: index + 1 };
});

const grid = new Array(GRID_LENGTH)
  .fill(null)
  .map(() => new Array(GRID_WIDTH).fill('.'));

/*
  Plot coordinates on the grid
*/
for (let coordinate of coordinates) {
  const { x, y, value } = coordinate;

  grid[y][x] = `${value}`;
}

/*
  calculate shortest manhattan distance for a coordinate
*/
const findIfInRegion = (xCord, yCord) => {
  let totalDistance = 0;

  for (let coordinate of coordinates) {
    const { x, y } = coordinate;

    const distance = Math.abs(xCord - x) + Math.abs(yCord - y);

    totalDistance += distance;
  }

  return totalDistance < THRESHOLD;
};

/*
  Store all of the differences in the grid
  while also calculating areas
*/
let regionSize = 0;

for (let y = 0; y < GRID_LENGTH; y++) {
  for (let x = 0; x < GRID_WIDTH; x++) {
    const isInRegion = findIfInRegion(x, y);

    if (isInRegion) {
      regionSize += 1;

      grid[y][x] = '#';
    }
  }
}

const formattedGrid = formatGrid(grid);
// console.log(formattedGrid);

console.log('ANSWER', regionSize);
