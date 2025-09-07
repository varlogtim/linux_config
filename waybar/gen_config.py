import os
import sys

# Hack to access config
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import config
from mako.template import Template


TEMPLATE_PATH = "./config.template.jsonc"
OUTPUT_PATH = "./build/config.jsonc"

# keys cannot have hyphen(-) in them.
template_vars = {
    "bg_color": config.colors["gr3"],
}

css_template = Template(filename=TEMPLATE_PATH)
rendered_css = css_template.render(**template_vars)

with open(OUTPUT_PATH, "w") as f:
    f.write(rendered_css)
