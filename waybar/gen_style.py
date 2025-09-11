import os
import sys

# Hack to access config
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import config
from mako.template import Template


TEMPLATE_PATH = "./style.template.css"
OUTPUT_PATH = "./build/style.css"

# keys cannot have hyphen(-) in them.
template_vars = {
    "bg_color": config.colors["gr3"].to_hex(),
    "fg_color": config.colors["brwhite"].to_hex(),
    "gr0": config.colors["gr0"].to_hex(),
    "gr1": config.colors["gr1"].to_hex(),
    "gr2": config.colors["gr2"].to_hex(),
    "gr3": config.colors["gr3"].to_hex(),
    "gr4": config.colors["gr4"].to_hex(),
    "gr5": config.colors["gr5"].to_hex(),
    "gr6": config.colors["gr6"].to_hex(),
    "gr7": config.colors["gr7"].to_hex(),
    "white": config.colors["white"].to_hex(),
}

css_template = Template(filename=TEMPLATE_PATH)
rendered_css = css_template.render(**template_vars)

with open(OUTPUT_PATH, "w") as f:
    f.write(rendered_css)
