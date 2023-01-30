# rng_self_calib
Digital CPU peripheral for calibrating a pseudo-random-number generator, based on the attached paper by Intel 
"A 4Gbps 0.57pJ/bit Process-Voltage-Temperature Variation Tolerant
All-Digital True Random Number Generator in 45nm CMOS:
The rng_self_calib controller follows Fig. 7 in the reference 
paper, generating control bits nconf[3:0] and pconf[3:0] as needed.
