/*
  --- Part Two ---

  For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.

  For example:

  abcde fghij is a valid passphrase.
  abcde xyz ecdab is not valid - the letters from the third word can be rearranged to form the first word.
  a ab abc abd abf abj is a valid passphrase, because all letters need to be used when forming another word.
  iiii oiii ooii oooi oooo is valid.
  oiii ioii iioi iiio is not valid - any of these words can be rearranged to form any other word.
  Under this new system policy, how many passphrases are valid?
*/
const fs = require('fs');
const assert = require('assert');

const input = fs.readFileSync('./day4/input.txt', { encoding: 'utf8' })
  .split(/\n/)
  .map(phrase => phrase.split(' '));

const input2 =[['apple', 'pear', 'leppa']];

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
  let isValid = true;
  const wordMapList = [];

  for (let i = 0; i < phrase.length; i++) {
    wordMapList.push(calculateWordMap(phrase[i]));
  }

  for (let i = 0; i < wordMapList.length; i++) {
    for (let j = 0; j < wordMapList.length; j++) {
      if (i !== j) {
        if (areWordsTheSame(wordMapList[i], wordMapList[j])) {
          isValid = false;
          break;
        }
      }
    }
    if (!isValid) {
      break;
    }
  }

  return isValid;
};

const calculateWordMap = word => {
  return word.split('').reduce((acc, curr) => {
    if (!acc.hasOwnProperty(curr)) {
      acc[curr] = {
        count: 1,
      };
      return acc;
    }
    acc[curr].count++;
    return acc;
  }, {});
};

const areWordsTheSame = (a, b) => {
  try {
    assert.deepEqual(a, b)
  } catch(e) {
    return false;
  }
  return true;
};

console.log(calculateValidPhrases(input));
