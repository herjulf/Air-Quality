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

int cf1_to_sat(int cf1)
{
  int sat = -1;

  if(cf1<30) sat = cf1;
  if(cf1>100) sat = cf1 * 2/3;
  if(cf1 >=30 && cf1 <= 100) sat = 30 + cf1 * (cf1-30)/70 * 2/3;
  return sat;
}

// https://en.wikipedia.org/wiki/Air_quality_index#Computing_the_AQI

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

int air_quality_level(int pollutant)
{
// I = ((ihi - ilo)/(chi - clo) ) * (c - clo) + ilo



}
