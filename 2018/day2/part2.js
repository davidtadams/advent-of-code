/*
  Problem: https://adventofcode.com/2018/day/2#part2
*/

// const { simpleInput2: input } = require('./input');
const { input } = require('./input');

let prototype1 = null;
let prototype2 = null;
let differentIndex = null;

for (let i = 0; i < input.length; i++) {
  const box1 = input[i];

  for (let j = i + 1; j < input.length; j++) {
    let differences = 0;
    const box2 = input[j];

    for (let x = 0; x < box1.length; x++) {
      if (differences > 1) {
        break;
      }

      if (box1.charAt(x) !== box2.charAt(x)) {
        differences += 1;
        differentIndex = x;
      }
    }

    if (differences === 1) {
      prototype1 = box1;
      prototype2 = box2;

      break;
    }
  }

  if (prototype1 && prototype2) {
    break;
  }
}

const ANSWER =
  prototype1.slice(0, differentIndex) + prototype1.slice(differentIndex + 1);

console.log('Prototype 1', prototype1);
console.log('Prototype 2', prototype2);
console.log('different index', differentIndex);
console.log('ANSWER', ANSWER);
