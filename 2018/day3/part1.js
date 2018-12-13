/*
  Problem: https://adventofcode.com/2018/day/3
*/

// const { simpleInput: input } = require('./input');
const { input } = require('./input');

const MATRIX_LENGTH = 1000;
const MATRIX_WIDTH = 1000;

const matrix = new Array(MATRIX_LENGTH)
  .fill(null)
  .map(() => new Array(MATRIX_WIDTH).fill('.'));

const claims = input.map(claim => {
  const claimPieces = claim
    .replace('#', '')
    .replace('@ ', '')
    .replace(':', '')
    .split(' ');

  const claimId = claimPieces[0];
  const [fromLeft, fromTop] = claimPieces[1].split(',');
  const [width, height] = claimPieces[2].split('x');

  return {
    claimId,
    fromLeft: Number(fromLeft),
    fromTop: Number(fromTop),
    width: Number(width),
    height: Number(height),
  };
});

/*
  Matrix key:
  . => empty
  - => one claim
  x => more than one claim
*/
let answer = 0;

for (let claimData of claims) {
  const { fromLeft, fromTop, width, height } = claimData;

  for (let i = 0; i < height; i++) {
    for (let j = 0; j < width; j++) {
      const cellValue = matrix[i + fromTop][j + fromLeft];

      if (cellValue === '.') {
        matrix[i + fromTop][j + fromLeft] = '-';
      } else if (cellValue === '-') {
        matrix[i + fromTop][j + fromLeft] = 'x';
        answer += 1;
      }
    }
  }
}

console.log('ANSWER', answer);
