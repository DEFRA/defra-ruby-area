# frozen_string_literal: true

require "rest-client"

module DefraRuby
  module Area
    class BaseAreaService

      def self.run(easting, northing)
        new(easting, northing).run
      end

      def initialize(easting, northing)
        @easting = easting
        @northing = northing
      end

      def run
        Response.new(response_exe)
      end

      private

      attr_reader :easting, :northing

      def response_exe
        lambda do
          response = RestClient::Request.execute(
            method: :get,
            url: url,
            timeout: DefraRuby::Area.configuration.timeout
          )
          area = Area.new(type_name, Nokogiri::XML(response))
          raise NoMatchError unless area.matched?

          { area: area }
        end
      end

      def url
        "#{domain}/spatialdata/#{dataset}/wfs?#{url_params}"
      end

      # Domain where the WFS is hosted
      def domain
        "https://environment.data.gov.uk"
      end

      # Name of the Environment Agency dataset we are querying.
      #
      # Not actually a part of the WFS interface or spec. This is simply how
      # we route through to the right 'dataset' (how the EA terms it).
      def dataset
        implemented_in_subclass
      end

      def url_params
        {
          "SERVICE" => service,
          "VERSION" => version,
          "REQUEST" => request,
          "typeName" => type_name,
          "propertyName" => property_name,
          "SRSName" => srs_name,
          "Filter" => filter
        }.map { |k, v| "#{k}=#{v}" }.join("&")
      end

      # There are generally 3 kinds of GIS services; WFS, WMS, and WCS.
      #
      # * WFS - allows features to be queried, updated, created, or deleted by the client
      # * WMS - returns map images based on the request made
      # * WCS - transfer "coverages", ie. objects covering a geographical area
      #
      # We are querying a 'feature' hence we request to use the WFS service.
      #
      # N.B. A feature is an Object that is an abstraction of a real world
      # phenomenon. This object has a set of properties associated with each
      # having a name, a type, and a value.
      def service
        "WFS"
      end

      # Currently there are various versions of the WFS standard, for example
      # 1.0, 1.1 and 2.0.
      #
      # The WFS's we are working with only support version 1.0. A WFS may
      # suppport multiple versions hence you need to state the version in the
      # request.
      def version
        "1.0.0"
      end

      # Used to tell the WFS what kind of request you are making. In the case
      # of `GetFeature` this means
      #
      #   Return a selection of features from a data source including geometry and attribute values
      #
      # https://docs.geoserver.org/latest/en/user/services/wfs/reference.html#getfeature
      def request
        "GetFeature"
      end

      # Name of the feature we wish to query.
      #
      # A WFS may host multiple features, so you need to specify which one you
      # are querying in the url.
      def type_name
        implemented_in_subclass
      end

      # Specify which attribute of the feature we want to return. You can check
      # the attributes of a feature by making +DescribeFeatureType+ request.
      #
      # https://environment.data.gov.uk/spatialdata/administrative-boundaries-water-management-areas/wfs?SERVICE=WFS&VERSION=1.0.0&REQUEST=DescribeFeatureType
      #
      # In our case the administrative boundary features contain a number of
      # properties, but we are only interested in +code+, +long_name+ and
      # +short_name+.
      def property_name
        "area_id,code,long_name,short_name"
      end

      # SRS stands for Spatial Reference System. It can also be known as a
      # Coordinate Reference System (CRS). It is a coordinate-based local,
      # regional or global system used to locate geographical entities.
      # A spatial reference system defines a specific map projection, as well as
      # transformations between different spatial reference systems.
      #
      # The SRSName paramater tells the WFS which SRS definition to use. The
      # value is an EPSG (European Petroleum Survey Group) code. You can find a
      # list of them at https://spatialreference.org/ref/epsg/
      #
      # EPSG:27700 refers to OSGB 1936 - British National Grid
      # (https://spatialreference.org/ref/epsg/27700/)
      #
      # For more info on SRS read https://en.wikipedia.org/wiki/Spatial_reference_system
      def srs_name
        "EPSG:27700"
      end

      # WFS's use filters in GetFeature requests to return data that only
      # matches a certain criteria.
      #
      # https://docs.geoserver.org/latest/en/user/filter/function.html
      #
      # There are various formats you can use for doing those, though it will be
      # dependent on what the WFS supports. In our case we use XML-based Filter
      # Encoding language because
      #
      # * this was how the team that manage the WFS have always provided their
      #   examples
      # * we know this format is supported by the WFS's we are interacting with
      #
      # The others are CQL and ECQL. https://docs.geoserver.org/latest/en/user/tutorials/cql/cql_tutorial.html
      #
      # Our filter is looking for the result where our coordinates intersect
      # with the feature property +SHAPE+, with +SHAPE+ being a
      # +MultiPolygonPropertyType+.
      #
      # http://xml.fmi.fi/namespace/meteorology/conceptual-model/meteorological-objects/2009/04/28/docindex647.html
      def filter
        # The filter is done in this way purely for readability. It could just
        # as easily been a one line string statement, but we think this is
        # better.
        filter = <<-XML
          (
            <Filter>
              <Intersects>
                <PropertyName>SHAPE</PropertyName>
                <gml:Point>
                  <gml:coordinates>#{easting},#{northing}</gml:coordinates>
                </gml:Point>
              </Intersects>
            </Filter>
          )
        XML
        filter.strip.squeeze(" ").gsub(/\s+/, "")
      end

      def implemented_in_subclass
        raise NotImplementedError, "This #{self.class} cannot respond to:"
      end
    end
  end
end
