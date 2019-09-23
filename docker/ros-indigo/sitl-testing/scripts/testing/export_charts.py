#!/usr/bin/env python
#
# Export web charts from rosbags generated during tets
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

from bearcart import bearcart
import rosbag_pandas
import os
import sys
import math

# apt-get install ros-indigo-geodesy
from geodesy import utm

HTML_FILE = r'index.html'
DATA_FILE = r'data.json'
JS_FILE = r'rickshaw.min.js'
CSS_FILE = r'rickshaw.min.css'
OUTPUT_DIR = "/root/.ros/charts/"

CHARTS = [
    {
        "name": "mavros_global_position",
        "series": [
            "mavros_global_position_global__altitude",
            "mavros_global_position_global__latitude",
            "mavros_global_position_global__longitude"
        ]
    },
    {
        "name": "mavros_local_position",
        "series": [
            # topic names for MAVROS >= 0.11
            "mavros_setpoint_position_local__pose_position_x",
            "mavros_setpoint_position_local__pose_position_y",
            "mavros_setpoint_position_local__pose_position_z",
            "mavros_local_position_local__pose_position_x",
            "mavros_local_position_local__pose_position_y",
            "mavros_local_position_local__pose_position_z"
        ]
    },
    {
        "name": "px4_local_position",
        "series": [
            "px4_vehicle_local_position__x",
            "px4_vehicle_local_position__y",
            "px4_vehicle_local_position__z",
            "px4_vehicle_local_position_setpoint__x",
            "px4_vehicle_local_position_setpoint__y",
            "px4_vehicle_local_position_setpoint__z"
        ]
    },
    {
        "name": "px4_attitude",
        "series": [
            "px4_vehicle_attitude_setpoint__pitch_body",
            "px4_vehicle_attitude_setpoint__roll_body",
            "px4_vehicle_attitude_setpoint__yaw_body",
            "px4_vehicle_attitude__roll",
            "px4_vehicle_attitude__pitch",
            "px4_vehicle_attitude__yaw"
        ]
    },
    {
        "name": "mavros_attitude",
        "series": [
            # topic names for MAVROS >= 0.11
            "mavros_setpoint_attitude_att_throttle__data",
            "mavros_setpoint_attitude_attitude__pose_orientation_w",
            "mavros_setpoint_attitude_attitude__pose_orientation_x",
            "mavros_setpoint_attitude_attitude__pose_orientation_y",
            "mavros_setpoint_attitude_attitude__pose_orientation_z",
            "mavros_local_position_local__pose_orientation_w",
            "mavros_local_position_local__pose_orientation_x",
            "mavros_local_position_local__pose_orientation_y",
            "mavros_local_position_local__pose_orientation_z",
        ]
    },
]

KML_SERIES = [
    "mavros_local_position_local__pose_position_x",
    "mavros_local_position_local__pose_position_y",
    "mavros_local_position_local__pose_position_z",
    "px4_vehicle_local_position__x",
    "px4_vehicle_local_position__y",
    "px4_vehicle_local_position__z",
]


def kmlhead(name):
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
    <name>%s</name>
    <Style id="red">
    <LineStyle>
    <color>7f0000ff</color>
    <width>4</width>
    </LineStyle>
    </Style>
    <Placemark>
        <name>%s</name>
        <styleUrl>#red</styleUrl>
        <LineString>
            <coordinates>
''' % (name, name)


def kmltail(altmode):
    return '''
            </coordinates>
            <tesselate>1</tesselate>
            <altitudeMode>%s</altitudeMode>
        </LineString>
    </Placemark>
</Document>
</kml>
''' % altmode


def export(output_dir, bag_file):
    data = rosbag_pandas.bag_to_dataframe(bag_file)
    bag_name = os.path.splitext(os.path.basename(bag_file))[0]
    output_dir = os.path.abspath(output_dir)

    # data = data.truncate(before="20150319 13:38:30", after="20150319 13:39:00")
    # data = data.truncate(before="20150319 14:53:30", after="20150319 14:54:30")

    # for c in data.columns:
    #     print(c)

    for chart in CHARTS:
        # Filter series
        # Drop rows where all values are missing
        # Resample:
        # - reduces amount of data
        # - reduces gaps in data (gives a nicer chart)
        chart_df = data.filter(items=chart["series"]).dropna(axis=0, how="all").resample('100L', how="first")
        if chart_df.columns.size > 0:
            path = os.path.join(output_dir, bag_name, chart["name"])
            if not os.path.exists(path):
                os.makedirs(path)

            print("Exporting chart %s to %s" % (chart["name"], path))

            os.chdir(path)
            vis = bearcart.Chart(chart_df)
            vis.create_chart(html_path=HTML_FILE, data_path=DATA_FILE,
                             js_path=JS_FILE, css_path=CSS_FILE)

    #
    # KML export
    #
    base = utm.fromLatLong(47.388650, 8.033269, 368)
    chart_df = data.filter(items=KML_SERIES).dropna(axis=0, how="all").resample('100L', how="first")
    if chart_df.columns.size > 0:
        mavros = KML_SERIES[0] in chart_df.columns
        path = os.path.join(output_dir, bag_name + '.kml')
        print("Exporting KML to %s" % (path))

        fid = open(path, 'w')
        fid.write(kmlhead(bag_name))
        for row_index, row in chart_df.iterrows():
            x = base.easting
            y = base.northing
            a = base.altitude

            # if (math.isnan(row[KML_SERIES[0]]) or math.isnan(row[KML_SERIES[1]]) or math.isnan(row[KML_SERIES[2]])):
            #     print("found nan")
            #     print(row)

            if mavros and not (math.isnan(row[KML_SERIES[0]]) or math.isnan(row[KML_SERIES[1]]) or math.isnan(row[KML_SERIES[2]])):
                x = row[KML_SERIES[0]]
                y = row[KML_SERIES[1]]
                a = row[KML_SERIES[2]]

            elif not mavros and not (math.isnan(row[KML_SERIES[3]]) or math.isnan(row[KML_SERIES[4]]) or math.isnan(row[KML_SERIES[5]])):
                x = x + row[KML_SERIES[3]]
                y = y + row[KML_SERIES[4]]
                a = a - row[KML_SERIES[5]]

            else:
                continue

            p = utm.UTMPoint(x, y, zone=base.zone, band=base.band).toMsg()

            fid.write("%f,%f,%f " % (p.longitude, p.latitude, a))

        fid.write(kmltail("absolute"))
        fid.close()


# Main function.
if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: export_charts.py <output_directory> <bag_file>")
    else:
        export(sys.argv[1], sys.argv[2])
