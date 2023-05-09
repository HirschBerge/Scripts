#!/usr/bin/env python3
import random
from time import sleep
from pyautogui import moveTo, size


def moving():
    X, Y = size()
    X_rand = random.randrange(0, X)
    Y_rand = random.randrange(0, Y)
    print(f"X Coordinate: {X_rand}, Y Coordinate: {Y_rand}")
    sleep_time = random.uniform(5.0, 30.0)
    print(f"Sleeping for {str(sleep_time)[:5]} seconds.")
    sleep(sleep_time)
    moveTo(X_rand, Y_rand)


def main():
    while True:
        moving()


if __name__ == "__main__":
    main()
