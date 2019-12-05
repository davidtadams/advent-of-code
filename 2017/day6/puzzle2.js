/*
--- Part Two ---

Out of curiosity, the debugger would also like to know the size of the loop: starting from a state that has already been seen, how many block redistribution cycles must be performed before that same state is seen again?

In the example above, 2 4 1 2 is seen again after four cycles, and so the answer in that example would be 4.

How many cycles are in the infinite loop that arises from the configuration in your puzzle input?
*/

const input = [2,8,8,5,4,2,3,1,5,5,1,2,15,13,5,14];
const input2 = [0,2,7,0];


calculateCycles = (input) => {
  let cycles = 0;
  let configurationStrings = [];
  const currConfiguration = input;

  while (hasNotBeenSeenBefore(currConfiguration, configurationStrings)) {
    configurationStrings.push(currConfiguration.join(''));

    let max = 0;
    let index = 0;

    for (let i = 0; i < currConfiguration.length; i++) {
      if (currConfiguration[i] > max) {
        max = currConfiguration[i];
        index = i;
      }
    }

    let distribute = max;
    currConfiguration[index] = 0;
    while (distribute > 0) {
      index += 1;
      if (index > currConfiguration.length - 1) {
        index = 0;
      }
      currConfiguration[index] += 1;
      distribute -= 1;
    }

    cycles += 1;
  }

  cycles = 0;
  configurationStrings = [];

  while (hasNotBeenSeenBefore(currConfiguration, configurationStrings)) {
    configurationStrings.push(currConfiguration.join(''));

    let max = 0;
    let index = 0;

    for (let i = 0; i < currConfiguration.length; i++) {
      if (currConfiguration[i] > max) {
        max = currConfiguration[i];
        index = i;
      }
    }

    let distribute = max;
    currConfiguration[index] = 0;
    while (distribute > 0) {
      index += 1;
      if (index > currConfiguration.length - 1) {
        index = 0;
      }
      currConfiguration[index] += 1;
      distribute -= 1;
    }

    cycles += 1;
  }

  return cycles;
};

const hasNotBeenSeenBefore = (curr, all) => {
  let seenBefore = false;

  for (let i = 0; i < all.length; i++) {
    if (curr.join('') === all[i]) {
      seenBefore = true;
    }
  }

  return !seenBefore;
};

console.log(calculateCycles(input));
