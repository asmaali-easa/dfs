# Depth First Search
Basic Finite State Machine with Datapath (FSMD) example to executes a depth-first search beginning at vertex start in a graph with vertices 1, ... , n and outputs the vertices in the order in which they are visited.The graph is represented using adjacency lists; adj[i] is a reference to the first node in a linked list of nodes representing the vertices adjacent to vertex i.
Each node has members ver, the vertex adjacent to i, and next, the next node in the linked list or null, for the last node in the linked list. To track visited vertices, the algorithm uses an array visit; visit[i] is set to true if vertex i has been visited or to false if vertex i has not been visited.

# inputs and outputs
go: (in) set 1 to start the algorithm.
start: (in) the start node.
n: (in) the number of vertices.
print: (out) the visited vertices in order.
adj: this component represents the adjacency list and the linked lists, it takes a vertex as an input and gives the number of the first node in a linked list of nodes representing the vertices adjacent to vertex i as an output. it also takes the number of any node and gives the vertex of this node and the number of the next node.

## Install

These examples use [ModelSim&reg; and Quartus&reg; Prime from Intel FPGA](http://fpgasoftware.intel.com/?edition=lite), [GIT](https://git-scm.com/download/win), [Visual Studio Code](https://code.visualstudio.com/download), make sure they are installed locally on your computer before proceeding.

## Usage

1. Grab a copy of this repository to your computer's local folder (i.e. C:\projects):

    ```sh
    $ cd projects
    $ git clone https://github.com/asmaali-easa/dfs.git
    ```
2. Use Visual Studio Code (VSC) to edit and view the design files:

    ```sh
    $ cd dfs_algorithm
    $ code .
    ```
    Click on the toplevel.vhd file in the left pane to view its contents.
    
3. From the VSC View menu, choose Terminal, in the VCS Terminal, create a "work" library:

    ```sh
    $ vlib work
    ```
    
4. Compile all the design units:

    ```sh
    $ vcom *.vhd
    ```
    
5. Simulate your design.:

    ```sh
    $ vsim work.tb
    ```
