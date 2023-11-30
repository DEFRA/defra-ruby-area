# Defra Ruby Area

![Build Status](https://github.com/DEFRA/defra-ruby-area/workflows/CI/badge.svg?branch=main)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_defra-ruby-area&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=DEFRA_defra-ruby-area)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_defra-ruby-area&metric=coverage)](https://sonarcloud.io/dashboard?id=DEFRA_defra-ruby-area)
[![Gem Version](https://badge.fury.io/rb/defra_ruby_area.svg)](https://badge.fury.io/rb/defra_ruby_area)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

This ruby gem provides a means of looking up Environment Agency Administrative boundary areas from a GIS Web Feature Service (WFS). Provided with a valid [easting and northing](https://en.wikipedia.org/wiki/Easting_and_northing) it will query the WFS and return various properties for each matching area found.

## Installation

Add this line to your application's Gemfile

```ruby
gem "defra_ruby_area"
```

And then update your dependencies by calling

```bash
bundle install
```

## Usage

The gem interfaces with two WFS's that provide administrative boundaries; [Environment Agency and Natural England Public Face Areas](https://environment.data.gov.uk/dataset/91d0fb43-209c-477f-91e3-74e756296268) and [Water Management Areas](https://environment.data.gov.uk/dataset/7942e4cf-d465-11e4-ac00-f0def148f590).

### Response object

Each WFS is called through a service that responds with a `DefraRuby::Area::Response` object. It has the following attributes

```ruby
response.successful?
response.areas
response.error
```

If the call is successful then

- `successful?()` will be `true`
- `areas` will contain an array of `DefraRuby::Area::Area`. Each contains the area ID, area name, code, short name and long name of the matching administrative boundary
- `error` will be `nil`

If the call is unsuccessful (the query errored or no match was found) then

- `successful?()` will be `false`
- `areas` will be `[]` (an empty array)
- `error` will contain the error

If it's a runtime error, or an error when calling the WFS `error` will contain whatever error was raised.

If it's because no match was found `error` will contain an instance of `DefraRuby::Area::NoMatchError`.

### Environment Agency and Natural England Public Face Areas

This WFS contains public facing administrative boundaries set at 1:10,000 scale. To use it make the following call

```ruby
easting = 408_602.61
northing = 257_535.31
response = DefraRuby::Area::PublicFaceAreaService.run(easting, northing)

puts response.areas.first.long_name if response.successful? # West Midlands
```

### Water Management Areas

This WFS contains public facing water management administrative boundaries set at 1:10,000 scale. To use it make the following call

```ruby
easting = 408_602.61
northing = 257_535.31
response = DefraRuby::Area::WaterManagementAreaService.run(easting, northing)

puts response.areas.first.long_name if response.successful? # Staffordshire Warwickshire and West Midlands
```

### Multiple results

In most cases we expect `response.areas` to contain a single result. It is possible though for a given easting and northing to return multiple administrative boundary areas. Where we see this is when a coordinate is on the boundary of 2 areas. This is why **defra-ruby-area** is setup to return multiple results.

Examples:

- **Public face areas** easting = `398056.684` and northing = `414748` (*Yorkshire* and *Greater Manchester Merseyside and Cheshire*)
- **Water management areas** easting = `456330` and northing = `267000` (*Lincolnshire and Northamptonshire* and *Staffordshire Warwickshire and West Midlands*)

## Web Feature Services

A [Web Feature Service (WFS)](https://en.m.wikipedia.org/wiki/Web_Feature_Service) is simply a web service that implements the Open Geospatial Consortium Web Feature Service (WFS) Interface Standard.

Calls are made using url query params. For example behind the scenes `DefraRuby::Area::PublicFaceAreaService` is hitting the following URL

`https://environment.data.gov.uk/spatialdata/administrative-boundaries-environment-agency-and-natural-england-public-face-areas/wfs?outputformat=json&SERVICE=WFS&VERSION=2.0.0&REQUEST=GetFeature&typeNames=ms:Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas&propertyName=identifier,long_name,code,short_name&SRSName=EPSG:27700&cql_filter=bbox(shape,408602.61,257535.31,408602.61,257535.31)`

As you can see output requested in JSON, and will return the result in JSON format.

```json
{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "id": "Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas.23",
            "geometry": null,
            "properties": {
                "identifier": 51,
                "long_name": "West Midlands",
                "short_name": "West Midlands",
                "code": "WMD"
            },
            "bbox": [
                316114.5,
                187934.4,
                456472.5,
                369909.5
            ]
        }
    ],
    "totalFeatures": 1,
    "numberMatched": 1,
    "numberReturned": 1,
    "timeStamp": "2023-11-30T11:06:46.945Z",
    "crs": null
}
```

### Further reading

Checkout these additional resources we have found helpful in understanding how WFS's work.

- [Web Feature Service](http://www.opengeospatial.org/standards/wfs)
- [Communicating with a WFS service in a web browser](https://enterprise.arcgis.com/en/server/latest/publish-services/windows/communicating-with-a-wfs-service-in-a-web-browser.htm)
- [Introduction to Web Feature Service](https://geoserver.geo-solutions.it/edu/en/vector_data/wfsintro.html)
- [WFS reference](https://docs.geoserver.org/latest/en/user/services/wfs/reference.html)

### Argh!

We don't know if its just a characteristic of WFS's, GIS, or just the EA implementations but things often break in this world.

A WFS will often go down, sometimes for maintenance (_hopefully_ on a weekend 😀) sometimes just for 'reasons'.

Also though this gem is new, we have worked with these services before and this is approximately the 6th time the format of the query has changed in the space of a 5 years.

For example the period of December 2018 to June 2019 both services were completely down whilst we waited for fixes to be implemented, then confirmation of what query would actually work!

You may also find any page we have linked to in this README will no longer respond. Again they often seem to move or be taken down.

So expect stuff to break, and be prepared to use some detective work to either get it going again, for find where its moved to 😉.

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
