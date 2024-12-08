const fs = require('node:fs');
const getPermutations = require('./permutations.js');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const lines = input.split('\n')
  .map(line => line.split(': '))
  .map(line => [Number(line[0]), line[1].split(' ').map(Number)])
  .map(line => [line[0], line[1], getPermutations(['*', '+'], line[1].length - 1)]);

const testEquation = (testValue, numbers, operators) => {
  let isValid = false;

  for (let operatorList of operators) {
    const evaluation = operatorList.reduce((acc, operator, index) => {
      const tmp = acc;

      if (operator === '*') {
        acc = acc * numbers[index + 1];
      } else if (operator === '+') {
        acc = acc + numbers[index + 1];
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
