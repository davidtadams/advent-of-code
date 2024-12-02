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

const rightListCounts = rightList.reduce((acc, number) => {
  if (acc[number] >= 0) {
    acc[number] += 1
  } else {
    acc[number] = 1
  }
  return acc
}, {});

let answer = 0

for (let i = 0; i < leftList.length; i++) {
  const leftListNumber = leftList[i]

  if (rightListCounts[leftListNumber] >= 0) {
    const score = leftListNumber * rightListCounts[leftListNumber]
    answer += score
  }
}

console.log(answer)
