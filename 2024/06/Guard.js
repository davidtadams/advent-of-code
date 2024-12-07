
class Guard {
  #currentX;
  #currentY;
  #currentDirection;
  #visited;

  constructor(initialX, initialY, initialDirection) {
    this.#currentX = initialX;
    this.#currentY = initialY;
    this.#currentDirection = initialDirection;
    this.#visited = new Set([JSON.stringify([initialX, initialY])]);

    this.stillOnGrid = true;
  }

  get visited() {
    return Array.from(this.#visited).map(coordinates => JSON.parse(coordinates));
  }

  visitedCount() {
    return this.#visited.size;
  }

  move(grid) {
    if (!this.stillOnGrid) {
      throw new Error('Tried to move when no longer on the grid');
    }

    if (this.#currentDirection === '^') {
      this.#makeMove(grid, this.#currentX, this.#currentY - 1);
    } else if (this.#currentDirection === '>') {
      this.#makeMove(grid, this.#currentX + 1, this.#currentY);
    } else if (this.#currentDirection === 'v') {
      this.#makeMove(grid, this.#currentX, this.#currentY + 1);
    } else if (this.#currentDirection === '<') {
      this.#makeMove(grid, this.#currentX - 1, this.#currentY);
    }
  }

  #makeMove(grid, newX, newY) {
    if (this.#checkIfStillOnGrid(grid, newX, newY)) {
      if (grid[newY][newX] === '#') {
        this.#rotateDirection();
      } else {
        this.#currentX = newX;
        this.#currentY = newY
        this.#visited.add(JSON.stringify([newX, newY]));
      }
    } else {
      this.stillOnGrid = false;
    }
  }

  #rotateDirection() {
    if (this.#currentDirection === '^') {
      this.#currentDirection = '>';
    } else if (this.#currentDirection === '>') {
      this.#currentDirection = 'v';
    } else if (this.#currentDirection === 'v') {
      this.#currentDirection = '<';
    } else if (this.#currentDirection === '<') {
      this.#currentDirection = '^';
    }
  }

  #checkIfStillOnGrid(grid, x, y) {
    const X_MAX = grid[0].length - 1;
    const Y_MAX = grid.length - 1;

    return x >= 0 && y >= 0 && x <= X_MAX && y <= Y_MAX;
  }
}

module.exports = Guard;
