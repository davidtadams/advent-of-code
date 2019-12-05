/*
  --- Day 4: High-Entropy Passphrases ---

  A new system policy has been put in place that requires all accounts to use a passphrase instead of simply a password. A passphrase consists of a series of words (lowercase letters) separated by spaces.

  To ensure security, a valid passphrase must contain no duplicate words.

  For example:

  aa bb cc dd ee is valid.
  aa bb cc dd aa is not valid - the word aa appears more than once.
  aa bb cc dd aaa is valid - aa and aaa count as different words.
  The system's full passphrase list is available as your puzzle input. How many passphrases are valid?
*/
const fs = require('fs');

const input = fs.readFileSync('./day4/input.txt', { encoding: 'utf8' })
  .split(/\n/)
  .map(phrase => phrase.split(' '));

const input2 = [['aa', 'bb', 'cc', 'dd', 'ee'], ['aa', 'bb', 'aa'], ['aa', 'bb', 'aaa']];

const calculateValidPhrases = (input) => {
  let correctPhrases = 0;

  for (let i = 0; i < input.length; i++) {
    if (isValidPhrase(input[i])) {
      correctPhrases += 1;
    }
  }

  return correctPhrases;
};

const isValidPhrase = phrase => {
  let phraseSet = new Set();
  let isValid = true;

  for (let i = 0; i < phrase.length; i++) {
    if (phraseSet.has(phrase[i])) {
      isValid = false;
      break;
    }
    phraseSet.add(phrase[i]);
  }

  return isValid;
};

console.log(calculateValidPhrases(input));
