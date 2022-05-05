#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  2 14:06:12 2022

@author: user
"""

#14.5 solve systems of linear equations in Python 
import numpy as np

A = np.array([[4,3,-5],
              [-2,-4,5],
              [8,8,0]])
y=np.array([2,5,-3])

x = np.linalg.solve(A,y)
print(x)

#B
#solve using matrix inversion
from numpy.linalg import inv
A_inv= np.linalg.inv(A)
x = np.dot(A_inv,y)
print(x)

#get L U from A
from scipy.linalg import lu

P, L, U = lu(A)
print('P:\n', P)
print('L:\n', L)
print('U:\n', U)

print('LU:\n',np.dot(L,U))

print(np.dot(P, A))

#problem set 2
from numpy import arccos, dot
from numpy.linalg import norm
pi=3.14159
def my_is_orthogonal(v1,v2,tol):
    theta = \
        arccos(dot(v1.T,v2)/(norm(v1.T)*norm(v2.T)))
    print(theta)
    result = 0 # when angle theta from pi/2 is greater than tol
    if abs((pi/2)-theta) < tol:
        result = 1
    print(result)
    return result
# problem 2 Test cases
a = np.array([[1],[0.001]])
b = np.array([[0.001],[1]])
my_is_orthogonal(a,b,0.01)

a = np.array([[1],[0.001]])
b = np.array([[0.001],[1]])
my_is_orthogonal(a,b,0.0001)

a = np.array([[1],[0.001]])
b = np.array([[1],[1]])
my_is_orthogonal(a,b,0.01)

a = np.array([[1],[1]])
b = np.array([[-1],[1]])
my_is_orthogonal(a,b,0.01)