const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();

const regex = /mul\((\d+),(\d+)\)/g;
const matches = input.matchAll(regex);

let answer = 0;

for (const match of matches) {
  const number1 = Number(match[1]);
  const number2 = Number(match[2]);
  answer += (number1 * number2)
}

console.log(answer);
