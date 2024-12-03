const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();

const regex = /(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/g;
const matches = input.matchAll(regex);

let answer = 0;
let enabledMode = true;

for (const match of matches) {
  switch (match[0]) {
    case 'do()':
      enabledMode = true;
      break;
    case "don't()":
      enabledMode = false;
      break;
    default:
      if (enabledMode) {
        const number1 = Number(match[2]);
        const number2 = Number(match[3]);
        answer += (number1 * number2)
      }
      break;
  }
}

console.log(answer);
