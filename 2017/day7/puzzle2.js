/*
--- Part Two ---
The programs explain the situation: they can't get down. Rather, they could get down, if they weren't expending all of their energy trying to keep the tower balanced. Apparently, one program has the wrong weight, and until it's fixed, they're stuck here.

For any program holding a disc, each program standing on that disc forms a sub-tower. Each of those sub-towers are supposed to be the same weight, or the disc itself isn't balanced. The weight of a tower is the sum of the weights of the programs in that tower.

In the example above, this means that for ugml's disc to be balanced, gyxo, ebii, and jptl must all have the same weight, and they do: 61.

However, for tknk to be balanced, each of the programs standing on its disc and all programs above it must each match. This means that the following sums must all be the same:

ugml + (gyxo + ebii + jptl) = 68 + (61 + 61 + 61) = 251
padx + (pbga + havc + qoyq) = 45 + (66 + 66 + 66) = 243
fwft + (ktlj + cntj + xhth) = 72 + (57 + 57 + 57) = 243
As you can see, tknk's disc is unbalanced: ugml's stack is heavier than the other two. Even though the nodes above ugml are balanced, ugml itself is too heavy: it needs to be 8 units lighter for its stack to weigh 243 and keep the towers balanced. If this change were made, its weight would be 60.

Given that exactly one program is the wrong weight, what would its weight need to be to balance the entire tower?
*/

const fs = require('fs');

const nodes = fs.readFileSync('./day7/input.txt', { encoding: 'utf8' }).split(/\n/)
  .map(line => {
    let children, name, weight, parent;

    if (line.includes('->')) {
      line = line.split(' -> ');
      parent = line[0].split(' ');
      children = line[1].split(', ');
    } else {
      parent = line.split(' ');
      children = null;
    }

    name = parent[0];
    weight = parseInt(parent[1].match(/\d/g).join(''));

    return {
      name,
      weight,
      children,
    }
  });

const nodeMap = nodes
  .reduce((acc, node) => {
    acc[node.name] = {
      name: node.name,
      weight: node.weight,
      children: node.children,
    };
    return acc;
  }, {});

nodes.forEach(node => {
  if (node.children !== null) {
    node.children.forEach(child => nodeMap[child].parent = node.name);
  }
});

const rootNode = Object.keys(nodeMap)
  .map(key => nodeMap[key])
  .filter(node => !node.hasOwnProperty('parent'));

function buildTree(node, nodeMap) {
  if (typeof node === 'string') {
    node = nodeMap[node];
  } else {
    node = nodeMap[node.name];
  }

  if (node.children === null) {
    node.totalWeight = node.weight;
    return node;
  }

  for (let i = 0; i < node.children.length; i++) {
    node.children[i] = buildTree(node.children[i], nodeMap);
  }

  node.totalWeight = node.children.reduce((acc, curr) => acc + curr.totalWeight, 0);
  node.totalWeight += node.weight;

  return node;
}

// function printTree(tree) {
//   if (tree.children === null) {
//     console.log(tree.name);
//     return;
//   }
//   console.log(tree.name);

//   for (let i = 0; i < tree.children.length; i++) {
//     printTree(tree.children[i]);
//   }
// }

const calculateWrongWeight = tree => {
  if (tree.children === null) {
    return;
  }

  for (let i = 0; i < tree.children.length; i++) {
    let wrongNode = calculateWrongWeight(tree.children[i]);
    if (wrongNode) {
      return wrongNode;
    }
  }

  // let wrongNode = null;
  // const comparison = tree.children[0].totalWeight;
  // const isWrong = tree.children.forEach(node => {
  //   if (node.totalWeight !== comparison) {
  //     wrongNode = tree.name;
  //   }
  // })
  const comparison = tree.children[0].totalWeight;
  const wrongIndex = tree.children.findIndex(value => {
    return value.totalWeight !== comparison;
  });

  if (wrongIndex > 0) {
    return tree.children[wrongIndex].name;
  }
  return;
};

const tree = buildTree(rootNode[0], nodeMap);
const wrongChild = calculateWrongWeight(tree);
//wrong node -> oewlch
// console.log(nodeMap[nodeMap['oewlch'].parent]);
// console.log(rootNode[0]);

fs.writeFileSync('testing.json', JSON.stringify(rootNode[0]), 'utf8');
const wrongParent = nodeMap[wrongChild].parent;
console.log(wrongParent);

//final answer 1526
