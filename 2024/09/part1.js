const fs = require('node:fs');

const path = process.argv[2] || 'simple_input.txt';

const input = fs.readFileSync(path, 'utf-8').trim();
const diskMap = input.split('');

// Take the disk map and create the file system

// take the file system array and de-frag it
// loop through the file system, have a pointer for the left half and a pointer for the right half
// start taking all the items on the right half and filling in the space on the left half
// stop the loop when the pointers touch

// calculate checksum

// print answer

