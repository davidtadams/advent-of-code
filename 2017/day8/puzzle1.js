/*
  --- Day 8: I Heard You Like Registers ---

  You receive a signal directly from the CPU. Because of your recent assistance with jump instructions, it would like you to compute the result of a series of unusual register instructions.

  Each instruction consists of several parts: the register to modify, whether to increase or decrease that register's value, the amount by which to increase or decrease it, and a condition. If the condition fails, skip the instruction without modifying the register. The registers all start at 0. The instructions look like this:

  b inc 5 if a > 1
  a inc 1 if b < 5
  c dec -10 if a >= 1
  c inc -20 if c == 10
  These instructions would be processed as follows:

  Because a starts at 0, it is not greater than 1, and so b is not modified.
  a is increased by 1 (to 1) because b is less than 5 (it is 0).
  c is decreased by -10 (to 10) because a is now greater than or equal to 1 (it is 1).
  c is increased by -20 (to -10) because c is equal to 10.
  After this process, the largest value in any register is 1.

  You might also encounter <= (less than or equal to) or != (not equal to). However, the CPU doesn't have the bandwidth to tell you what all the registers are named, and leaves that to you to determine.

  What is the largest value in any register after completing the instructions in your puzzle input?
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

  return acc;
}, {})

const maxValue = Object.keys(result).reduce((acc, curr) => {
  if (result[curr] > acc) {
    return result[curr];
  }
  return acc;
}, 0);

console.log(maxValue);


