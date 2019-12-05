/*
--- Part Two ---
To be safe, the CPU also needs to know the highest value held in any register during this process so that it can decide how much memory to allocate to these operations. For example, in the above instructions, the highest value ever held was 10 (in register c after the third instruction was evaluated).
*/


const fs = require('fs');

const input = fs.readFileSync('./day8/input.txt', { encoding: 'utf8' })
  .split(/\n/)
  .map(line => {
    line = line.split(' ');
    return {
      register: line[0],
      operation: line[1],
      amount: line[2],
      leftRegister: line[4],
      opCond: line[5],
      rightValue: line[6],
    };
  });

let maxValueEver = 0;

const result = input.reduce((acc, curr) => {
  const { register, operation, amount, leftRegister, opCond, rightValue } = curr;
  if (!acc.hasOwnProperty(register)) {
    acc[register] = 0;
  }
  if (!acc.hasOwnProperty(leftRegister)) {
    acc[leftRegister] = 0;
  }

  let condition = `${acc[leftRegister]} ${opCond} ${rightValue}`;

  if (eval(condition)) {
    if (operation === 'inc') {
      acc[register] += parseInt(amount);
    } else if (operation === 'dec') {
      acc[register] -= parseInt(amount);
    }
  }

  Object.keys(acc).forEach(key => {
    if (acc[key] > maxValueEver) {
      maxValueEver = acc[key];
    }
  });

  return acc;
}, {})

console.log(maxValueEver);
