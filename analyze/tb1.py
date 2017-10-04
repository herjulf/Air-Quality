"""
File format:

TIME NO2 PM2.5 PM10 63a7_no2 63a7_pm2_5 63a7_pm10 63a7_pm2_5_db 63a7_pm10_db 63a7_pm2_5_db_corr 63a7_pm10_db_corr 856b_no2 856b_pm2_5 856b_pm10 856b_pm2_5_db 856b_pm10_db 856b_pm2_5_db_corr 856b_pm10_db_corr 63a7_temp 63a7_RH 856b_temp 856b_RH 63a7_a2 856b_a2
"""

import pandas as pd
import matplotlib.pyplot as mplt
import statsmodels.api as sm
import numpy as np
import matplotlib.pyplot as plt


df=pd.read_csv(r'avg_data.dat', comment='#', sep='\s+',header=None,names=['utime', 'slb-no2', 'slb-pm2.5', 'slb-pm10', '63a7_no2', '63a7_pm2.5', '63a7_pm10', '63a7_pm2.5_db', '63a7_pm10_db', '63a7_pm2.5_db_corr', '63a7_pm10_db_corr', '856b_no2', '856b_pm2.5', '856b_pm10', '856b_pm2.5_db', '856b_pm10_db', '856b_pm2.5_db_corr', '856b_pm10_db_corr', '63a7_temp', '63a7_RH', '856b_temp','856b_RH', '63a7_a2', '856b_a2' ])

df.dropna(inplace=True)
# summarize the number of rows and columns in the dataset
print(df.shape)

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

    scatter_plot_with_correlation_line('slb-pm2.5', '63a7_pm2.5', "SLB-KTH 63a7 PM2.5 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-pm2.5', '63a7_pm2.5_db', "SLB-KTH 63a7 DB PM2.5 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-pm2.5', '856b_pm2.5', "SLB-KTH 856b PM2.5 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-pm2.5', '856b_pm2.5_db', "SLB-KTH 856b DB PM2.5 Comparison", 'scatter_plot.png')

    scatter_plot_with_correlation_line('slb-pm10', '63a7_pm10', "SLB-KTH 63a7 PM10 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-pm10', '63a7_pm10_db', "SLB-KTH 63a7 DB PM10 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-pm10', '856b_pm10', "SLB-KTH 856b PM10 Comparison", 'scatter_plot.png')
    scatter_plot_with_correlation_line('slb-pm10', '856b_pm10_db', "SLB-KTH 856b DB PM10 Comparison", 'scatter_plot.png')

def plot_no2():
    scatter_plot_with_correlation_line('slb-no2', '63a7_a2', "SLB-KTH NO2 63a7 Comparison", 'scatter_plot.png')

if __name__ == "__main__":
#    plot_no2()
    main()

