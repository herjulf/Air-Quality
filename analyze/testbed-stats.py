"""
File format:

DATE TIME SLB            N63A7             N8554
DATE TIME NO2 PM2.5 PM10 NO2 A2 PM2.5 PM10 NO2 A2 PM2.5 PM10
"""

import pandas as pd
import matplotlib.pyplot as mplt
import statsmodels.api as sm
import numpy as np
import matplotlib.pyplot as plt

df=pd.read_csv(r'testbed-stats.dat', sep='\s+',header=None,names=['date','time', 'slb-no2','slb-pm2.5', 'slb-pm10','63a7-no2','63a7-a2','63a7-pm2.5','63a7-pm10','8554-no2','8554-a2','8554-pm2.5','8554-pm10'])

def scatter_plot_with_correlation_line(x, y, title, graph_filepath):

    X = df[x]
    Y = df[y]

    results = sm.OLS(Y,sm.add_constant(X)).fit()
    print results.summary()
    fig = plt.figure()
    fig.suptitle(title, fontsize=20)
    plt.xlabel(x, fontsize=18)
    plt.ylabel(y, fontsize=16)
    plt.scatter(X,Y)
    plt.plot(X, np.poly1d(np.polyfit(X, Y, 1))(X))

    fig.savefig(title+'.jpg')
    plt.show()

def main():
    # Plot
    scatter_plot_with_correlation_line('slb-pm2.5', '63a7-pm2.5', "SLB-KTH PM2.5 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-no2', '63a7-no2', "SLB-KTH NO2 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-no2', '63a7-a2', "SLB-KTH-A2 NO2 Comparison", 'scatter_plot.png')

if __name__ == "__main__":
    main()
