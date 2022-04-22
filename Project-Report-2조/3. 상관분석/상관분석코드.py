# -*- coding: utf-8 -*-
"""
Created on Sat Jun 20 11:43:08 2020

@author: lee_j
"""

import pandas as pd

data1 = pd.read_csv('지역별감염_상관분석.csv')
print(data1)

del data1['지역코드']

corr = data1.corr(method = 'pearson')

#상관분석 결과 출력
print(corr)

dropnan = data1.dropna(axis = 0)
import scipy.stats as stats
corr1 = stats.pearsonr(dropnan.대학교수 ,dropnan.확진자수)
corr2 = stats.pearsonr(dropnan.양로원수 ,dropnan.확진자수)
corr3 = stats.pearsonr(dropnan.유치원수 ,dropnan.확진자수)
print("\n\n(상관계수, p-value)")
print("1. 확진자 수 : 대학교 수")
print(corr1)
print("2. 확진자 수 : 양로원 수")
print(corr2)
print("3. 확진자 수 : 유치원 수")
print(corr3)
