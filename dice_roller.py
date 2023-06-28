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
    # print(f"Rolling {amount}d{d_type} + {modifier}")
    simulation = []
    for i in range(1, (amount + 1)):
        rng = np.random.default_rng()
        options = rng.integers(low=1, high=(d_type + 1), size=10)
        simulation.append(random.choice(options))
        # print(f"Round {i}: Options {list(options)} Choices: {simulation}")
    result = modifier
    [result := result + x for x in simulation]
    # print(f"Sum of all die is: {colored(0,255,0, result)}")
    max_damage = d_type * amount + modifier
    return result, max_damage


def domi_normal(amount, to_hit_modifier, fire):
    global LAST_ZERO, LAST_CRIT
    to_hit = die_roller(20, 1, to_hit_modifier)
    damage, max_damage = die_roller(10, amount, 7)
    max_damage += fire
    if to_hit == (20 + to_hit_modifier):
        d_twenty_fancy = colored(0, 255, 0, (to_hit - to_hit_modifier))
        damage = 2 * damage
        print(
            f"As Dominion swings her flaming scythe towards her target, her blade seeks the obvious weakness in the defense of her enemies, striking true! A nat {d_twenty_fancy}!!",
            f"With a huge gush of blood, she deals {colored(0, 255, 0, damage)} slashing damage and {colored(0, 255, 0, (2 * fire))} fire damage for a total of {colored(0, 255, 0, (damage + (2 * fire)))} out of a max of {max_damage}!\n",
            sep="\n",
        )
        LAST_CRIT = 1
        LAST_ZERO += 1
    elif to_hit == (1 + to_hit_modifier):
        d_twenty_fancy = colored(255, 0, 0, (to_hit - to_hit_modifier))
        damage = 0
        print(
            f"Dominion fucking sucks! She rolled a nat {d_twenty_fancy}",
            f"She deals {colored(255, 0, 0, damage)} because she can't hit shit!\n",
        )
        LAST_CRIT += 1
        LAST_ZERO = 1
    else:
        d_twenty_fancy = colored(255, 69, 0, to_hit)
        print(
            f"As Dominion swings her flaming scythe towards her target",
            f"she strikes with a {d_twenty_fancy}.\n",
            f"With a huge gush of blood, she deals {colored(255, 69, 0, damage)} ",
            f"slashing damage and {colored(255, 69, 0, fire)} ",
            f"fire damage for a total of {colored(255, 69, 0, (damage + fire))} out of a max of {max_damage}!",
            f"\nRolls since last Nat 20: {colored(255, 69, 0, LAST_CRIT)} and since last Nat 0: {colored(255, 69, 0, LAST_ZERO)}\n",
            sep="",
        )
        LAST_CRIT += 1
        LAST_ZERO += 1


def open_gui_with_options():
    options = [
        "Normal Attack!",
        "Electric Arc",
        "Lil Bess",
        "Something Else",
    ]
    root = tk.Tk()
    root.title("Attack Selection")

    # Create a frame to hold the buttons
    button_frame = tk.Frame(root)
    button_frame.pack(pady=10)

    # Create buttons for each option
    buttons = []
    for i in range(len(options)):
        button = tk.Button(
            button_frame,
            text=options[i],
            width=15,
            height=2,
            command=lambda idx=i: option_select(idx),
        )
        buttons.append(button)
        button.grid(row=i // 2, column=i % 2, padx=10, pady=5)

    root.mainloop()


def option_select(option_index):
    if option_index == 0:
        domi_normal(2, 19, 5)
    elif option_index == 1:
        pass
    elif option_index == 2:
        pass
    elif option_index == 3:
        pass


# Call the function to open the GUI with options
open_gui_with_options()
