/*
  Problem: https://adventofcode.com/2018/day/1
*/

const input = require('./input').split('\n');

const STARTING_VALUE = 0;

const ANSWER = input.reduce((acc, value) => {
  const operator = value.charAt(0);
  const number = Number(value.substring(1));

  if (operator === '-') {
    acc -= number;
  } else if (operator === '+') {
    acc += number;
  }

  return acc;
}, STARTING_VALUE);

console.log(`ANSWER IS: ${ANSWER}`);
