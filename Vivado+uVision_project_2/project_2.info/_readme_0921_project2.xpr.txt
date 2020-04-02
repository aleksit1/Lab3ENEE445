This project is extracted from "archive_of_0920_from_DELL7010project_2.xpr--had_working_updatemem.zip" where we first got updatemem to work. 
We are trying to see if we can repeat that success without breaking anything in the original.

	- everything in the directory above where 'project_2.xpr' resides is _not_ in the archive, e.g., all of our .bat, .bit, etc, files. We make a copy of everything having to do the the 8051, the .bat, .mmi files and put them in C:\_umd\_2018-09-01\445_F18\_work\0921_project_2.xpr\project_2\project_2.8051, e.g. at the same level as the .xpr file in the hopes that they will be archived with the project. 

	Question: after starting Vivado from the icon we (eventually) get the Startup page after the .bat file times out. If the tcl console is open (or we open it from the 'Window' dropdown) and type 'dir', we are in C:\Users\wmh3\AppData\Roaming\Xilinx\Vivado,, e.g. well removed from our project. Then after we open the Vivado project the tcl console is still at the directory in C:\Users\....
	
	- from the tcl console: change the tcl working directory :
	cd C:\\_umd\\_2018-09-01\\445_F18\\_work\\0921_project_2.xpr\\project_2\\project_2.8051
	
	- from the tcl console: get a copy of the project's .bit file
	copy ..\\project_2.runs\\impl_1\\top.bit oldtop.bit
	
	- from the tcl console: display what's in the current directory
	dir
		WARNING: [Common 17-259] Unknown Tcl command 'dir' sending command to the OS shell for execution. It is recommended to use 'exec' to send the command to the OS shell.
		 Volume in drive C has no label.
		 Volume Serial Number is B4B1-3528

		 Directory of C:\_umd\_2018-09-01\445_F18\_work\0921_project_2.xpr\project_2\project_2.8051

		09/21/2018  03:48 PM    <DIR>          .
		09/21/2018  03:48 PM    <DIR>          ..
		09/20/2018  01:36 PM               499 4Kx8_X1_Y6_bram.mmi
		09/21/2018  03:20 PM    <DIR>          8051_code
		09/21/2018  12:42 PM            12,294 atrawhex.mem
		09/19/2018  11:01 PM         2,192,112 oldtop.bit
		09/21/2018  03:20 PM    <DIR>          tools
					   3 File(s)      2,204,905 bytes
					   4 Dir(s)  75,838,701,568 bytes free

	
	- from the tcl console: edit the oldtop.bit into newtop.bit
	updatemem -meminfo 4Kx8_X1_Y6_bram.mmi -data atrawhex.mem -proc dummy -bit oldtop.bit -out newtop.bit -force -debug
	
	updatemem -meminfo 4Kx8_X1_Y6_bram.mmi -data atrawhex.mem -proc dummy -bit oldtop.bit -out newtop.bit -force -debug
		WARNING: [Common 17-259] Unknown Tcl command 'updatemem -meminfo 4Kx8_X1_Y6_bram.mmi -data atrawhex.mem -proc dummy -bit oldtop.bit -out newtop.bit -force -debug' sending command to the OS shell for execution. It is recommended to use 'exec' to send the command to the OS shell.

		****** updatemem v2018.2 (64-bit)
		  **** SW Build 2258646 on Thu Jun 14 20:03:12 MDT 2018
		  **** IP Build 2256618 on Thu Jun 14 22:10:49 MDT 2018
			** Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.

		source C:/Xilinx/Vivado/2018.2/scripts/updatemem/main.tcl -notrace
		Command: update_mem -meminfo 4Kx8_X1_Y6_bram.mmi -data atrawhex.mem -proc dummy -bit oldtop.bit -out newtop.bit -force -debug

		Dump the BRAM Initialization Strings. 
		  ^^^ Bitlane with BRAM Location: RAMB36_X1Y6
		  INIT_00:FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF400802
		  INIT_01:FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
				< I snipped everything between the above and the below >
		  INIT_7E:FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
		  INIT_7F:FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

		Loading bitfile oldtop.bit
		Loading data files...
		Updating memory content...
		Creating bitstream...
		Writing bitstream newtop.bit...
		0 Infos, 0 Warnings, 0 Critical Warnings and 0 Errors encountered.
		update_mem completed successfully
		update_mem: Time (s): cpu = 00:00:13 ; elapsed = 00:00:29 . Memory (MB): peak = 487.574 ; gain = 430.172
		INFO: [Common 17-206] Exiting updatemem at Fri Sep 21 16:02:02 2018...

	
	- from the tcl console:
		
		dir *.bit
		 Volume in drive C has no label.
		 Volume Serial Number is B4B1-3528

		 Directory of C:\_umd\_2018-09-01\445_F18\_work\0921_project_2.xpr\project_2\project_2.8051

		09/21/2018  04:02 PM         2,192,112 newtop.bit
		09/19/2018  11:01 PM         2,192,112 oldtop.bit
					   2 File(s)      4,384,224 bytes
					   0 Dir(s)  75,841,196,032 bytes free


