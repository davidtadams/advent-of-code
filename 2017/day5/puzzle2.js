/*
--- Part Two ---

Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1. Otherwise, increase it by 1 as before.

Using this rule with the above example, the process now takes 10 steps, and the offset values after finding the exit are left as 2 3 2 3 -1.

How many steps does it now take to reach the exit?
*/

const fs = require('fs');

const input = fs.readFileSync('./day5/input.txt', { encoding: 'utf8' }).split(/\n/).map(num => parseInt(num));
const input2 = [0, 3, 0, 1, -3];

const calculateSteps = (input) => {
  const lastIndex = input.length - 1;
  let index = 0;
  let steps = 0;
  let jump;

  while (index <= lastIndex) {
    jump = input[index];
    if (jump >= 3) {
      input[index] -= 1;
    } else {
      input[index] += 1;
    }
    index = index + jump;
    steps += 1;
  }

  return steps;
};

console.log(calculateSteps(input));
