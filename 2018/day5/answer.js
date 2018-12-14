/*
  Problem: https://adventofcode.com/2018/day/5
*/

// const { simpleInput: input } = require('./input');
const { input } = require('./input');

const reactPolymer = polymer => {
  let polymerCopy = polymer;
  let repeat = true;

  while (repeat) {
    let counter = 0;
    repeat = false;

    while (counter < polymerCopy.length - 1) {
      let unit1 = polymerCopy[counter];
      let unit2 = polymerCopy[counter + 1];

      if (unit1.toLowerCase() === unit2.toLowerCase()) {
        if (unit1 !== unit2) {
          repeat = true;
          polymerCopy = polymerCopy.replace(`${unit1}${unit2}`, '');
        } else {
          counter += 1;
        }
      } else {
        counter += 1;
      }
    }
  }

  return polymerCopy;
};

const ANSWER1 = reactPolymer(input).length;

console.log('ANSWER PART 1', ANSWER1);

/*
  Part 2: https://adventofcode.com/2018/day/5#part2
*/
const ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

const ANSWER2 = ALPHABET.split('').reduce(
  (acc, letter) => {
    const regex = new RegExp(`${letter}|${letter.toUpperCase()}`, 'g');

    const strippedPolymer = input.replace(regex, '');
    const reactedPolymer = reactPolymer(strippedPolymer);

    if (reactedPolymer.length < acc.shortestLength) {
      acc.shortestLength = reactedPolymer.length;
      acc.letter = letter;
    }

    return acc;
  },
  {
    shortestLength: Number.POSITIVE_INFINITY,
    letter: '',
  }
);

console.log('ANSWER PART 2', ANSWER2);
