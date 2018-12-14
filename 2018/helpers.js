module.exports.formatGrid = grid => {
  const HEIGHT = grid.length;
  const WIDTH = grid[0].length;

  let gridToPrint = '';

  for (let y = 0; y < HEIGHT; y++) {
    for (let x = 0; x < WIDTH; x++) {
      let gridValue = grid[y][x];

      if (x === WIDTH - 1) {
        gridToPrint += `${gridValue}\n`;
      } else {
        gridToPrint += `${gridValue}\t`;
      }
    }
  }

  return gridToPrint;
};

module.exports.gridToCSV = grid => {};
