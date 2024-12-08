const fs = require('node:fs');
const getPermutations = require('./permutations.js');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const lines = input.split('\n')
  .map(line => line.split(': '))
  .map(line => [Number(line[0]), line[1].split(' ').map(Number)]);

// The max number of spots for a permutation in input.txt is 11
// 3 chars with 11 spots is 177,147 permutations
let maxSpots = 0;
for (let line of lines) {
  const spots = line[1].length - 1
  if (spots > maxSpots) {
    maxSpots = spots;
  }
}

// This goes and calculates all the permutations for up to 11 spots and stores them in a hash
let permutations = {};
for (let i = 1; i <= maxSpots; i++) {
  permutations[i] = getPermutations(['*', '+', '||'], i)
}

const testEquation = (testValue, numbers) => {
  let isValid = false;
  const spots = numbers.length - 1;

  for (let operatorList of permutations[spots]) {
    const evaluation = operatorList.reduce((acc, operator, index) => {
      if (operator === '*') {
        acc = acc * numbers[index + 1];
      } else if (operator === '+') {
        acc = acc + numbers[index + 1];
      } else if (operator === '||') {
        acc = Number(acc.toString() + numbers[index + 1].toString());
      }

      return acc;
    }, numbers[0]);

    if (testValue === evaluation) {
      isValid = true;
      break;
    }
  }

  return isValid;
};

const answer = lines.reduce((acc, line) => {
  if (testEquation(line[0], line[1], line[2])) {
    acc += line[0];
  }

  return acc;
}, 0);

console.log(answer);
