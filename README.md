# Meteoclima-Seasonal-Forecast
Methodology: Seasonal prediction’s significance lies on its ability to provide early warnings about oncoming and extreme weather episodes. The ACDG/HUA seasonal forecasts are obtained from annual ensemble simulations based on the WRF-ARW v3.5 model covering the entire globe. The ensemble simulations performed over a global domain of 256x128 grid points, on 1.4°x1.4° horizontal resolution, with time step of 10min and 32 vertical levels. The simulations were based on a modified version of the lagged average forecast (LAF) formulation introduced by Hoffman and Kalnay (1983). In a short range forecast the LAF method consists of ensemble members that include the latest operational forecast, and also forecasts for the same verification time started a few days earlier than the latest one. Thus each member includes the governing dynamics and it can be considered as a perturbation about the ensemble mean (Katsafados et al., 2014). In accordance to the LAF methodology, WRF annual simulations were initialized by global analyses assuming each analysis as a perturbation of the previous one due to the long lead time of 12 months ahead. Thus, the ensemble consists of 15 members with different initialization dates and different simulation lengths, but with identical end time (March 1st, 2016). In particular, each member was initialized by the Global Forecasting System (GFS) analyses on 00:00 UTC at the period 14-28 February 2015.

USGS DEM database (10x10min) was used for the definition of the domain topography, 16 categories of the FAO (10x10min) for the determination of soil type, and 24 categories of the USGS (10x10min) were used for the vegetation types, which are dynamically updated in the simulation. Real-time global (rtg) analysis data is used for the sea surface temperature (SST) during the initialization stage of each simulation and the monthly climatological NCEP/EMC SST is applied afterwords on a daily update frequency.

How to interpret the charts: In order to assign the estimated temperature anomaly, monthly averaged model outputs were compared against long term monthly means valid for the period of 1971 - 2000, released by the National Center for Environmental Predictions (NCEP) and NCAR (Kalnay et al., 1996). The shaded anomalies are considered as statistically significant in 95% confidence level. Spaghetti plots of the temperature at 850 hPa have been also produced as a guidance provision of each member uncertainty.

♦Consider the freely available charts as an under development research product and not as a guaranteed advisor using it for decision making.

 You can see the seasonal forecasts at the website of ACDG/HUA http://meteoclima.hua.gr/

Hoffman, R. N., and Kalnay, E.: Lagged averaged forecasting, an alternative to Monte Carlo forecasting, Tellus, 35A, pp. 100-118, 1983.

Kalnay, E., Kanamitsu, M., Kistler, R., Collins, W., Deaven, D., Gandin, L.,  Iredell, M., Saha, S., White, G., Woollen, J., Zhu, Y., Chelliah, M., Ebisuzaki, W., Higgins, W., Janowiak, J., Mo, K. C., Ropelewski, C., Wang, J., Leetmaa, A., Reynolds, R., Jenne, R., and Joseph, D.: The NMC/NCAR 40-Year Reanalysis Project, Bull. Amer. Meteor. Soc., 77, 437-471, 1996.

Katsafados P., A. Papadopoulos, G. Varlas, E. Papadopoulou, and E. Mavromatidis: Seasonal predictability of the 2010 Russian heat wave, Nat. Hazards Earth Syst. Sci., 14, 1531-1542, 2014.


The technical information about the Shell and NCL scripts which define the operation of Seasonal forecasting and are included in the first task of the project will be found here soon.

Περισσότερες πληροφορίες μπορείτε να βρείτε στο Wiki

Κώδικας με άδεια EUPL v1.1 και περιεχομένο με CC-BY-SA 4.0.
