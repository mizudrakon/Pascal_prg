Welcome to GGS (Glorified Glider Simulator)!
GGS is a text based Conway's Game of Life alternative that allows you to do basicly everything traditional Game of Life does:
	1. insert a pattern of life cells into a two dimensional field;
	2. watch it evolve in accordance with a few basic rules:
		2.1.For a space that is 'populated':
			a)Each cell with one or no neighbors dies, as if by solitude.
			b)Each cell with four or more neighbors dies, as if by overpopulation.
			c)Each cell with two or three neighbors survives.
		2.2.For a space that is 'empty' or 'unpopulated'
			d)Each cell with three neighbors becomes populated.
GGS works exactly alike for any patterns of 1s and 0s, but also allows insertion of cells with greater survivability (up to nine generation) and cells that are immortal, so you can see how unbalanced the whole thing becomes with such nonsense.

It uses algorithm that chacks every cell in spcified boundaries by counting live cells in a square of 9 with the cell as its center:
	1.For exactly 3 living cells, the central one lives whatever its current state;
	2.For exactly 4, the central one keeps its current state;
	3.For any other number the centeral dies or stays dead.
Boundaries are set up as extreme numbers of rows and columns that contain living cells and are chancked each iteration.
This playfield is looped, so patternes can migrate over the edges to opposite ends of the field. This can result in some not exactly nice outcomes since pattern like 11 that starts at 512 and ends at 1 will be writen out as 1....(510dots)....1, so beware!

interface works like this:
* Write 's' or 'S' to stop the program (mark the end of pattern input in part 3.) - this is also the only formal way how to stop the program.
* Write 'help' to see this document again.

1. Specify first row and column of your pattern input:
   row: integer in specified range (1-max)		i.e.:	row:1
   column: integer in specified range (1-max)			column:1

2. Pattern input:
  0  			dead cell
  x,X,n,N		no change
  1,2,3,4,5,6,7,8,9 	live cell (number of generation cell can survive on its own)
  i,I			immortal cell
  e,E			mark the end of row
  s,S,q,Q		mark the end of pattern (and press ENTER)
  every other symbol is meaningless

	i.e.:	01e			0i0ie
		001e			00ie
		111s 			iiiiis
	to make a glider :)		to make Immortan Joe

3. Do you wish to insert another pattern? * 'y' lets you do it (calls 1.)
					  * 'n'	continues to 4.

4. Number of generations:* integer (1-512)
			 * or 's' ('S' or just 'stop' to stop the program)
			 * 'insert' will let you add another pattern to the existing one
			  (calls 1.)

5. How many symbols fit on your screen?
	* if the relevant part of the playfield gets too large, you can choose to divide it into multiple parts that will be written out succesively. It is strongy recommanded to avoid this and set max on the second line of game.pas to already fitting number.

There are three demos: 	GliderCrash - crashes two gliders;
			ImmortanJoe - just some pattern made out of immortal cells;
			FuryRoad    - gliders 'sort of' race, crash, big explosion in the end.

Have fun!!!
