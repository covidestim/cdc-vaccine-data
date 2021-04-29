# cdc-vaccine-data

This is a daily scrape of CDC county-level vaccinations data. The data being
scraped is the data powering the CDC's [county view][cv] dashboard. This 
dashboard makes an HTTP request to the following URL, which is what we scrape:

```
https://covid.cdc.gov/covid-data-tracker/COVIDData/getAjaxData?id=vaccination_county_condensed_data
```

The `.json` returned represents one day of county-level vaccination data -
it's not a timeseries. For this reason, we scrape it every day, and combine
all the `.json`'s together to form a timeseries, starting with 2020-04-15 (the
day we started scraping) and continuing until the present.

## Every day at 1600 UTC / 1200 EDT:

1. Issues an HTTTP GET to the URL and saves the resulting JSON as `YYYY-MM-DD.json` in the root directory
2. Combines all `.json` files we have into one file `combined.json`
3. Creates `combined.csv`, a CSV representation of  `combined.json`: this is the `.csv` timeseries we are looking for

## Data definitions

Each `.json` is basically an array of objects, and the keys of these objects are
summarized below:

**Geographic identifiers**

- `Date`: `YYYY-MM-DD`
- `FIPS`: 5-digit FIPS, unknown FIPS are coded as `UNK`
- `StateName`
- `StateAbbr`: For some reason, always 3 characters in length
- `County`: County name, sans "County", unknwon counties coded as `Unknown County`

**Age-related vaccination numbers**

- `Series_Complete_18Plus`: Number of 18+ y.o. individuals who are "fully vaccinated"
- `Series_Complete_18PlusPop_Pct`: Percent, out of 100
- `Series_Complete_65Plus`: Number of 65+ y.o. individuals who are "fully vaccinated"
- `Series_Complete_65PlusPop_Pct`: Percent, out of 100

**Overall vaccination numbers**

- `Series_Complete_Yes`: Number of individuals who are "fully vaccinated"
- `Series_Complete_Pop_Pct`: Percent, out of 100

**Unknown**

- `Completeness_pct`: Unclear

"fully vaccinated" means an individual who received their second dose, or their
first dose if J&J. There is no accounting for the lag between receiving of the
final dose, and the development of a protective effect.

Percentages are calculated using census bureau annual estimates.

Entries with FIPS code `UNK` appear to signify all vaccination data which could
not be associated with a particular county. It appears that for each day of data,
there is an `UNK` FIPS code for every state.

See [here][datadefs] for more information on CDC vaccination data definitions.

[cv]: https://covid.cdc.gov/covid-data-tracker/#county-view
[datadefs]: https://www.cdc.gov/coronavirus/2019-ncov/vaccines/distributing/reporting-counties.html
