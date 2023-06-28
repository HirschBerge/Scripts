#! /usr/bin/env python3
import numpy as np
import tkinter as tk
from tkinter import messagebox
import random


def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{}\033[38;2;255;255;255m".format(r, g, b, text)


LAST_CRIT = 1
LAST_ZERO = 1


def die_roller(d_type, amount, modifier):
    simulation = []
    for i in range(1, (amount + 1)):
        rng = np.random.default_rng()
        options = rng.integers(low=1, high=(d_type + 1), size=10)
        simulation.append(random.choice(options))
        # print(f"Round {i}: Options {options} Choices: {simulation}")
    result = modifier
    [result := result + x for x in simulation]
    return result


def domi_normal(amount, to_hit_modifier, fire):
    global LAST_ZERO, LAST_CRIT
    to_hit = die_roller(20, 1, to_hit_modifier)
    damage = die_roller(10, amount, 7)
    if to_hit == (20 + to_hit_modifier):
        d_twenty_fancy = colored(0, 255, 0, (to_hit - to_hit_modifier))
        damage = 2 * damage
        LAST_CRIT = 1
        LAST_ZERO += 1
        print(
            f"As Dominion swings her flaming scythe towards her target, her blade seeks the obvious weakness in the defense of her enemies, striking true! A nat {d_twenty_fancy}!!",
            f"With a huge gush of blood, she deals {colored(0, 255, 0, damage)} slashing damage and {colored(0, 255, 0, (2 * fire))} fire damage for a total of {colored(0, 255, 0, (damage + (2 * fire)))}!",
            sep="\n",
        )
    elif to_hit == (1 + to_hit_modifier):
        d_twenty_fancy = colored(255, 0, 0, (to_hit - to_hit_modifier))
        damage = 0
        LAST_CRIT += 1
        LAST_ZERO = 1
        print(
            f"Dominion fucking sucks! She rolled a nat {d_twenty_fancy}",
            f"She deals {colored(255, 0, 0, damage)} because she can't hit shit!",
        )
    else:
        d_twenty_fancy = colored(255, 69, 0, to_hit)
        print(
            f"As Dominion swings her flaming scythe towards her target",
            f"she strikes with a {d_twenty_fancy}.\n",
            f"With a huge gush of blood, she deals {colored(255, 69, 0, damage)} ",
            f"slashing damage and {colored(255, 69, 0, fire)} ",
            f"fire damage for a total of {colored(255, 69, 0, (damage + fire))}!",
            f"\nRolls since last Nat 20: {colored(255, 69, 0, LAST_CRIT)} and since last Nat 0: {colored(255, 69, 0, LAST_ZERO)}",
            sep="",
        )
        LAST_CRIT += 1
        LAST_ZERO += 1


def option_select(variable):
    selected_option = variable.get()
    if selected_option == "Normal Attack!":
        domi_normal(2, 19, 5)
    else:
        messagebox.showinfo("Option Selected", f"You selected: {selected_option}")


def open_gui_with_options():
    options = [
        "Normal Attack!",
        "Electric Arc",
        "Lil Bess",
    ]  # Replace with your own options

    root = tk.Tk()
    root.title("Option Selection")

    variable = tk.StringVar(root)
    variable.set(options[0])  # Set default option

    option_menu = tk.OptionMenu(root, variable, *options)
    option_menu.pack(pady=10)

    select_button = tk.Button(
        root, text="Select", command=lambda: option_select(variable)
    )
    select_button.pack(pady=10)

    root.mainloop()


# Call the function to open the GUI
open_gui_with_options()
