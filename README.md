# SimEngineBenchmark

## Introduction
Research on fault diagnosis and fault isolation on highly nonlinear dynamic systems such as the engine of a vehicle has garnered huge interest in recent years, especially with the automotive industry heading towards autonomous operations and big data. This simulation benchmark model of a single turbocharged petrol engine engine system is designed and developed for testing and evaluation of residuals generation and fault diagnosis methods. 

This benchmark model will serve as an excellent platform to demonstrate the effectiveness in simulating and presenting results on the fault diagnostic of automotive systems for the development and comparison of current and future research methods as well as for teaching initiatives. The engine model used is based on the mean value engine model (MVEM) with a PI-based boost controller. The benchmark is programmed in the MATLAB/Simulink environment and it provides realistic simulations of the engine system with a selection of faults of interest and industrial-standard driving cycles via a GUI interface. The simulation kit is available free and as an open-source, and distribued under the [GNU license](https://en.wikipedia.org/wiki/GNU_General_Public_License). 

If you use this benchmark model in your research, please cite the following publication:
- K. Y. Ng, E. Frisk, M. Krysander, and L. Eriksson, "A Single Turbocharged Petrol Engine System as a
Simulation Benchmark Model for Fault Diagnosis", 2019.


## Modelling The Engine
The simulation environment uses a 1.8L 4-cylinder single turbocharged spark ignited (TCSI) petrol engine as the benchmark. It consists of the following subsystems: Air filter, Compressor, Intercooler, Throttle, Intake manifold, Engine block, Exhaust manifold, Turbine, Wastegate, and Exhaust system. The engine system is modelled using dynamical equations that describe the air flow through the subsystems in the engine. These equations are derived based on the mean value engine model (MVEM) for a single turbocharged petrol engine as reported by Eriksson in the following paper:
- [L. Eriksson. "Modeling and control of turbocharged SI and DI engines," *Oil & Gas Science and Technology-Revue de l'IFP*, 62(4), pp.523-538, 2007.](https://ogst.ifpenergiesnouvelles.fr/articles/ogst/abs/2007/04/ogst06101/ogst06101.html)

<p><img src="/Figures/EngineDiag.png" width="500" align="right"><span>A PI-based boost controller with anti-windup is used to produce the control inputs: Throttle effective area and Wastegate actuator for the turbocharger. In addition to the control inputs, the engine has the following actuators: Reference engine speed, Air-fuel ratio, Ambient pressure, and Ambient temperature. In addition, the engine has the following sensor measurements: Temperatures (compressor, intercooler, intake manifold), Pressures (compressor, intercooler, intake manifold, exhaust manifold), Air filter mass flow, and Engine torque.</span></p>

The new European standard Worldwide harmonised Light vehicle Test Procedure (WLTP) driving cycle is used to verify the performance of the boost controller.


## Fault Scenarios
The benchmark model considers sensor, actuator, and variable faults in different parts of the engine system. There are 11 faults; 6 variable faults (*fp_af*, *fC_vol*, *fW_af*, *fW_th*, *fW_c*, *fW_ic*), 1 actuator measurement fault (*fx_th*), and 4 sensor measurement faults (*fyW_af*, *fyp_im*, *fyp_ic*, *fyT_ic*).

The faults are of different degrees of severity. Some faults are less severe and the engine can be reconfigured to a reduced performance operation mode to accommodate the faults until the vehicle is sent into the workshop for repair and maintenance. Some other faults are more severe that if not detected and isolated promptly, might cause permanent and serious damages to the engine system, which in turn will endanger the occupants in the vehicle as well as other road users.
