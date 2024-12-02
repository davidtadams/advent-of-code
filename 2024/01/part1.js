const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const lines = input.split('\n');

const [leftList, rightList] = lines
  .reduce((acc, line) => {
    const [leftNumber, rightNumber] = line.split('   ').map(Number);
    acc[0].push(leftNumber);
    acc[1].push(rightNumber);
    return acc;
  }, [[], []])
  .map(list => list.sort((a, b) => a - b))

let answer = 0

for (let i = 0; i < leftList.length; i++) {
  const distance = Math.abs(leftList[i] - rightList[i])
  answer += distance
}

console.log(answer)
