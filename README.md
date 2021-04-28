# cdc-vaccine-data

This is a daily scrape of CDC county-level vaccinations data. The data being
scraped is the data powering the CDC's [county view][cv] dashboard. This 
dashboard makes an HTTP request to the following URL, which is what we scrape:

```
https://covid.cdc.gov/covid-data-tracker/COVIDData/getAjaxData?id=vaccination_county_condensed_data
```

The `.json` returned only represents one day of county-level vaccination data -
it's not a timeseries. For this reason, we scrape it every day, and combine
all the `.json`'s together to form a timeseries, starting with 2020-04-15 (the
day we started scraping) and continuing until the present.

Each `.json` is basically an array of object, and the keys of these objects are
summarized below:

- `Date`: `YYYY-MM-DD`
- `FIPS`: 5-digit FIPS, unknown FIPS are coded as `UNK`
- `StateName`
- `StateAbbr`: For some reason, always 3 characters in length
- `County`: County name, sans "County", unknwon counties coded as `Unknown County`
- `Series_Complete_18Plus`
- `Series_Complete_18PlusPop_Pct`: Out of 100
- `Series_Complete_65Plus`
- `Series_Complete_65PlusPop_Pct`: Out of 100
- `Series_Complete_Yes`
- `Series_Complete_Pop_Pct`: Out of 100
- `Completeness_pct`

[cv]: https://covid.cdc.gov/covid-data-tracker/#county-view
