#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>


/*

2017-05-30

From:

http://www.rigacci.org/wiki/lib/exe/fetch.php/doc/appunti/hardware/raspberrypi/pms5003-and-pms7003-experiment.pdf

Note that the PMS data from the Sensor comes in two flavors: (Standard
Particles or CF-1, bytes 4-9) and  (Atmospheric Environment, bytes 10-15). 
It is the second one which we use for this experiments


CF1 refers to Std. Particle, SAT refers to Std. Atmosphere 

The almost too perfect correlation between approx. 30 mg to 100 mg 
for PM2.5 / PMS5003, (40mg to 150 for PM10) does not sound too scientific...

cf1<30 ⇒ sat = cf1
cf1>100 ⇒ sat = cf1 * 2/3
cf1 in ∈ [30;100] ⇒ sat = 30 + cf1 * (cf1-30)/70 * 2/3

The AQI is based on the US EPA breakpoints. For PM1, the PM2.5  
breakpoints are used.

Real-time data 
db stands for dust bin and is measured in counts per minute. For instance, 
db2.5-um represents the count of particles with an aerodynamic diameter 
below 2.5 μm;


*/

/* V = 4/3 * 3.141592 * r * r * r = 4.18879 * r * r * r

0.3 um   --> 0.003375 *  4.18879 =  0.014137166
0.5 um   --> 0.015625 * 4.18879  =  0.0654498
  1 um   --> 0.125 *  4.18879    =  0.52359
  2.5 um --> 1.953125 *  4.18879 =  8.181230
  5 um    --> 15.625 *  4.18879  =  65.44984
 10 um    --> 125    *  4.18879  =  523.59


 ATM    13   15   17  
 DB   2274  501   47    5    1    1

 2274 * 0.014137166 = 32.147915484
 501 * 0.0654498    = 32.7903498
 47 * 0.52359       = 24.60873
 5 * 8.181230       = 40.906150
 1 * 65.44984       = 65.44984
 1 * 523.59         = 523.59

*/


int cf1_to_sat(int cf1)
{
  int sat = -1;

  if(cf1<30) sat = cf1;
  if(cf1>100) sat = cf1 * 2/3;
  if(cf1 >=30 && cf1 <= 100) sat = 30 + cf1 * (cf1-30)/70 * 2/3;
  return sat;
}

// https://en.wikipedia.org/wiki/Air_quality_index#Computing_the_AQI

#if 0

int aqi[] = {
  0,  //50,
  51. //100,
  101, //150,
  151, //200,
  201, //300,
  301, //400,
  401,  //500 MAX
  500
};
  
char foo[] = {"Good", "Moderate", "Rel. Unhealthy",  "Unhealthy", "Very Unhealthy", "Hazardous"};

double pm2_5[] = {0.0, 12.0,
		  12.1, 35.4, 
		  35.5, 55.4, 
		  55.5, 150.4, 
		  150.5, 250.4,
		  250.5,  350.4, 
		  350.5, 500.4
};

int air_quality_level(double in, int pollutant)
{

// I = ((ihi - ilo)/(chi - clo) ) * (c - clo) + ilo

}

#endif

/* V = 4/3 * 3.141592 * r * r * r = 4.18879 * r * r * r

0.3 um   --> 0.003375 *  4.18879 =  0.014137166
0.5 um   --> 0.015625 * 4.18879  =  0.0654498
  1 um   --> 0.125 *  4.18879    =  0.52359
  2.5 um --> 1.953125 *  4.18879 =  8.181230
  5 um    --> 15.625 *  4.18879  =  65.44984
 10 um    --> 125    *  4.18879  =  523.59


 ATM    13   15   17  
 DB   2274  501   47    5    1    1
*/

double mass(double r, int cnt, double dens)
{
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

double mass10(double cnt, double dens)
{
  double r = 7.5/2;
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

double mass5(double cnt, double dens)
{
  double r = (5+2.5)/4;
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

double mass2_5(double cnt, double dens)
{
  double r = (2.5+1)/4;
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

double mass1_0(double cnt, double dens)
{
  double r = (1+0.5)/4;
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

double mass0_5(double cnt, double dens)
{
  double r = (0.5+0.3)/4;
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

double mass0_3(double cnt, double dens)
{
  double r = (0.3)/2;
  cnt = cnt * 2; /* 50% effcieny for PMS5003 */
  return ((4./3.) * 3.141592 * r * r * r) * cnt * dens;
}

ex1()
{
  double dens = 1;
  double b0_3, b0_5, b1, b2_5, b5, b10; 

  b0_3 = 2274;
  b0_5 = 501;
  b1 = 47;
  b2_5 = 5;
  b5 = 1;
  b10 = 1;
  
  printf("0_3=%-6.2f 0_5=%-6.2f 1.0=%-6.2f 2.5=%-6.2f 5=%-6.2f 10=%-6.2f\n", 
	 mass0_3(b0_3, dens), mass0_5(b0_5, dens), mass1_0(b1, dens), 
	 mass2_5(b2_5, dens),
	 mass5(b5, dens),
	 mass10(b10, dens)
	 );
}

struct tag {
  char buf[40];
};
struct tag t[40];
unsigned int year, mon, day, hour, min, sec;
struct timeval tv;

unsigned long our_mktime(const unsigned int year0, const unsigned int mon0,
       const unsigned int day, const unsigned int hour,
       const unsigned int min, const unsigned int sec)
{
	unsigned int mon = mon0, year = year0;

	/* 1..12 -> 11,12,1..10 */
	if (0 >= (int) (mon -= 2)) {
		mon += 12;	/* Puts Feb last since it has leap day */
		year -= 1;
	}

	return ((((unsigned long)
		  (year/4 - year/100 + year/400 + 367*mon/12 + day) +
		  year*365 - 719499
	    )*24 + hour /* now have hours */
	  )*60 + min /* now have minutes */
	)*60 + sec; /* finally seconds */
}


int time_parse(char *buf)
{
    int  res = sscanf(buf, 
		   "%4d-%2d-%2d %2d:%2d:%2d",
		      &year, &mon, &day, &hour, &min, &sec);
    
    return res;
}

const char *delim = " \t\r,";

int main(int ac, char *av[]) 
{
  char buf[BUFSIZ], buf1[BUFSIZ], *p;
  int i, j, k;
  int debug;
  char timebuf[40];
  int selpos;
  unsigned int db[6];
  double ddb[6];
  unsigned int pma[3];
  double dpma[6];
  double dens = 1;

  dens = 1.0;

  int obs;

  ex1();

  debug = 0;
  
  for(i=0; i < 6; i++)
    ddb[i] = 0;

  for(i=0; i < 3; i++)
    dpma[i] = 0;

  while ( fgets ( buf, BUFSIZ, stdin ) != NULL ) {

    obs++;
    time_parse(buf);
    printf("%04u-%02u-%02u %02u:%02u:%02u ",
	   year, mon, day, hour, min, sec);
    
    p = strtok( buf, delim);
    while(p) {
      p = strtok( NULL, delim );
      
      if (strncmp(p, "ATM", BUFSIZ) == 0) {
	for(i=0; i < 3; i++) {
	  p = strtok( NULL, delim );
	  j = sscanf(p, "%u", &pma[i]);
	  
	  dpma[i] += pma[i];
	  printf("%u ", pma[i]);
	}
      }

      if (strncmp(p, "DB", BUFSIZ) == 0) {
	for(i=0; i < 6; i++) {
	  p = strtok( NULL, delim );
	  j = sscanf(p, "%u", &db[i]);
	  
	  ddb[i] += db[i];
	  printf("%u ", db[i]);
	}
	printf("\n");
	break;
      }
    }
  }
  printf("No Observations = %d\n", obs);

  for(i=0; i < 6; i++) {
   ddb[i] =  ddb[i]/obs;
  }

  printf("Bin Averages:\t");
  for(i=0; i < 6; i++) {
    printf("%-5.2f ", ddb[i]);
  }
  printf("\n");

  for(i=0; i < 3; i++) {
    dpma[i] = dpma[i]/obs;
  }

  printf("Particle Density=%-4.2f g/cm**3\n", dens); 

  printf("Mass CALC PM:\tPM0.3=%-5.1f PM0.5=%-5.1f PM1.0=%-5.1f PM2.5=%-5.1f PM5=%-5.1f PM10=%-5.1f\n", 
	 mass0_3(ddb[0], dens), mass0_5(ddb[1], dens), mass1_0(ddb[2], dens), 
	 mass2_5(ddb[3], dens),
	 mass5(ddb[4], dens),
	 mass10(ddb[5], dens)
	 );

  printf("Plantower ATM:\tPM1.0=%-5.1f PM2.5=%-5.1f PM10=%-5.1f\n", 
	 dpma[0], dpma[1], dpma[2]);

}

