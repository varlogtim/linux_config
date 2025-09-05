



def gen_component_color() -> dict[int, str]:
    max_val = 255
    min_val = 0
    val_range = max_val - min_val
    num_divisions = 8
    div_val = val_range / num_divisions

    values = {}
    for ii in range(num_divisions, 0, -1):
        dec_val = int(max_val - div_val * ii)
        hex_val = f"{dec_val:02x}"
        values[dec_val] = hex_val
    return values 

def gen_grays():
    colors = gen_component_color()
    for ii, color in enumerate(colors.values()):  # get hex colors
        print(f'set $color_gr{ii} #{color}{color}{color}')

gen_grays()

# RGB color (R, G, B values from 0-255)
def print_rgb(r, g, b, text):
    print(f"\033[38;2;{r};{g};{b}m{text}\033[0m")

def print_rgb_bg(r, g, b, text):
    print(f"\033[48;2;{r};{g};{b}m{text}\033[0m")

colors = gen_component_color()
for ii, color in enumerate(colors.keys()):  # get dec colors
    print_rgb_bg(color, color, color, "The quick brown fox jumps over the lazy dog!?")

for ii, color in enumerate(colors.keys()):  # get dec colors
    print_rgb_bg(color, 10, 40, "The quick brown fox jumps over the lazy dog!?")
