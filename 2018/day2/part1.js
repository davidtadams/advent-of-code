/*
  Problem: https://adventofcode.com/2018/day/2
*/

// const { simpleInput1: input } = require('./input');
const { input } = require('./input');

const counts = input.reduce(
  (acc, row) => {
    const rowCharacters = row.split('');
    const rowCounts = rowCharacters.reduce((acc, character) => {
      if (acc.hasOwnProperty(character)) {
        acc[character] += 1;
      } else {
        acc[character] = 1;
      }

      return acc;
    }, {});

    let twiceCounted = false;
    let thriceCounted = false;

    for (let character in rowCounts) {
      if (!twiceCounted && rowCounts[character] === 2) {
        acc.twice += 1;
        twiceCounted = true;
      } else if (!thriceCounted && rowCounts[character] === 3) {
        acc.thrice += 1;
        thriceCounted = true;
      }
    }

    return acc;
  },
  { twice: 0, thrice: 0 }
);

const CHECKSUM = counts.twice * counts.thrice;

console.log(CHECKSUM);
