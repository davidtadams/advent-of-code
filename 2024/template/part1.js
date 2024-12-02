const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const lines = input.split('\n');

console.log(lines);
