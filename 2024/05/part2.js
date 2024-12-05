const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
let [rules, updates] = input.split('\n\n');
updates = updates.split('\n').map(line => line.split(',').map(char => Number(char)));

// Rules is a map where the key is the number and the value is an array of all the numbers it must come before
rules = rules.split('\n').reduce((acc, rule) => {
  const [number, instruction] = rule.split('|')

  if (number in acc) {
    acc[number].add(Number(instruction));
  } else {
    acc[number] = new Set([Number(instruction)]);
  }

  return acc;
}, {});

const checkUpdate = (update) => {
  const seenNumbers = new Set();

  for (number of update) {
    const beforeNumbers = rules[number];

    if (beforeNumbers instanceof Set && seenNumbers.intersection(beforeNumbers).size > 0) {
      return false;
    }

    seenNumbers.add(number);
  }

  return true;
};

const fixUpdate = (update) => {
  const newUpdate = [...update];
  let hadToCorrectUpdate;

  do {
    const seenNumbers = new Set();
    hadToCorrectUpdate = false

    for (const [index, number] of newUpdate.entries()) {
      const beforeNumbers = rules[number];

      if (beforeNumbers instanceof Set && seenNumbers.intersection(beforeNumbers).size > 0) {
        const tmp = newUpdate[index - 1];
        newUpdate[index - 1] = number;
        newUpdate[index] = tmp;

        hadToCorrectUpdate = true;
        break;
      }

      seenNumbers.add(number);
    }

  } while (hadToCorrectUpdate);

  return newUpdate;
}

const incorrectUpdates = updates.filter(update => !checkUpdate(update))
const fixedUpdates = incorrectUpdates.map(fixUpdate)

const answer = fixedUpdates.reduce((acc, update) => {
  acc += update[Math.floor(update.length / 2)]
  return acc;
}, 0)
console.log(answer);
