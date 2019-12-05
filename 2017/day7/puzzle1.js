/*
  --- Day 7: Recursive Circus ---

  Wandering further through the circuits of the computer, you come upon a tower of programs that have gotten themselves into a bit of trouble. A recursive algorithm has gotten out of hand, and now they're balanced precariously in a large tower.

  One program at the bottom supports the entire tower. It's holding a large disc, and on the disc are balanced several more sub-towers. At the bottom of these sub-towers, standing on the bottom disc, are other programs, each holding their own disc, and so on. At the very tops of these sub-sub-sub-...-towers, many programs stand simply keeping the disc below them balanced but with no disc of their own.

  You offer to help, but first you need to understand the structure of these towers. You ask each program to yell out their name, their weight, and (if they're holding a disc) the names of the programs immediately above them balancing on that disc. You write this information down (your puzzle input). Unfortunately, in their panic, they don't do this in an orderly fashion; by the time you're done, you're not sure which program gave which information.

  For example, if your list is the following:

  pbga (66)
  xhth (57)
  ebii (61)
  havc (66)
  ktlj (57)
  fwft (72) -> ktlj, cntj, xhth
  qoyq (66)
  padx (45) -> pbga, havc, qoyq
  tknk (41) -> ugml, padx, fwft
  jptl (61)
  ugml (68) -> gyxo, ebii, jptl
  gyxo (61)
  cntj (57)
  ...then you would be able to recreate the structure of the towers that looks like this:

                  gyxo
                /
          ugml - ebii
        /      \
        |         jptl
        |
        |         pbga
      /        /
  tknk --- padx - havc
      \        \
        |         qoyq
        |
        |         ktlj
        \      /
          fwft - cntj
                \
                  xhth
  In this example, tknk is at the bottom of the tower (the bottom program), and is holding up ugml, padx, and fwft. Those programs are, in turn, holding up other programs; in this example, none of those programs are holding up any other programs, and are all the tops of their own towers. (The actual tower balancing in front of you is much larger.)

  Before you're ready to help them, you need to make sure your information is correct. What is the name of the bottom program?
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

console.log(rootNode[0].name);

// const leafNodeMap = nodes
//   .filter(node => node.children === null)
//   .reduce((acc, node) => {
//     acc[node.name] = {
//       name: node.name,
//       weight: node.weight,
//       children: node.children,
//     };
//     return acc;
//   }, {});

// const parentNodeMap = nodes
//   .filter(node => node.children !== null)
//   .reduce((acc, node) => {
//     acc[node.name] = {
//       name: node.name,
//       weight: node.weight,
//       children: node.children,
//     };
//     return acc;
//   }, {});

// for (let node in parentNodeMap) {
//   for (let i = 0; i < parentNodeMap[node].children.length; i++) {
//     if (leafNodeMap.hasOwnProperty(parentNodeMap[node].children[i])) {
//       parentNodeMap[node].children[i] = leafNodeMap[parentNodeMap[node].children[i]];
//     }
//   }
// }

// console.log(parentNodeMap);

// const treeMap = nodes
//   .reduce((acc, node) => {
//     acc[node.name] = {
//       name: node.name,
//       weight: node.weight,
//       children: node.children
//     };
//     return acc;
//   }, {});


// console.log(treeMap);

// const buildTree = (treeMap) => {

  // for (node in treeMap) {
  //   if (treeMap[node].children !== null) {
  //     let children = treeMap[node].children;
  //     for (let i = 0; i < children.length; i++) {
  //       if (treeMap[children[i]].children === null) {
  //         children[i] = treeMap[children[i]];
  //         delete treeMap[children[i]];
  //       }
  //     }
  //     // treeMap[node].children = children;

  //     // treeMap[node].children = children.map(nodeName => treeMap[nodeName]);
  //     // for (nodeName of children) {
  //     //   delete treeMap[nodeName];
  //     // }
  //   }
  // }

  // for (node in treeMap) {
  //   if (treeMap[node].children !== null) {
  //     for (let child of children) {
  //       if (treeMap[child].children === null) {

  //       }
  //     }
  //   }
  // }

  // return treeMap;
// };

// console.log(buildTree(treeMap));
// buildTree(treeMap);
