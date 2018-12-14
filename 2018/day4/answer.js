/*
  Problem Part 1: https://adventofcode.com/2018/day/4
  Problem Part 2: https://adventofcode.com/2018/day/4#part2
*/

// const { simpleInput: input } = require('./input');
const { input } = require('./input');

/*
  steps:
  - map input to data points
  - sort input by date
  - collect data per guard
  - find guard who slept the most
  - find minute slept most for guard who slept most
*/

/*
  Map the input into consumable data points
*/
const inputData = input.map(dataPoint => {
  const date = new Date(dataPoint.match(/\[(.*)\]/)[1]);
  const minutes = date.getMinutes();
  const hours = date.getHours();
  let monthDate;

  if (hours !== 0) {
    monthDate = `${date.getMonth()}-${date.getDate() + 1}`;
  } else {
    monthDate = `${date.getMonth()}-${date.getDate()}`;
  }

  let guardToken = dataPoint.match(/\#(.*?)\s/);
  const guardId = guardToken ? guardToken[1] : null;

  let wakeUp = false;
  let fallAsleep = false;

  if (dataPoint.indexOf('wakes up') > -1) {
    wakeUp = true;
  }

  if (dataPoint.indexOf('falls asleep') > -1) {
    fallAsleep = true;
  }

  return {
    date,
    monthDate,
    minutes,
    guardId,
    wakeUp,
    fallAsleep,
  };
});

/*
  Sort inputs by data in ascending order
*/
const sortedInput = inputData.sort((a, b) => {
  return a.date.getTime() - b.date.getTime();
});

/*
  gather all nap data per guard
*/
const guardData = sortedInput.reduce((acc, dataPoint) => {
  const { guardId, monthDate, fallAsleep, wakeUp, minutes } = dataPoint;

  if (guardId) {
    acc.guardId = guardId;

    if (!acc.hasOwnProperty(guardId)) {
      acc[guardId] = {
        shifts: [],
        totalSleepTime: 0,
        minutesSlept: {},
      };
    }

    acc[guardId].shifts.push({
      date: monthDate,
      naps: [],
      totalNapTime: 0,
    });
  } else {
    const guardEntry = acc[acc.guardId];
    const lastGuardShift = guardEntry.shifts[guardEntry.shifts.length - 1];

    if (fallAsleep) {
      lastGuardShift.naps.push({ start: minutes });
    }

    if (wakeUp) {
      const nap = lastGuardShift.naps.pop();
      nap.end = minutes;
      nap.total = nap.end - nap.start;
      lastGuardShift.naps.push(nap);
      lastGuardShift.totalNapTime += nap.total;
      guardEntry.totalSleepTime += nap.total;

      for (let i = nap.start; i < nap.end; i++) {
        if (guardEntry.minutesSlept.hasOwnProperty(i)) {
          guardEntry.minutesSlept[i] = guardEntry.minutesSlept[i] + 1;
        } else {
          guardEntry.minutesSlept[i] = 1;
        }
      }
    }
  }

  return acc;
}, {});

/*
  Find out which guard slept the most
*/
let guardIdWhoSleptMost = null;
let highestSleepTime = 0;

for (let guardId in guardData) {
  const totalSleepTime = guardData[guardId].totalSleepTime;

  if (totalSleepTime > highestSleepTime) {
    highestSleepTime = totalSleepTime;
    guardIdWhoSleptMost = guardId;
  }
}

/*
  Find out what minute that guard slept the most
*/
let minuteSleptMost;
let highestSleepPerMinute = 0;

for (let minute in guardData[guardIdWhoSleptMost].minutesSlept) {
  const minuteCount = guardData[guardIdWhoSleptMost].minutesSlept[minute];

  if (minuteCount > highestSleepPerMinute) {
    highestSleepPerMinute = minuteCount;
    minuteSleptMost = minute;
  }
}

/*
  Answer for part 1
*/
const ANSWER1 = guardIdWhoSleptMost * minuteSleptMost;

console.log('ANSWER PART 1', ANSWER1);

/*
  Answer for part 2
*/

let guardWithHighestMinute = null;
let minuteWithHighestCount = null;
let highestMinuteSleepCount = 0;

for (let guardId in guardData) {
  for (let minute in guardData[guardId].minutesSlept) {
    const minuteCount = guardData[guardId].minutesSlept[minute];

    if (minuteCount > highestMinuteSleepCount) {
      highestMinuteSleepCount = minuteCount;
      minuteWithHighestCount = minute;
      guardWithHighestMinute = guardId;
    }
  }
}

const ANSWER2 = guardWithHighestMinute * minuteWithHighestCount;

console.log('ANSWER PART 2', ANSWER2);
