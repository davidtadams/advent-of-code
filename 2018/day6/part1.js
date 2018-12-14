/*
  Problem: https://adventofcode.com/2018/day/6
*/

const { simpleInput: input } = require('./input');
// const { input } = require('./input');

const { formatGrid } = require('../helpers');

/*
  Steps:
    - setup grid with all coordinates
    - calculate manhattan distance for grid
    - remove possibility of infinite areas
    - find size of largest area
*/
// const GRID_LENGTH = 1000;
// const GRID_WIDTH = 1000;
const GRID_LENGTH = 10;
const GRID_WIDTH = 10;

const coordinates = input.map((row, index) => {
  const [x, y] = row.split(', ');

  return { x: Number(x), y: Number(y), value: index + 1 };
});

const grid = new Array(GRID_LENGTH)
  .fill(null)
  .map(() => new Array(GRID_WIDTH).fill('-'));

/*
  Plot coordinates on the grid
*/
for (let coordinate of coordinates) {
  const { x, y, value } = coordinate;

  grid[y][x] = `*${value}*`;
}

/*
  used to store all of the areas for a coordinate
*/
const coordinateAreas = coordinates.reduce((acc, coordinate) => {
  acc[coordinate.value] = 1;

  return acc;
}, {});

/*
  calculate shortest manhattan distance for a coordinate
*/
const findClosestCoordinate = (xCord, yCord) => {
  const distances = [];
  let shortestDistance = {
    distance: Number.POSITIVE_INFINITY,
    coordinate: '',
  };
  let sameShortestDistances = 0;

  for (let coordinate of coordinates) {
    const { x, y, value } = coordinate;

    if (x === xCord && y === yCord) {
      return null;
    }

    const distance = Math.abs(xCord - x) + Math.abs(yCord - y);
    distances.push(distance);

    if (distance < shortestDistance.distance) {
      shortestDistance.distance = distance;
      shortestDistance.coordinate = value;
    }
  }

  distances.forEach(distance => {
    if (distance === shortestDistance.distance) {
      sameShortestDistances += 1;
    }
  });

  return sameShortestDistances === 1 ? shortestDistance.coordinate : '.';
};

/*
  Store all of the differences in the grid
  while also calculating areas
*/
for (let y = 0; y < GRID_LENGTH; y++) {
  for (let x = 0; x < GRID_WIDTH; x++) {
    const closestCoordinate = findClosestCoordinate(x, y);

    if (closestCoordinate !== null) {
      if (closestCoordinate !== '.') {
        coordinateAreas[closestCoordinate] += 1;
      }

      grid[y][x] = closestCoordinate;
    }
  }
}

console.log(coordinateAreas);

/*
  get rid of coordinates with infinite areas
  anything on the edge is infinite
*/
for (let y = 0; y < GRID_LENGTH; y++) {
  for (let x = 0; x < GRID_WIDTH; x++) {
    const value = grid[y][x];

    if (y === 0 || y === GRID_LENGTH - 1) {
      delete coordinateAreas[value];
    }

    if (x === 0 || x === GRID_WIDTH - 1) {
      delete coordinateAreas[value];
    }
  }
}

let largestCoordinateArea = 0;

for (let value in coordinateAreas) {
  if (coordinateAreas[value] > largestCoordinateArea) {
    largestCoordinateArea = coordinateAreas[value];
  }
}

const formattedGrid = formatGrid(grid);
// console.log(formattedGrid);
console.log(coordinateAreas);
// console.log(coordinates);

console.log('ANSWER', largestCoordinateArea);
