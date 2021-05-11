/*
 * Authors: Ahmad Al-Astal, Mustafa Jaber
 */

#include <stdio.h>
#include "system.h"
#include <stdbool.h>
#include "alt_sys_init.c"
#include "altera_avalon_pio_regs.h"
#include "unistd.h"
#include "stdlib.h"

#define getBit(x,y) ((x) & (1 << ((y)-1))) != 0
//	  Write_Finish_Flag = getBit(IORD_ALTERA_AVALON_PIO_DATA(EVENT_REGISTER_BASE), 1);

int main()
{
  printf("Hello from Nios II!\n");
  int Address = 1;
  unsigned int Event_Register = 0;
  unsigned int Response_Register = 0;
  unsigned int Read_Data = 0;
  unsigned int Loading_Percentage = 0;
  char Read_Data_Characters[24];
  FILE* pScreenFile = NULL;

  while(1)
  {
	  /** Event_Register reads some external events happened outside Nios domain, such as WriteFinish_Flag */
	  Event_Register = IORD_ALTERA_AVALON_PIO_DATA(EVENT_REGISTER_BASE);

	  /** Create a .txt file to save pixel data to */
	  if (pScreenFile == NULL)
	  {
		  pScreenFile = fopen("/mnt/host/ScreenShot.txt", "w");
	  }

	  /** If writing to SRAM event is finished and no previous Nios response is detected then initiate a new reading event from Nios */
	  if (Event_Register > 0 && Response_Register == 0)
	  {
		  IOWR_ALTERA_AVALON_PIO_DATA(ADDRESS_BASE, Address);
		  Read_Data = IORD_ALTERA_AVALON_PIO_DATA(DATA_BASE);
		  IOWR_ALTERA_AVALON_PIO_DATA(LOADING_PERCENTAGE_BASE, Loading_Percentage);

		  itoa(Read_Data, Read_Data_Characters, 10);
		  fprintf(pScreenFile,"%s\n", Read_Data_Characters);

		  Address++;
		  Loading_Percentage = ((float)Address / 614399) * 100;
		  /** After finish streaming the data stored in SRAM, Nios will response to this by raising the Nios_Finish_Reading_Flag and setting the reading address again */
		  /** to zero to prepare for future reading events */
		  if (Address == 614399) //614399
		  {
			  Response_Register = 1;
			  IOWR_ALTERA_AVALON_PIO_DATA(RESPONSE_REGISTER_BASE, Response_Register);

			  /** Reset the address and write the reseted address to the address bus */
			  Address = 1;
			  IOWR_ALTERA_AVALON_PIO_DATA(ADDRESS_BASE, Address);
			  fclose(pScreenFile);
		  }
	  }
	  /** The external WriteFinish_Flag must be set to zero to begin new writing event to SRAM, in other words a new ScreenShot order is be given */
	  else if (Event_Register == 0)
	  {
		  Response_Register = 0;
		  pScreenFile = NULL;
		  IOWR_ALTERA_AVALON_PIO_DATA(RESPONSE_REGISTER_BASE, Response_Register);
	  }
  }
  return 0;
}
