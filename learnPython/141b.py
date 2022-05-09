#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  2 13:34:50 2022

@author: user
"""

#14.1 Basics B - Matrices
import numpy as np
P = np.array([[1,7],[2,3],[5,0]])
Q = np.array([[2,6,3,1],[1,2,3,4]])
print(P)
print(Q)
print(np.dot(P, Q))
#np.dot(Q,P)  //has to comment out this line, otherwise rest do not run

#B
from numpy.linalg import det
M = np.array([[0,2,1,3],
              [3,2,8,1],
              [1,0,0,3],
              [0,3,2,1]])
print('M:\n',M)

print('Determinant: %1f'%det(M))
I = np.eye(4)
print('I:\n', I)
print('M*I:\n',np.dot(M,I))

#C
from numpy.linalg import inv
print('Inv M:\n', inv(M))

P = np.array([[0,1,0],
              [0,0,0],
              [1,0,1]])
print('det(P):\n', det(P))

#D
from numpy.linalg import \
            cond, matrix_rank

A = np.array([[1,1,0],
              [0,1,0],
              [1,0,1]])

print('Condition number:\n', cond(A))
print('Rank:\n', matrix_rank(A))
y = np.array([[1],[2],[1]])
A_y = np.concatenate((A, y), axis = 1)
print('Augmented matrix:\n', A_y)

#14.5 solve systems of linear equations in Python 

A = np.array([[4,3,-5],
              [-2,-4,5],
              [8,8,0]])
y=np.array([2,5,-3])

x = np.linalg.solve(A,y)
print(x)

#B
#solve using matrix inversion
A_inv = np.linalg.inv(A)
x = np.dot(A_inv. y)
print(x)