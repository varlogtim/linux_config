import re


class Color:
    # TODO:
    # - Should support things like "red" and "brred" or "bright red"
    # - Should calculate the 6 base colors via HSV and balance them.
    # - wtf is cyan? I guess since we see more shades of green, there is a 
    #   green-blue color which is cyan.
    # - Perhaps I pick the colors based on a human perceived distance rather
    #   than a mathematical difference. I.e., If the range of greens we can
    #   perceive is larger than the range of reds, the color wheels size should
    #   be altered to show this.
    def __init__(self, red: int, green: int, blue: int, alpha: float = 0):
        for color in [red, green, blue]:
            if color < 0 or 255 < color:
                raise ValueError("color components must be between 0 and 255")

        if alpha < 0 or 1 < alpha:
            raise ValueError("alpha must be between 0 and 1")

        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha

    @classmethod
    def from_string(cls, input: str) -> "Color":
        # hex color code #RRGGBB, 24-bit color, matches, "#af001c" and "#FFa10B"
        r = r"^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$"
        m = re.match(r, input)
        if m is not None:
            r = int(m.group(1), 16)
            g = int(m.group(2), 16)
            b = int(m.group(3), 16)
            return cls(r, g, b)

        # hex color code #RGB, 12-bit color, matches, "#123" and "#Fa0"
        r = r"^#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$"
        m = re.match(r, input)
        if m is not None:
            r = int(f"{m.group(1)}0", 16)
            g = int(f"{m.group(2)}0", 16)
            b = int(f"{m.group(3)}0", 16)
            return cls(r, g, b)

        # rgb color code, matches "rgb(123, 0, 34)"
        r = r"^rgb\(([0-9]{1,3}), ([0-9]{1,3}), ([0-9]{1,3})\)$"
        m = re.match(r, input)
        if m is not None:
            r = int(m.group(1))
            g = int(m.group(2))
            b = int(m.group(3))
            return cls(r, g, b)

        # rgba color code, matches "rgba(123, 0, 34, 0.312534)"
        r = r"^rgba\(([0-9]{1,3}), ([0-9]{1,3}), ([0-9]{1,3}), (0|1|0\.[0-9]*))\)$"
        m = re.match(r, input)
        if m is not None:
            r = int(m.group(1))
            g = int(m.group(2))
            b = int(m.group(3))
            a = float(m.group(4))
            return cls(r, g, b, a)

        raise ValueError("unable to determine color type")

    def to_hex(self) -> str:
        return ("#"
                f"{hex(self.red)[2:].zfill(2)}"
                f"{hex(self.green)[2:].zfill(2)}"
                f"{hex(self.blue)[2:].zfill(2)}"
        )

    def to_rgb(self) -> str:
        return f"rgb({self.red}, {self.green}, {self.blue})"

    def to_rbga(self) -> str:
        return f"rgba({self.red}, {self.green}, {self.blue}, {self.alpha})"



# six = Color.from_hex_color_code("#f100c8")
# three = Color.from_hex_color_code("#abf")
# dir = Color(123, 4, 77)
#
# print(six.to_hex_color_code())
# print(three.to_hex_color_code())
# print(dir.to_hex_color_code())
#

colors = {
    # Gray Colors
    "gr0": Color.from_string("#000000"),
    "gr1": Color.from_string("#1f1f1f"),
    "gr2": Color.from_string("#3f3f3f"),
    "gr3": Color.from_string("#5f5f5f"),
    "gr4": Color.from_string("#7f7f7f"),
    "gr5": Color.from_string("#9f9f9f"),
    "gr6": Color.from_string("#bfbfbf"),
    "gr7": Color.from_string("#dfdfdf"),
    # Base Colors
    "black": Color.from_string("#000000"),
    "red": Color.from_string("#8a0000"),
    "green": Color.from_string("#4d6e00"),
    "yellow": Color.from_string("#7d6000"),
    "blue": Color.from_string("#005fb3"),
    "magenta": Color.from_string("#7d0045"),
    "cyan": Color.from_string("#007d7d"),
    "white": Color.from_string("#ffffd7"),  # flipped
    # Bright Colors
    "brblack": Color.from_string("#1f1f1f"),
    "brred": Color.from_string("#d70000"),
    "brgreen": Color.from_string("#5f8700"),
    "bryellow": Color.from_string("#af8700"),
    "brblue": Color.from_string("#0087ff"),
    "brmagenta": Color.from_string("#af005f"),
    "brcyan": Color.from_string("#00afaf"),
    "brwhite": Color.from_string("#d7d7af"),
}



