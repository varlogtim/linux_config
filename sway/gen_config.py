import os
import sys
import argparse

# Hack to access config
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import config
from mako.template import Template


TEMPLATE_PATH = "./template.config"
OUTPUT_PATH = "./build/config"

parser = argparse.ArgumentParser(description="Render config template")
parser.add_argument(
    '--screenshot-dir',
    required=True,
    help="Path to the screenshot directory (will be passed to template as 'screenshot_dir')"
)

args = parser.parse_args()

# keys cannot have hyphen(-) in them.
template_vars = {
    "bg_color": config.colors["gr3"],
    "screenshot_dir": args.screenshot_dir,
}

css_template = Template(filename=TEMPLATE_PATH)
rendered_css = css_template.render(**template_vars)

with open(OUTPUT_PATH, "w") as f:
    f.write(rendered_css)
