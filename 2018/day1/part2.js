/*
  Problem: https://adventofcode.com/2018/day/1#part2
*/

const input = require('./input').split('\n');

const STARTING_VALUE = 0;
const frequencySet = new Set();
let ANSWER;
let keepGoing = true;
let currentFrequency = STARTING_VALUE;

const calculateFrequency = (frequency, value) => {
  let newFrequency = frequency;

  const operator = value.charAt(0);
  const number = Number(value.substring(1));

  if (operator === '-') {
    newFrequency = newFrequency - number;
  } else if (operator === '+') {
    newFrequency = newFrequency + number;
  }

  return newFrequency;
};

while (keepGoing) {
  for (let i = 0; i < input.length; i++) {
    currentFrequency = calculateFrequency(currentFrequency, input[i]);

    if (frequencySet.has(currentFrequency)) {
      ANSWER = currentFrequency;
      keepGoing = false;
      break;
    } else {
      frequencySet.add(currentFrequency);
    }
  }
}

console.log(`ANSWER IS: ${ANSWER}`);
