#!/usr/bin/env python
#
# Export web charts from rosbags generated during tets
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

from bearcart import bearcart
import rosbag_pandas
import os
import sys

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
            "mavros_setpoint_local_position__pose_position_x",
            "mavros_setpoint_local_position__pose_position_y",
            "mavros_setpoint_local_position__pose_position_z",
            "mavros_position_local__pose_position_x",
            "mavros_position_local__pose_position_y",
            "mavros_position_local__pose_position_z"
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
            "mavros_setpoint_att_throttle__data",
            "mavros_setpoint_attitude__pose_orientation_w",
            "mavros_setpoint_attitude__pose_orientation_x",
            "mavros_setpoint_attitude__pose_orientation_y",
            "mavros_setpoint_attitude__pose_orientation_z",
            "mavros_position_local__pose_orientation_w",
            "mavros_position_local__pose_orientation_x",
            "mavros_position_local__pose_orientation_y",
            "mavros_position_local__pose_orientation_z",
        ]
    },
]

def export(output_dir, bag_file):
    data = rosbag_pandas.bag_to_dataframe(bag_file)
    bag_name = os.path.splitext(os.path.basename(bag_file))[0]
    output_dir = os.path.abspath(output_dir)

    # for c in data.columns:
    #     print c

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

            print "Exporting chart %s to %s" % (chart["name"], path)

            os.chdir(path)
            vis = bearcart.Chart(chart_df)
            vis.create_chart(html_path=HTML_FILE, data_path=DATA_FILE,
                             js_path=JS_FILE, css_path=CSS_FILE)



# Main function.
if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: export_charts.py <output_directory> <bag_file>")
    else:
        export(sys.argv[1], sys.argv[2])
