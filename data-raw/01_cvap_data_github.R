# Note: this file is meant for my OneDrive setup and is not project friendly.
# Adjust for your own needs as you see fit.
dir <- 'D:/OneDrive - Harvard University/CVAP/CVAP_2005-2009_ACS_csv_files/CVAP Files'

for (yr in 2009:2010) {
  x1 <- stringr::str_glue('{yr-5}-{yr-1}')
  x2 <- stringr::str_glue('{yr-4}-{yr}')

  dir <- stringr::str_replace(dir, x1, x2)
  process_cvap_dir(dir, year = yr, out_dir = 'D:/GitHub/cvap_data')
}

dir <- 'D:/OneDrive - Harvard University/CVAP/CVAP_2007-2011_ACS_csv_files'

for (yr in 2011:2019) {
  x1 <- stringr::str_glue('{yr-5}-{yr-1}')
  x2 <- stringr::str_glue('{yr-4}-{yr}')

  dir <- stringr::str_replace(dir, x1, x2)
  process_cvap_dir(dir, year = yr, out_dir = 'D:/GitHub/cvap_data')
}

dir <- 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2016-2020_ACS_csv_files'
cvap_process_dir(dir, year = 2020, out_dir = '~/GitHub/cvap_data')

dir <- 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2017-2021_ACS_csv_files'
curl::curl_download(cvap_census_url(year = 2021), destfile = 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2017-2022_ACS_csv_files.zip')
zip::unzip('~/../Downloads/CVAP_2017-2021_ACS_csv_files.zip', exdir = dir)
cvap_process_dir(dir, year = 2021, out_dir = '~/GitHub/cvap_data')

dir <- 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2018-2022_ACS_csv_files'
curl::curl_download(cvap_census_url(year = 2022), destfile = 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2018-2022_ACS_csv_files.zip')
zip::unzip('C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2018-2022_ACS_csv_files.zip', exdir = dir)
cvap_process_dir(dir, year = 2022, out_dir = '~/GitHub/cvap_data')

dir <- 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2019-2023_ACS_csv_files'
curl::curl_download(cvap_census_url(year = 2023), destfile = 'C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2019-2023_ACS_csv_files.zip')
zip::unzip('C:/Users/chris/OneDrive - Harvard University/CVAP/CVAP_2019-2023_ACS_csv_files.zip', exdir = dir)
cvap_process_dir(dir, year = 2023, out_dir = '~/GitHub/cvap_data')
