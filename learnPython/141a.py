#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  2 11:36:53 2022

@author: user
"""
#A
import numpy as np
vector_row =np.array([[1,-5,3,2,4]])
vector_column = np.array([[1],
                          [2],
                          [3],
                          [4]])
print(vector_row.shape)
print(vector_column.shape)

#B
from numpy.linalg import norm
new_vector = vector_row.T
print(new_vector)
norm_1 = norm(new_vector,1)
norm_2 = norm(new_vector,2)
norm_inf = norm(new_vector, np.inf)
print('L_1 is: %.1f'%norm_1)
print('L_2 is: %.1f'%norm_2)
print('L_inf is: %.1f'%norm_inf)

#C
from numpy import arccos, dot
v = np.array([[10, 9, 3]])
w = np.array([[2, 5, 12]])
theta = \
    arccos(dot(v,w.T)/(norm(v)*norm(w)))
print(theta)

#D
v = np.array([[0, 2, 0]])
w = np.array([[3, 0, 0]])
print(np.cross(v,w))

#E
v = np.array([[0, 3, 2]])
w = np.array([[4, 1, 1]])
u = np.array([[0, -2, 0]])
x = 3*v - 2*w + 4*u
print (x)


a = np.array([[1],[0.001]])
b = np.array([[0.001],[1]])
w = np.array([[2, 5, 12]])
theta = \
    arccos(dot(a,b.T)/(norm(a)*norm(b)))
print("test theta print")
print(theta)