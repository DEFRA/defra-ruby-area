# Defra Ruby Area

[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

This ruby gem provides a means of looking up an Environment Agency Administrative boundary from a GIS Web Feature Service (WFS). Provided with a valid [easting and northing](https://en.wikipedia.org/wiki/Easting_and_northing) it will query the WFS and return the long name for the area if a match is found.

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
response.area
response.error
```

If the call is successful (the query did not error and a match was found) then

- `successful?()` will be `true`
- `area` will contain the long name of the matching administrative boundary
- `error` will be `nil`

If the call is unsuccessful (the query errored or no match was found) then

- `successful?()` will be `false`
- `area` will be `nil`
- `error` will contain the error

If its a runtime error, or an error when calling the WFS `error` will contain whatever error was raised.

If its because no match was found `error` will contain an instance of `DefraRuby::Area::NoMatchError`.

### Environment Agency and Natural England Public Face Areas

This WFS contains public facing administrative boundaries set at 1:10,000 scale. To use it make the following call

```ruby
easting = 408_602.61
northing = 257_535.31
response = DefraRuby::Area::PublicFaceAreaService.run(easting, northing)

puts response.area if response.successful? # West Midlands
```

### Water Management Areas

This WFS contains public facing water management administrative boundaries set at 1:10,000 scale. To use it make the following call

```ruby
easting = 408_602.61
northing = 257_535.31
response = DefraRuby::Area::WaterManagementAreaService.run(easting, northing)

puts response.area if response.successful? # Staffordshire Warwickshire and West Midlands
```

## Web Feature Services

A [Web Feature Service (WFS)](https://en.m.wikipedia.org/wiki/Web_Feature_Service) is simply a web service that implements the Open Geospatial Consortium Web Feature Service (WFS) Interface Standard.

Calls are made using url query params. For example behind the scenes `DefraRuby::Area::PublicFaceAreaService` is hitting the following URL

`https://environment.data.gov.uk/spatialdata/administrative-boundaries-environment-agency-and-natural-england-public-face-areas/wfs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&typeNames=ms:Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas&propertyName=long_name&SRSName=EPSG:27700&Filter=(<Filter><Intersects><PropertyName>SHAPE</PropertyName><gml:Point><gml:coordinates>408602.61,257535.31</gml:coordinates></gml:Point></Intersects></Filter>)`

As you can see it uses XML within query, and will return the result in XML.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<wfs:FeatureCollection xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wfs="http://www.opengis.net/wfs" xmlns:gml="http://www.opengis.net/gml" xmlns:ms="https://environment.data.gov.uk/spatialdata/administrative-boundaries-environment-agency-and-natural-england-public-face-areas/wfs" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/WFS-basic.xsd http://www.opengis.net/gml http://schemas.opengis.net/gml/2.1.2/feature.xsd https://environment.data.gov.uk/spatialdata/administrative-boundaries-environment-agency-and-natural-england-public-face-areas/wfs https://environment.data.gov.uk/spatialdata/administrative-boundaries-environment-agency-and-natural-england-public-face-areas/wfs?service=wfs%26version=1.0.0%26request=DescribeFeatureType">
<gml:boundedBy>
  <gml:Box srsName="EPSG:27700">
    <gml:coordinates>0,0,0,0</gml:coordinates>
  </gml:Box>
</gml:boundedBy>
  <gml:featureMember>
    <ms:Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas fid="Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas.23">
      <ms:OBJECTID>23</ms:OBJECTID>
      <ms:long_name>West Midlands</ms:long_name>
      <ms:st_area_shape_>14543741870.84492</ms:st_area_shape_>
      <ms:st_perimeter_shape_>1043376.795941756</ms:st_perimeter_shape_>
    </ms:Administrative_Boundaries_Environment_Agency_and_Natural_England_Public_Face_Areas>
  </gml:featureMember>
</wfs:FeatureCollection>
```

### Further reading

Checkout these additional resources we have found helpful in understanding how WFS's work.

- [Communicating with a WFS service in a web browser](https://enterprise.arcgis.com/en/server/latest/publish-services/windows/communicating-with-a-wfs-service-in-a-web-browser.htm)
- [Introduction to Web Feature Service](https://geoserver.geo-solutions.it/edu/en/vector_data/wfsintro.html)
- [WFS reference](https://docs.geoserver.org/latest/en/user/services/wfs/reference.html)

### Argh!

We don't know if its just a characteristic of WFS's, GIS, or just the EA implementations but things often break in this world.

A WFS will often go down, sometimes for maintenance (_hopefully_ on a weekend 😀) sometimes just for 'reasons'.

Also though this gem is new, we have worked with these services before and this is approximately the 5th time the format of the query has changed in the space of a 3 years.

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
