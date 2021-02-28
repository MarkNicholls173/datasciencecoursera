unzip("annual_conc_by_monitor_1999.zip", exdir = getwd())
unzip("annual_conc_by_monitor_2012.zip", exdir = getwd())

dat_1999 <- readr::read_csv("annual_conc_by_monitor_1999.csv")

head(dat_1999)
dat_1999

dat_2012 <- readr::read_csv("annual_conc_by_monitor_2012.csv")
