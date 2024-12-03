const fs = require('node:fs');
const R = require('remeda');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const reports = input.split('\n').map(line => line.split(' ').map(Number));

const isReportSafe = (report) => {
  const sortedReport = [...report].sort((a, b) => a - b);
  const reverseSortedReport = [...sortedReport].reverse();

  if (!R.isShallowEqual(report, sortedReport) && !R.isShallowEqual(report, reverseSortedReport)) {
    return false;
  }

  for (let i = 0; i < report.length - 1; i++) {
    const difference = Math.abs(report[i] - report[i + 1]);

    if (difference === 0 || difference > 3) {
      return false;
    }
  }

  return true;
};

const answer = reports.reduce((count, report) => {
  if (isReportSafe(report)) {
    count += 1;
  }

  return count;
}, 0);

console.log('answer', answer);
