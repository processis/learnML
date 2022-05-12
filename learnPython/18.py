#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May 12 03:19:20 2022

@author: user
"""

#18-2

import numpy as np
import matplotlib.pyplot as plt

plt.style.use('seaborn-poster')

x = np.linspace(-np.pi, np.pi, 200)
y = np.zeros(len(x))

labels = ['First Order', 'Third Order', 'Fifth Order', 'Seventh Order']

plt.figure(figsize = (10,8))
for n, label in zip(range(4), labels):
    y = y + ((-1)**n * (x)**(2*n+1)) / np.math.factorial(2*n+1)
    plt.plot(x,y, label = label)

plt.plot(x, np.sin(x), 'k', label = 'Analytic')
plt.grid()
plt.title('Taylor Series Approximations of Various Orders')
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.show()

x = np.pi/2
y = 0

for n in range(4):
    y = y + ((-1)**n * (x)**(2*n+1)) / np.math.factorial(2*n+1)
    
print(y)

x = np.linspace(0, 3, 30)
y = np.exp(x)

plt.figure(figsize = (14, 4.5))
plt.subplot(1, 3, 1)
plt.plot(x, y)
plt.grid()
plt.subplot(1, 3, 2)
plt.plot(x, y)
plt.grid()
plt.xlim(1.7, 2.3)
plt.ylim(5, 10)
plt.subplot(1, 3, 3)
plt.plot(x, y)
plt.grid()
plt.xlim(1.92, 2.08)
plt.ylim(6.6, 8.2)
plt.tight_layout()
plt.show()

np.exp(1)

np.exp(0.01)

#18-3

import numpy as np

exp = 0
x = 2
for i in range(10):
    exp = exp + \
       ((x**i)/np.math.factorial(i))
    print(f'Using {i}-term, {exp}')
    
print(f'The true e^2 is: \n{np.exp(2)}')

abs(7.3887125220458545-np.exp(2))

exp = 0
x = -30
for i in range(200):
    exp = exp + \
       ((x**i)/np.math.factorial(i))
    
print(f'Using {i}-term, our result is {exp}')    
print(f'The true e^2 is: {np.exp(x)}')

